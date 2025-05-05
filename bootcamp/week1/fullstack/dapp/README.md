# 💸 Web3 Token dApp

Este é um projeto simples que demonstra como integrar um app Web2 com Web3 usando React, Vite, wagmi e viem. Ele permite:

- Conectar à MetaMask
- Ler o nome de um token ERC-20
- Ler o saldo de tokens da carteira conectada
- Enviar uma transação para mintar novos tokens
- Enviar uma transação para transferir tokens

# ✅ PASSO A PASSO

## 1. Criar projeto

```bash
npm create vite@latest my-dapp -- --template react
npm install
```

## 2. Instalar dependências

```bash
npm install viem wagmi @tanstack/react-query
```

## 3. Rodar Hello World!

```bash
npm run dev
```

## 4. Estrutura do Projeto

### Pastas

```bash
.
├── public/                 # Arquivos estáticos
├── src/
│   ├── ...
│   ├── App.tsx            # Componente principal
│   ├── main.jsx           # Entry point
├── ...
└── README.md
```

### `App.tsx`

```js
import React from "react";

function App() {
  return (
    <>
      <h1>Hello World</h1>
    </>
  );
}

export default App;
```
