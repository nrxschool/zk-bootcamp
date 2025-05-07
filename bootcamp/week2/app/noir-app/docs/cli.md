### Ciclo de Vida de uma Prova ZK: Conceitos e Detalhes

O ciclo de vida de uma prova de conhecimento zero (ZK) no contexto do Noir envolve várias etapas, desde o desenvolvimento e teste do circuito até a geração e verificação da prova.

Cada etapa usa ferramentas como o compilador `nargo` (para Noir) e o backend `bb` (Barretenberg, para geração e verificação de provas).

Abaixo, explico cada passo, os conceitos envolvidos, e como eles se aplicam ao nosso objetivo:

- Gerar uma prova ZK que comprova a maioridade (>=18 anos)
- Mantendo a privacidade da data de nascimento e idade exata.

#### 1. Teste (`nargo test`)

**Comando**:

```bash
nargo test
```

**O que faz**:

Executa os testes definidos no seu projeto Noir, localizados em `src/test.nr`.

Esses testes verificam se o circuito (definido em `src/main.nr`) comporta-se conforme esperado para diferentes entradas.

**Conceitos Envolvidos**:

- **Testes Unitários em ZK**: No Noir, testes são funções que simulam a execução do circuito com entradas específicas e verificam se as restrições são satisfeitas. Por exemplo, para o circuito que prova `age >= 18`, você pode testar casos como `birth_year = 1990, current_year = 2025` (deve passar) e `birth_year = 2010, current_year = 2025` (deve falhar).
- **Compilação e Simulação**: O `nargo test` compila o circuito e simula sua execução sem gerar uma prova completa. Ele verifica se as restrições matemáticas (ex.: `current_year - birth_year >= 18`) são válidas.
- **Debugging**: Testes ajudam a identificar erros no design do circuito antes de prosseguir para a geração de provas, que é mais custosa computacionalmente.

---

#### 2. Compilar (`nargo compile`)

**Comando**:

```bash
nargo compile
```

**O que faz**:
Compila o programa Noir (em `src/main.nr`) em um **circuito aritmético**, que é salvo como `target/circuit.json`. Esse arquivo contém a representação matemática das restrições do circuito, pronta para ser usada por um backend de prova ZK.

**Conceitos Envolvidos**:

- **Circuito Aritmético**: Um circuito ZK é uma coleção de "portas" (gates) que representam operações matemáticas (adição, subtração, multiplicação, comparações) e restrições (ex.: `age >= 18`). No Noir, o compilador `nargo` traduz o código de alto nível em um formato de baixo nível chamado **ACIR** (Arithmetic Circuit Intermediate Representation).
- **ACIR**: É uma representação intermediária que descreve as restrições do circuito de forma independente do sistema de prova (ex.: UltraPlonk, UltraHonk). O `circuit.json` contém o ACIR, que pode ser processado por backends como o Barretenberg.
- **Pré-requisito para Prova**: A compilação é necessária para gerar o circuito que será usado nas etapas de execução, geração de prova, e verificação.

**Exemplo no Seu Caso**:
Para o circuito `main.nr`, o `nargo compile` gera `target/circuit.json`, que inclui:

- A operação `current_year - birth_year` como uma porta de subtração.
- A restrição `age >= 18` como uma série de portas que verificam se o resultado da subtração é maior ou igual a 18.
- Metadados sobre entradas públicas (`current_year`) e privadas (`birth_year`).

**Saída**:

- Arquivo `target/circuit.json`, que será usado nas próximas etapas.

---

#### 3. Executar (`nargo execute`)

**Comando**:

```bash
nargo execute
```

**O que faz**:
Executa o circuito com as entradas fornecidas em `Prover.toml` e gera um **witness** (testemunha), que é salvo como `target/circuit.gz`. O witness é um conjunto de valores que satisfazem as restrições do circuito para uma instância específica.

**Conceitos Envolvidos**:

- **Witness**: Em ZK, o witness é a coleção de todos os valores intermediários e finais calculados durante a execução do circuito (ex.: `birth_year`, `current_year`, `age`, e os resultados das portas). Ele prova que as entradas fornecidas respeitam as restrições.
- **Entradas**: As entradas do circuito são lidas de `Prover.toml`. No seu caso:

```toml
birth_year = "1990"
current_year = "2025"
```

Aqui, `birth_year` é privado, e `current_year` é público.

- **Execução Simulada**: O `nargo execute` simula a execução do circuito, calculando todos os valores necessários para satisfazer as restrições. Ele não gera a prova ainda, apenas o witness, que será usado na próxima etapa.

**Exemplo no Seu Caso**:

- Entradas: `birth_year = 1990`, `current_year = 2025`.
- Cálculo: `age = 2025 - 1990 = 35`.
- Restrição: `35 >= 18` é verdadeira.
- O witness contém os valores de `birth_year`, `current_year`, `age`, e os resultados das portas que implementam a subtração e a comparação.

**Saída**:

- Arquivo `target/circuit.gz`, que contém o witness.

---

#### 4. Criar Prova (`bb prove`)

**Comando**:

```bash
bb prove -b ./target/circuit.json -w ./target/circuit.gz -o ./target
```

**O que faz**:
Gera uma prova ZK com base no circuito (`circuit.json`) e no witness (`circuit.gz`). A prova é salva em `./target/proof`.

**Conceitos Envolvidos**:

