import { useState } from "react";
import { Button, StyleSheet, Text, TextInput, View, Alert } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";

// Native module exposed by Expo
import SecureKeyStore from "expo-secure-key-store";

export default function App() {
  const [key, setKey] = useState("demo-key");
  const [value, setValue] = useState("secret-value");
  const [result, setResult] = useState<string | null>(null);

  const onSet = async () => {
    try {
      const res = await SecureKeyStore.set(key, value, {
        accessible: "AccessibleAfterFirstUnlock",
      });
      setResult(res);
    } catch (e: any) {
      Alert.alert("Set error", e.message ?? String(e));
    }
  };

  const onGet = async () => {
    try {
      const res = await SecureKeyStore.get(key);
      setResult(res);
    } catch (e: any) {
      Alert.alert("Get error", e.message ?? String(e));
    }
  };

  const onRemove = async () => {
    try {
      const res = await SecureKeyStore.remove(key);
      setResult(res);
    } catch (e: any) {
      Alert.alert("Remove error", e.message ?? String(e));
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>SecureKeyStore Test</Text>

      <View style={styles.inputGroup}>
        <Text>Key</Text>
        <TextInput style={styles.input} value={key} onChangeText={setKey} />
      </View>

      <View style={styles.inputGroup}>
        <Text>Value</Text>
        <TextInput style={styles.input} value={value} onChangeText={setValue} />
      </View>

      <View style={styles.buttons}>
        <Button title="Set" onPress={onSet} />
        <Button title="Get" onPress={onGet} />
        <Button title="Remove" onPress={onRemove} />
      </View>

      {result && (
        <View style={styles.result}>
          <Text style={styles.resultTitle}>Result</Text>
          <Text>{result}</Text>
        </View>
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 24,
    gap: 16,
  },
  title: {
    fontSize: 24,
    fontWeight: "600",
  },
  inputGroup: {
    gap: 4,
  },
  input: {
    borderWidth: 1,
    borderColor: "#ccc",
    padding: 10,
    borderRadius: 6,
  },
  buttons: {
    flexDirection: "row",
    justifyContent: "space-between",
    marginTop: 12,
  },
  result: {
    marginTop: 24,
    padding: 12,
    backgroundColor: "#eee",
    borderRadius: 6,
  },
  resultTitle: {
    fontWeight: "600",
    marginBottom: 4,
  },
});
