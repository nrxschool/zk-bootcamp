---
marp: true
theme: gaia
---

# **Aula 3: Provas ZK 101**

- data: 07/05
- prof: Lucas Oliveira

## **1. Abertura**

**Hello World!**

Sejam todos bem-vindos ao GRANDE CÓDIGO.

Bootcamp/Hackathon/Incubação da NearX

Sua porta de entrada para o ecossistema blockchain/web3 e provas ZK.

Hoje vamos colocar a mão na massa com Provas ZK.

---

## **2. Programação**

0. **Merkle Tree**
1. **Tipos de Provas e Casos de Uso**
2. **Linguagens e Bibliotecas**
3. **Ciclo de Vida de uma Prova ZK**
4. **Hands-on com Noir + ZkVerify**

---

## **3. Merkle Tree**

- merkle root
- merkle path
- leaf

---

## **4. Groth16**

- **Linguagens/Bibliotecas:**  
  Circom + SnarkJS, Arkworks, ZoKrates
- **Maturidade:** Alta, muito usada em Ethereum
- **Prós:**
  - Provas pequenas (~200 bytes)
  - Verificação rápida e barata na EVM
- **Contras:**
  - Setup confiável (trusted setup)
  - Menos flexível para circuitos dinâmicos
- **Casos de uso:**
  - Tornado Cash
  - verificação de identidade
  - votações privadas

---

## **5. PLONK**

- **Linguagens/Bibliotecas:**  
  Circom + SnarkJS, Aztec, Halo2
- **Maturidade:** Crescendo rapidamente
- **Prós:**
  - Setup universal
  - Mais flexível que Groth16
- **Contras:**
  - Provas maiores
  - Mais caro que Groth16 em algumas EVMs
- **Casos de uso:**
  - zkRollups (Aztec, Scroll)
  - KYC privado

---

## **6. STARKs**

- **Linguagens/Bibliotecas:**  
  Cairo, Risc0, Starky
- **Maturidade:** Alta (StarkNet em produção)
- **Prós:**
  - Sem trusted setup
  - Transparente e auditável
- **Contras:**
  - Provas grandes (~100kb+)
  - Verificação cara na EVM
- **Casos de uso:**
  - StarkNet
  - Provas de execução de jogos ou ML

---

## **7. Bulletproofs**

- **Linguagens/Bibliotecas:**  
  Dalek, zkVM, Monero
- **Maturidade:** Média
- **Prós:**
  - Sem trusted setup
  - Compacta em alguns casos
- **Contras:**
  - Verificação lenta
  - Difícil escalar para circuitos grandes
- **Casos de uso:**
  - Confidential transactions (Monero)
  - Provas de range (ex: idade mínima)

---

## **8. Ciclo de Vida de uma Prova ZK**

1. **Compilação do circuito** (ex: Noir)
2. **Geração da prova** com dados do usuário
3. **Verificação da prova** (local ou via ZkVerify)
4. **Publicação do atestado** (proof ID)
5. **Verificação on-chain** usando o smart contract da ZkVerify

---

## **9. Hands-on com Noir**

### Objetivo:

Criar uma prova de que uma pessoa tem **≥ 18 anos** sem mostrar a data de nascimento.

---

### Etapa 1: Criar um circuito em Noir

```rust
fn main(birth_year: u16, current_year: u16) {
    age: u16 = current_year - birth_year;
    assert(age >= 18);
}
```

---

### Etapa 2: Usar Node.js para gerar uma prova

```ts

```

---

### Etapa 3: Usar ZkVerify para verificar a prova

```ts

```

---

### Etapa 4: Salvar o ID no contrato

- Publica o proof ID na ZkVerify
- Smart contract verifica esse ID on-chain
- Útil para gates de acesso, reputação, KYC, etc.

---

## **9. Recapitulação**

Hoje você aprendeu:

- Diferenças entre os tipos de provas ZK e onde usar cada uma
- Linguagens e ferramentas populares (Noir, Circom, Cairo...)
- Como funciona o ciclo de vida de uma prova ZK
- Criou sua primeira prova usando Noir
- Verificou localmente, mandou para o ZkVerify e integrou com contrato inteligente

---

## **10. Lição de Casa**

### Desafio de Aprendizagem

1. Gere uma prova Noir com outra lógica (ex: salário maior que X)

### Desafio de Carreira

2. Poste no LinkedIn a diferença entre STARKs e SNARKs com a #zknearx (7/10)

### Desafio de Comunidade

3. 🧠 Poste no Discord uma ideia de app que use ZK para proteger privacidade

---

## **11. Próxima Aula**

**08/05 – Mini Apps**

Vamos aprender o que são os Mini Apps do Telegram e como usá-los para criar experiências blockchain.

_"Não esqueça: Aula ao vivo amanhã, 19h, no YouTube. Traga suas dúvidas!"_
