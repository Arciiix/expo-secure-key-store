package expo.modules.securekeystore

import expo.modules.kotlin.exception.CodedException

class SecureKeyStoreException(
  code: String,
  message: String,
  cause: Throwable? = null
) : CodedException(
  code,
  cause
) {
  override val message: String =
    "{\"code\":$code,\"api-level\":${android.os.Build.VERSION.SDK_INT},\"message\":\"$message\"}"
}