package expo.modules.securekeystore

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import java.net.URL
import android.content.Context
import android.content.SharedPreferences
import android.os.Build
import android.util.Log
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKeys
import java.io.FileNotFoundException
import java.security.GeneralSecurityException

class ExpoSecureKeyStoreModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("ExpoSecureKeyStore")

  AsyncFunction("set") { alias: String, value: String, options: Map<String, Any>? ->
      try {
        getSecureSharedPreferences()
          .edit()
          .putString(alias, value)
          .commit()

        "stored ciphertext in app storage"
      } catch (e: Exception) {
        Log.e(Constants.TAG, "Exception", e)
        throw SecureKeyStoreException(
          code = "9",
          message = e.message ?: "Unknown error"
        )
      }
    }

    AsyncFunction("get") { alias: String ->
      try {
        val value = getSecureSharedPreferences().getString(alias, null)

        if (value == null) {
          throw FileNotFoundException("$alias has not been set")
        }

        value
      } catch (e: FileNotFoundException) {
        throw SecureKeyStoreException(
          code = "404",
          message = e.message ?: "Key not found"
        )
      } catch (e: Exception) {
        Log.e(Constants.TAG, "Exception", e)
        throw SecureKeyStoreException(
          code = "1",
          message = e.message ?: "Unknown error"
        )
      }
    }

    AsyncFunction("remove") { alias: String ->
      try {
        getSecureSharedPreferences()
          .edit()
          .remove(alias)
          .commit()

        "cleared alias"
      } catch (e: Exception) {
        Log.e(Constants.TAG, "Exception", e)
        throw SecureKeyStoreException(
          code = "6",
          message = e.message ?: "Unknown error"
        )
      }
    }
  }

  // MARK: - Secure SharedPreferences

  private fun getSecureSharedPreferences(): SharedPreferences {
    val context = appContext.reactContext ?: throw IllegalStateException("Missing context")

    return EncryptedSharedPreferences.create(
      "secret_shared_prefs",
      MasterKeys.getOrCreate(MasterKeys.AES256_GCM_SPEC),
      context,
      EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
      EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
    )
  }
}
