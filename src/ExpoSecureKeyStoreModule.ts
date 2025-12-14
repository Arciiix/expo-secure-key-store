import { NativeModule, requireNativeModule } from "expo";
import { ExpoSecureKeyStoreModuleEvents } from "./ExpoSecureKeyStore.types";

declare class ExpoSecureKeyStoreModule extends NativeModule<ExpoSecureKeyStoreModuleEvents> {
  set: (
    key: string,
    value: string,
    options?: Record<string, any>
  ) => Promise<string>;
  get: (key: string) => Promise<string>;
  delete: (key: string) => Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoSecureKeyStoreModule>(
  "ExpoSecureKeyStore"
);
