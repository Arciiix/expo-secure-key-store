package expo.modules.securekeystore

object Constants {

  // Keystore providers (kept for compatibility / future use)
  const val KEYSTORE_PROVIDER_1 = "AndroidKeyStore"
  const val KEYSTORE_PROVIDER_2 = "AndroidKeyStoreBCWorkaround"
  const val KEYSTORE_PROVIDER_3 = "AndroidOpenSSL"

  const val RSA_ALGORITHM = "RSA/ECB/PKCS1Padding"
  const val AES_ALGORITHM = "AES/ECB/PKCS5Padding"

  const val TAG = "SecureKeyStore"

  // Internal storage
  const val SKS_KEY_FILENAME = "SKS_KEY_FILE"
  const val SKS_DATA_FILENAME = "SKS_DATA_FILE"
}
