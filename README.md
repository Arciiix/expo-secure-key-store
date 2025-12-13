# Expo Secure Key Store

This package provides an Expo-compatible implementation of [react-native-secure-key-store](https://github.com/pradeep1991singh/react-native-secure-key-store), designed to ensure backwards compatibility while leveraging modern React Native APIs.

The original library was written in Java and Objective-C, and does not support the Expo managed workflow and lacks autolinking capabilities. To address these limitations, this package has been rewritten with Swift and Kotlin, using updated APIs and ensuring full Expo compatibility.

# Why not expo-secure-store? Why was this package created?
[expo-secure-store](https://docs.expo.dev/versions/latest/sdk/securestore/) is a great library for secure storage and is the recommended choice. 

However, if you have an existing codebase that relies on `react-native-secure-key-store` and you want to migrate to Expo without rewriting all the storage-related code, this package serves as a drop-in replacement, allowing you to maintain your existing code while benefiting from Expo's managed workflow.