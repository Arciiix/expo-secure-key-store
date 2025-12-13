import { NativeModule, requireNativeModule } from 'expo';

import { ExpoSecureKeyStoreModuleEvents } from './ExpoSecureKeyStore.types';

declare class ExpoSecureKeyStoreModule extends NativeModule<ExpoSecureKeyStoreModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoSecureKeyStoreModule>('ExpoSecureKeyStore');
