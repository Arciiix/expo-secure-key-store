# Expo Secure Key Store

This package provides an Expo-compatible implementation of [react-native-secure-key-store](https://github.com/pradeep1991singh/react-native-secure-key-store), designed to ensure backwards compatibility while leveraging modern React Native APIs.

The original library was written in Java and Objective-C, and does not support the Expo managed workflow and lacks autolinking capabilities. To address these limitations, this package has been rewritten with Swift and Kotlin, using updated APIs and ensuring full Expo compatibility.

# Why not expo-secure-store? Why was this package created?

[expo-secure-store](https://docs.expo.dev/versions/latest/sdk/securestore/) is a great library for secure storage and is the recommended choice.

However, if you have an existing codebase that relies on `react-native-secure-key-store` and you want to migrate to Expo without rewriting all the storage-related code and, most importantly, **without losing users' data**, this package serves as a drop-in replacement, allowing you to maintain your existing code while benefiting from Expo's managed workflow.

# Usage

> Usage is identical to `react-native-secure-key-store`. Please refer to the [original documentation](https://github.com/pradeep1991singh/react-native-secure-key-store/blob/master/README.md)

Using modern async/await syntax:

```javascript
import RNSecureKeyStore, { ACCESSIBLE } from "expo-secure-key-store";
// Store key
try {
  const res = await RNSecureKeyStore.set("key1", "value1", {
    accessible: ACCESSIBLE.ALWAYS_THIS_DEVICE_ONLY,
  });
  console.log(res);
} catch (err) {
  console.log(err);
}

// Retrieve key
try {
  const res = await RNSecureKeyStore.get("key1");
  console.log(res);
} catch (err) {
  console.log(err);
}
// Remove key
try {
  const res = await RNSecureKeyStore.remove("key1");
  console.log(res);
} catch (err) {
  console.log(err);
}
```

or, the Promise-based API example below:

```javascript
import RNSecureKeyStore, { ACCESSIBLE } from "expo-secure-key-store";

// Store key
RNSecureKeyStore.set("key1", "value1", {
  accessible: ACCESSIBLE.ALWAYS_THIS_DEVICE_ONLY,
}).then(
  (res) => {
    console.log(res);
  },
  (err) => {
    console.log(err);
  }
);

// Retrieve key
RNSecureKeyStore.get("key1").then(
  (res) => {
    console.log(res);
  },
  (err) => {
    console.log(err);
  }
);

// Remove key
RNSecureKeyStore.remove("key1").then(
  (res) => {
    console.log(res);
  },
  (err) => {
    console.log(err);
  }
);
```

# Demo

There is also a demo app included in the `example` folder.
