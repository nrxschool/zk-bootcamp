---
marp: true
theme: gaia
---

# **Aula 1: Introdução à Criptografia**

- data: 05/05
- prof: Lucas Oliveira

## **1. Abertura**

**Hello World!**

Sejam todos bem-vindos ao GRANDE CÓDIGO.

Bootcamp/Hackathon/Incubação da NearX

Sua porta de entrada para o ecossistema blockchain/web3 e provas ZK.

Hoje vou te ensinar os fundamentos de segurança de blockchain

---

## **2. Programação**

1. **Códificação**: base58 e base64
2. **Identificação**: Funções de Hash
3. **Encriptação**: AES-128
4. **Autentificação**: Assinaturas digitais

---

## **3. Códificação**

- Base58: É um sistema de codificação utilizado para tornar dados binários legíveis em texto. Elimina caracteres ambíguos como 0, O, l, I para evitar confusões.
- Base64: Mais comum em aplicações web, é usada para transmitir dados binários por canais de texto.
- Blockchains que usam Base58: Bitcoin (endereços)
- Blockchains que usam Base64: Solana (endereços e transações codificadas)

```bash
npm install bs58
```

```js
// Exemplo de codificação Base58
const bs58 = require("bs58");
const encoded = bs58.encode(Buffer.from("Lucas"));
console.log(encoded);

// Exemplo de decodificação Base58
const decoded = bs58.decode(encoded);
const decodedMsg = String.fromCharCode(...decoded);
console.log(decodedMsg);
```

---

## **4. Identificação**

- Funções de Hash: Algoritmos unidirecionais que transformam dados de qualquer tamanho em uma saída fixa. São a "impressão digital" da informação.
- SHA-256: Usado por blockchains como Bitcoin.
- Keccak-256 (SHA3): Usado por Ethereum.

```bash
npm install keccak256
```

```js
// Exemplo de hash com Keccak e SHA256
const crypto = require("crypto");
const keccak256 = require("keccak256");

const msg = "Lucas";
console.log("SHA256:", crypto.createHash("sha256").update(msg).digest("hex"));
console.log("Keccak256:", keccak256(msg).toString("hex"));
```

---

## **5. Encriptação**

- AES-128: Algoritmo simétrico de criptografia amplamente usado, inclusive em keystores de carteiras.
- Casos de uso: Armazenamento seguro de chaves privadas no navegador ou arquivos de backup (.json)

```js
// Exemplo simples com AES-128
const crypto = require("crypto");

// Gerando uma chave aleatória de 16 bytes
const key = crypto.randomBytes(16);
// Gerando um vetor de inicialização aleatório de 16 bytes
const iv = crypto.randomBytes(16);

// Mensagem a ser encriptada
const msg = "Lucas";
// Criando um objeto de cifra com a chave e o vetor de inicialização
const cipher = crypto.createCipheriv("aes-128-cbc", key, iv);
// Atualizando a cifra com a mensagem
let encrypted = cipher.update(msg, "utf8", "hex");

// Finalizando a cifra e adicionando o resultado à mensagem encriptada
encrypted += cipher.final("hex");
// Imprimindo a mensagem encriptada
console.log("Mensagem encriptada:", encrypted);

// Decriptando a mensagem
const decipher = crypto.createDecipheriv("aes-128-cbc", key, iv);
let decrypted = decipher.update(encrypted, "hex", "utf8");
decrypted += decipher.final("utf8");

// Imprimindo a mensagem decriptada
console.log("Mensagem decriptada:", decrypted);
```

---

## **6. Autentificação**

- Criptografia de chave pública (PKC): Base da autenticação em blockchain.
- secp256k1: Usado por Bitcoin, Ethereum.
- secp256r1: Padrão WebAuthn/Passkey – muito usado no Google/Github/Apple e algumas blockchains.

```js
const { generateKeyPairSync, createSign, createVerify } = require("crypto");

// 1. Gerar par EC
const { privateKey, publicKey } = generateKeyPairSync("ec", {
  namedCurve: "secp256k1",
  publicKeyEncoding: { type: "spki", format: "pem" },
  privateKeyEncoding: { type: "sec1", format: "pem" },
});

// 2. Mensagem para assinar
const message = "Dados críticos que precisam de assinatura";

// 3. Criar e verificar assinatura
const sign = createSign("sha256");
sign.update(message);
const signature = sign.sign(privateKey, "hex");

console.log("Assinatura:", signature);

// Verificação
const verify = createVerify("sha256");
verify.update(message);
const isValid = verify.verify(publicKey, signature, "hex");

console.log("Assinatura válida?", isValid);
```

---

## **9. Recapitulação:**

- Hoje vimos os fundamentos da segurança criptográfica no mundo blockchain:
- Como representamos dados (Base58/Base64)
- Como garantimos integridade (Hash)
- Como protegemos segredos (AES)
- Como provamos identidade (Assinaturas Digitais)

---

## **10. Lição de Casa**

### Desafio de Aprendizagem

1. Escrever um artigo de blog explicando, com suas palavras o que aprendeu hoje.

### Desafio de Carreira

2. Post no Linkedin #zknearx (6/10)

### Desafio de Comunidade

3. 😀 Poste o seu emoji mais usado (discord)

---

## **11. Próxima Aula**

**06/05 – ZkVerify 101**

- Vamos mergulhar mais fundo em arquiteturas de blockchain para entender o que é a ZKVerify

_"Não esqueça: Aula ao vivo amanhã, 19h, no YouTube. Traga suas dúvidas!"_
