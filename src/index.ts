// Reexport the native module. On web, it will be resolved to ExpoSecureKeyStoreModule.web.ts
// and on native platforms to ExpoSecureKeyStoreModule.ts
export { default } from './ExpoSecureKeyStoreModule';
export * from  './ExpoSecureKeyStore.types';
