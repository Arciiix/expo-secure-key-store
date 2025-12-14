import ExpoModulesCore
import Security
import Foundation

public class ExpoSecureKeyStoreModule: Module {
  private let serviceName = "RNSecureKeyStoreKeyChain"
  private let isInstalledKey = "RnSksIsAppInstalled"
  private var resetOnAppUninstall: Bool = true

  public func definition() -> ModuleDefinition {
    Name("ExpoSecureKeyStore")

    AsyncFunction("setResetOnAppUninstallTo") { (enabled: Bool) in
      self.resetOnAppUninstall = enabled
    }

    AsyncFunction("set") { (key: String, value: String, options: [String: Any]?) -> String in
      self.handleAppUninstallation()

      if self.createKeychainValue(value: value, identifier: key, options: options) {
        return "key stored successfully"
      }

      if self.updateKeychainValue(value: value, identifier: key, options: options) {
        return "key updated successfully"
      }

      throw SecureKeyStoreError("error saving key")
    }

    AsyncFunction("get") { (key: String) -> String in
      self.handleAppUninstallation()

      guard let value = self.searchKeychainCopyMatching(identifier: key) else {
        throw SecureKeyStoreError("key is not present", code: "404")
      }

      return value
    }

    AsyncFunction("remove") { (key: String) -> String in
      if self.deleteKeychainValue(identifier: key) {
        return "key removed successfully"
      }

      throw SecureKeyStoreError("could not delete key", code: "6")
    }
  }
}

extension ExpoSecureKeyStoreModule {

  private func newSearchDictionary(identifier: String) -> [String: Any] {
    let encodedIdentifier = identifier.data(using: .utf8)!

    return [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrGeneric as String: encodedIdentifier,
      kSecAttrAccount as String: encodedIdentifier,
      kSecAttrService as String: serviceName
    ]
  }

  private func searchKeychainCopyMatching(identifier: String) -> String? {
    var query = newSearchDictionary(identifier: identifier)
    query[kSecMatchLimit as String] = kSecMatchLimitOne
    query[kSecReturnData as String] = kCFBooleanTrue

    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)

    guard status == errSecSuccess,
          let data = result as? Data else {
      return nil
    }

    return String(data: data, encoding: .utf8)
  }

  private func createKeychainValue(value: String, identifier: String, options: [String: Any]?) -> Bool {
    var dictionary = newSearchDictionary(identifier: identifier)
    dictionary[kSecValueData as String] = value.data(using: .utf8)
    dictionary[kSecAttrAccessible as String] = accessibleValue(options)

    let status = SecItemAdd(dictionary as CFDictionary, nil)
    return status == errSecSuccess
  }

  private func updateKeychainValue(value: String, identifier: String, options: [String: Any]?) -> Bool {
    let searchDictionary = newSearchDictionary(identifier: identifier)
    let updateDictionary: [String: Any] = [
      kSecValueData as String: value.data(using: .utf8)!,
      kSecAttrAccessible as String: accessibleValue(options)
    ]

    let status = SecItemUpdate(
      searchDictionary as CFDictionary,
      updateDictionary as CFDictionary
    )

    return status == errSecSuccess
  }

  private func deleteKeychainValue(identifier: String) -> Bool {
    let query = newSearchDictionary(identifier: identifier)
    let status = SecItemDelete(query as CFDictionary)
    return status == errSecSuccess
  }

  private func clearSecureKeyStore() {
    let secItemClasses: [CFTypeRef] = [
      kSecClassGenericPassword,
      kSecClassKey
    ]

    for secItemClass in secItemClasses {
      let spec = [kSecClass as String: secItemClass]
      SecItemDelete(spec as CFDictionary)
    }
  }

  private func handleAppUninstallation() {
    let defaults = UserDefaults.standard

    if resetOnAppUninstall && !defaults.bool(forKey: isInstalledKey) {
      clearSecureKeyStore()
      defaults.set(true, forKey: isInstalledKey)
      defaults.synchronize()
    }
  }

  private func accessibleValue(_ options: [String: Any]?) -> CFString {
    guard let key = options?["accessible"] as? String else {
      return kSecAttrAccessibleAfterFirstUnlock
    }

    let map: [String: CFString] = [
      "AccessibleWhenUnlocked": kSecAttrAccessibleWhenUnlocked,
      "AccessibleAfterFirstUnlock": kSecAttrAccessibleAfterFirstUnlock,
      "AccessibleAlways": kSecAttrAccessibleAlways,
      "AccessibleWhenPasscodeSetThisDeviceOnly": kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
      "AccessibleWhenUnlockedThisDeviceOnly": kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
      "AccessibleAfterFirstUnlockThisDeviceOnly": kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly,
      "AccessibleAlwaysThisDeviceOnly": kSecAttrAccessibleAlwaysThisDeviceOnly
    ]

    return map[key] ?? kSecAttrAccessibleAfterFirstUnlock
  }
}

// MARK: - Errors

struct SecureKeyStoreError: Error {
  let message: String
  let code: String

  init(_ message: String, code: String = "9") {
    self.message = message
    self.code = code
  }
}

extension SecureKeyStoreError: CustomStringConvertible {
  var description: String {
    return message
  }
}
