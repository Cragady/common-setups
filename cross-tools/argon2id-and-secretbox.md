# argon2id + secretbox

This was taken from google's AI overview.

## Overview
**Combining Argon2id and Secretbox** is a highly secure, industry-standard pattern used for **encrypting data with a password**.

In this cryptographic pipeline, **Argon2id** acts as the Key Derivation Function (KDF) to turn a human-readable password into a strong cryptographic key, while **Secretbox** (from the NaCl/libsodium library) acts as the authenticated encryption mechanism to encrypt and protect the data.

### 📦 How the Components Work Together

```
[ Password ] + [ Salt ] 
       │
       ▼
  ( Argon2id )  <--- Slow, memory-hard hashing
       │
       ▼
 [ 32-Byte Key ] + [ Nonce ] + [ Message ]
       │
       ▼
  ( Secretbox ) <--- Fast, authenticated encryption (XSalsa20-Poly1305)
       │
       ▼
 [ Ciphertext + Authentication Tag ]
```

### 1. Argon2id (Key Derivation)

Secretbox requires a mathematically random, 32-byte key. Because human passwords are predictable and low-entropy, you cannot plug them directly into Secretbox.

* **The Role:** Argon2id securely stretches your password into a high-entropy 32-byte key.
* **The Defense:** It is a memory-hard function, meaning it deliberately uses a configurable amount of RAM and CPU time. This makes it incredibly expensive for attackers to run brute-force attacks using specialized hardware like GPUs or ASICs.

### 2. Secretbox (Authenticated Encryption)

Secretbox uses **XSalsa20** for encryption and **Poly1305** for authentication.

* **The Role:** It encrypts your data so it cannot be read without the key, and it attaches an authentication tag (MAC).
* **The Defense:** The authentication tag ensures **tamper resistance**. If an attacker alters even a single bit of the encrypted file, Secretbox will detect it during decryption and throw an error instead of returning corrupted data.

### 🛠️ Standard Implementation Workflow

To implement this combination safely, follow these exact steps:

#### Encryption Process

1. **Generate a random 16-byte Salt** for Argon2id. (Never reuse a salt for different passwords).
2. **Generate a random 24-byte Nonce** for Secretbox. (Never reuse a nonce with the same key).
3. **Derive the 32-byte key** by passing the password and the salt into Argon2id.
4. **Encrypt the message** using Secretbox, passing in the message, the 24-byte nonce, and the derived 32-byte key.
5. **Package the output**. You must save the **Salt**, the **Nonce**, and the **Ciphertext** together. Without the salt and nonce, you cannot decrypt the data later.

#### Decryption Process

1. **Extract** the Salt, Nonce, and Ciphertext from your package.
2. **Re-derive the 32-byte key** by passing the user's password and the extracted Salt into Argon2id (using the exact same parameters as before).
3. **Decrypt the ciphertext** using Secretbox, passing in the ciphertext, the extracted Nonce, and the re-derived key.

### ⚙️ Recommended Argon2id Parameters

To ensure strong security against modern hardware, use the current libsodium "interactive" or "moderate" profile presets:

* **Ops Limit (Time):** `3` passes over memory.
* **Mem Limit (RAM):** `64 MB` (67,108,864 bytes) to `256 MB`. Adjust based on your target system's resources (e.g., lower for mobile/embedded devices, higher for servers).

To help you implement this safely, could you tell me **what programming language** you are using (e.g., Python, Node.js, Go)? I can provide a copy-pasteable, secure code example using standard `libsodium` bindings.