- **Prova ZK**: A prova é um objeto criptográfico que demonstra que as restrições do circuito foram satisfeitas para as entradas fornecidas, sem revelar as entradas privadas. No seu caso, a prova atesta que `current_year - birth_year >= 18` sem revelar `birth_year`.
- **Backend Barretenberg**: O comando `bb` usa o Barretenberg, uma biblioteca criptográfica da Aztec, para gerar a prova. O Barretenberg suporta sistemas como UltraPlonk e UltraHonk.
- **UltraPlonk**: É o sistema de prova usado aqui (conforme exigido pela zkVerify). UltraPlonk é um esquema de prova ZK baseado em SNARKs (Succinct Non-interactive ARguments of Knowledge) que permite verificações rápidas e eficientes, ideal para aplicações como a zkVerify.
- **Entradas Públicas e Privadas**:
  - **Públicas**: `current_year` é incluído na prova e visível ao verificador.
  - **Privadas**: `birth_year` e `age` não são incluídos na prova, garantindo privacidade.
- **Prova e Inputs Públicos**: A prova contém os dados criptográficos e os inputs públicos (ex.: `current_year`). O arquivo `./target/proof` armazena ambos.

**Exemplo no Seu Caso**:

- Circuito: `circuit.json` define a subtração e a restrição `age >= 18`.
- Witness: `circuit.gz` contém `birth_year = 1990`, `current_year = 2025`, e `age = 35`.
- A prova gerada atesta que a restrição foi satisfeita, revelando apenas `current_year = 2025`.

**Saída**:

- Arquivo `./target/proof`, contendo a prova e os inputs públicos.

**Como Gerar Prova UltraPlonk no Terminal CLI**:
O comando `bb prove` gera uma prova UltraPlonk por padrão quando usado com um circuito Noir compilado, desde que o backend Barretenberg esteja configurado para UltraPlonk (o que é o caso após instalar com `bbup`). O comando completo é:

```bash
bb prove -b ./target/circuit.json -w ./target/circuit.gz -o ./target/proof
```

- `-b`: Especifica o arquivo do circuito (`circuit.json`).
- `-w`: Especifica o witness (`circuit.gz`).
- `-o`: Especifica o arquivo de saída para a prova (`proof`).

Se você quiser confirmar que a prova é UltraPlonk, verifique a configuração do backend com:

```bash
bb --version
```

A versão do Barretenberg instalada via `bbup` suporta UltraPlonk por padrão para projetos Noir.

---

#### 5. Escrever a Chave de Verificação (`bb write_vk`)

**Comando Corrigido**:

```bash
bb write_vk -b ./target/circuit.json -o ./target
```

**O que faz**:
Gera a **chave de verificação** (verification key, ou vk) para o circuito e a salva em `./target/vk`. A vk é usada para verificar a prova sem precisar do circuito completo.

**Conceitos Envolvidos**:

- **Chave de Verificação (vk)**: A vk é um objeto criptográfico derivado do circuito que permite verificar se uma prova é válida. Ela é específica para o circuito e o sistema de prova (UltraPlonk, neste caso).
- **Verificação Eficiente**: A vk é pequena e otimizada para verificação rápida, tornando-a ideal para uso em sistemas como a zkVerify ou em smart contracts.
- **Independência do Witness**: A vk não depende das entradas específicas (ex.: `birth_year`), apenas do circuito. Isso significa que a mesma vk pode ser usada para verificar qualquer prova gerada para o mesmo circuito.

**Exemplo no Seu Caso**:

- A vk gerada para o circuito `main.nr` permite verificar se qualquer prova atesta que `current_year - birth_year >= 18`.
- A vk contém informações sobre as restrições do circuito, mas não sobre `birth_year` ou `age`.

**Saída**:

- Arquivo `./target/vk`, contendo a chave de verificação.

---

#### 6. Verificar a Prova (`bb verify`)

**Comando Corrigido**:

```bash
bb verify -p ./target/proof -v ./target/vk
```

**O que faz**:
Verifica se a prova em `./target/proof` é válida para o circuito, usando a chave de verificação em `./target/vk`.

**Conceitos Envolvidos**:

- **Verificação ZK**: A verificação usa a vk para checar se a prova satisfaz as restrições do circuito sem revelar as entradas privadas. No UltraPlonk, isso é feito de forma eficiente (em tempo constante ou logarítmico).
- **Integridade Criptográfica**: A verificação garante que:
  - A prova foi gerada para o circuito correto.
  - As restrições (ex.: `age >= 18`) foram satisfeitas.
  - Os inputs públicos (ex.: `current_year`) correspondem aos fornecidos.
- **Saída Binária**: A verificação retorna `true` (prova válida) ou `false` (prova inválida).

**Exemplo no Seu Caso**:

- Prova: `./target/proof` contém a prova para `birth_year = 1990`, `current_year = 2025`.
- Vk: `./target/vk` é específica para o circuito `main.nr`.
- O comando verifica que `current_year - birth_year >= 18` é verdadeiro, sem acessar `birth_year`.

**Saída**:

- Mensagem indicando se a prova é válida (ex.: `Proof verified successfully`) ou um erro se for inválida.

---

### Resumo do Ciclo de Vida

1. **Teste**: Verifica se o circuito está correto usando casos de teste.
2. **Compilar**: Transforma o código Noir em um circuito aritmético (`circuit.json`).
3. **Executar**: Gera o witness (`circuit.gz`) com base nas entradas.
4. **Criar Prova**: Gera a prova UltraPlonk (`proof`) usando o circuito e o witness.
5. **Escrever Vk**: Gera a chave de verificação (`vk`) para o circuito.
6. **Verificar**: Confirma que a prova é válida usando a vk.

**No Seu Caso**:

- O circuito prova que `current_year - birth_year >= 18`, mantendo `birth_year` privado.
- A prova UltraPlonk gerada pode ser enviada para a zkVerify, e a vk permite verificação eficiente.
