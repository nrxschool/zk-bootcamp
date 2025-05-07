# Ciclo de vida de uma Prova ZK

## 1 Teste

```bash
nargo test
```

## 2 Compilar

```bash
nargo compile
```

## 3 Executar

```bash
nargo execute
```

## 4 Criar prova

```bash
bb prove -b ./target/circuit.json -w ./target/circuit.gz -o ./target
```

## 5 Escrever a chave de verificação

```bash
bb write_vk -b ./target/circuit.json -o ./target
```

## 6 Verificar a prova

```bash
bb verify
```
