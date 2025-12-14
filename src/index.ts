// Reexport the native module. On web, it will be resolved to ExpoSecureKeyStoreModule.web.ts
// and on native platforms to ExpoSecureKeyStoreModule.ts
export { default } from "./ExpoSecureKeyStoreModule";
export * from "./ExpoSecureKeyStore.types";

export const ACCESSIBLE = {
  WHEN_UNLOCKED: "AccessibleWhenUnlocked",
  AFTER_FIRST_UNLOCK: "AccessibleAfterFirstUnlock",
  ALWAYS: "AccessibleAlways",
  WHEN_PASSCODE_SET_THIS_DEVICE_ONLY: "AccessibleWhenPasscodeSetThisDeviceOnly",
  WHEN_UNLOCKED_THIS_DEVICE_ONLY: "AccessibleWhenUnlockedThisDeviceOnly",
  AFTER_FIRST_UNLOCK_THIS_DEVICE_ONLY:
    "AccessibleAfterFirstUnlockThisDeviceOnly",
  ALWAYS_THIS_DEVICE_ONLY: "AccessibleAlwaysThisDeviceOnly",
};
