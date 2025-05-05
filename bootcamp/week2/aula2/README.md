---
marp: true
theme: gaia
---

# **Aula 2: ZkVerify 101**

- data: 06/05
- prof: Lucas Oliveira

## **1. Abertura**

**Hello World!**

Sejam todos bem-vindos ao GRANDE CÓDIGO.

Bootcamp/Hackathon/Incubação da NearX

Sua porta de entrada para o ecossistema blockchain/web3 e provas ZK.

Hoje você vai aprender o que é o ZkVerify e por que ele resolve um problema real da Web3 moderna.

---

## **2. Programação**

1. **Casos de uso de Provas ZK**
2. **Problemas das Arquiteturas Web3-ZK 2025**
3. **Solução com ZkVerify**

---

## **3. Casos de uso de Provas ZK**

- **Caso 1: Verificação de identidade sem expor dados**

Usuário prova que tem uma conta verificada em um serviço (como o GOV.br) sem revelar CPF, nome ou e-mail.

- **Caso 2: Prova de solvência de exchanges**

Uma exchange pode provar que tem mais ativos do que passivos _sem revelar valores_ nem endereços das carteiras.

- **Caso 3: Provar que você é maior de idade sem mostrar sua data de nascimento**

O usuário envia uma prova que comprova que sua idade é ≥ 18, mas a data de nascimento continua privada.

---

## **4. Problemas das Arquiteturas Web3-ZK 2025**

- **Provas ZK são pesadas**

Criar e verificar uma prova ainda é caro em tempo e energia computacional.

- **Curvas criptográficas incompatíveis com a EVM**

A EVM foi feita com `secp256k1`, mas muitas provas ZK exigem curvas como BLS12-381, que não são nativamente suportadas.

- **Rollups ZK exigem customizações**

Arquiteturas L2 precisam adaptar sua infraestrutura para processar e validar provas ZK — o que aumenta a complexidade e o custo.

---

## **5. Solução com ZkVerify**

### **Stack**

Lang: Rust
Framework: Polkadot SDK
Consensus: PoS (BABE & GRAMP)
Wallets: Talisman, SubWallet
Fullnodes: RPC nodes, Boot nodes, Validator nodes
ProvasZK: Groth16, UltraPlonk, Risc0, Plonky2, Proof of SQL

---

## **6. Hands-on**

1. Subir um node
2. Criar wallets de testes
3. Transferir Token entre wallets
---

## **9. Recapitulação:**

- Hoje você aprendeu sobre:
  - O que são provas de conhecimento zero (ZK)
  - Três casos de uso reais de ZK no mercado atual
  - Por que a EVM e os rollups enfrentam desafios técnicos com ZK
  - Como o ZkVerify propõe resolver esses problemas de forma prática

---

## **10. Lição de Casa**

### Desafio de Aprendizagem

1. Suba um node ZkVerify na sua máquina (use a doc oficial)

### Desafio de Carreira

2. Faça um post no LinkedIn com o que você aprendeu e marque com #zknearx (6/10)

### Desafio de Comunidade

3. 🕹️ Poste no Discord uma foto do jogo mais jogado (ou favorito) de 2025

---

## **11. Próxima Aula**

**07/05 – Provas ZK 101**

- Vamos explorar as bibliotecas, ferramentas e linguagens mais usadas para criar provas ZK na prática.

_"Não esqueça: Aula ao vivo amanhã, 19h, no YouTube. Traga suas dúvidas!"_
