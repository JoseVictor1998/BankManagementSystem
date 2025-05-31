# BankManagementSystem
Sistema bancário com estrutura de banco de dados em SQL Server
# Sistema de Gerenciamento Bancário - Esquema do Banco de Dados

Este repositório contém o esquema SQL para um Sistema de Gerenciamento Bancário (Bank Management System). O banco de dados foi projetado para gerenciar diversos aspectos de uma instituição bancária, incluindo informações de clientes, contas, agências, funcionários, transações, e operações financeiras.

## Visão Geral do Esquema

O banco de dados é modelado em SQL Server e utiliza o schema `dbo`. Ele é composto por diversas tabelas que representam as entidades e seus relacionamentos dentro do sistema bancário.

### Estrutura das Tabelas Principais

Aqui estão as principais tabelas e seus propósitos:

* **`Endereco`**: Armazena informações detalhadas de endereçamento (País, Estado, Cidade, Bairro, Logradouro, Número, CEP).
* **`Telefone`**: Armazena informações de contato telefônico (Código do País, DDD, Número).
* **`Nivel_Acesso`**: Define os diferentes níveis de acesso ao sistema e suas prioridades.
* **`Pessoa_Fisica`**: Contém dados específicos de pessoas físicas (CPF, Data de Nascimento).
    * *Restrição*: Idade mínima de 18 anos (`CK_Idade_Minima`).
* **`Pessoa_Juridica`**: Contém dados específicos de pessoas jurídicas (CNPJ, Data de Criação).
* **`Pessoas`**: Tabela central que unifica dados comuns de pessoas físicas e jurídicas, vinculando-as a endereços e telefones.
    * *Restrição*: Uma pessoa deve ser ou física (`PF_ID`) ou jurídica (`PJ_ID`), mas não ambas (`ck_PF_PJ`).
* **`Cliente`**: Representa os clientes do banco, vinculados à tabela `Pessoas`.
* **`Agencia`**: Informações sobre as agências bancárias (Número, Nome, Endereço, Telefone).
* **`Tipo_Conta`**: Define os tipos de contas bancárias disponíveis (ex: Corrente, Poupança).
* **`Status_Conta`**: Gerencia os status das contas (ex: Ativa, Bloqueada, Encerrada) e se permitem transações.
* **`Conta`**: Detalhes das contas dos clientes (Número da Conta, Agência, Tipo, Saldo, Limite de Crédito, Datas de Abertura/Encerramento).
    * *Restrição*: Saldo não pode ser inferior ao limite de crédito negativo (`ck_Saldo_Positivo`).
* **`Setor`**: Define os setores/departamentos do banco.
* **`Cargo`**: Define os cargos dos funcionários e seus respectivos níveis de acesso.
* **`Funcionarios`**: Informações sobre os funcionários do banco, incluindo cargo, setor, agência e dados de admissão/demissão.
    * *Restrição*: Data de demissão deve ser posterior ou igual à data de admissão (`ck_Datas_Validas`).

### Tabelas de Operações e Histórico

* **`Historico_Conta`**: Registra o histórico de operações realizadas em cada conta.
* **`Negociacao_Divida`**: Gerencia as negociações de dívidas dos clientes.
    * *Restrições*: Valor total e número de parcelas devem ser positivos; Status deve ser 'Em andamento', 'Concluida' ou 'Cancelada'.
* **`Parcela_Negociacao`**: Detalha as parcelas de uma negociação de dívida.
    * *Restrições*: Valor da parcela deve ser positivo; Status deve ser 'Paga', 'Em aberto' ou 'Vencida'.
* **`Cobranca`**: Registra informações sobre cobranças emitidas para as contas.
    * `Valor_Total`: Campo calculado (`Valor_Original` + `Valor_Juros_Aplicado`).
    * *Restrições*: Valores originais e de juros não podem ser negativos.
* **`Historico_Cobranca`**: Mantém o histórico de alterações no status das cobranças.
    * *Restrição*: `Tipo_Alteracao` deve ser um dos valores predefinidos (Pendente, Pago, Atrasado, Cancelado, Atualizado).

## Stored Procedures

### `sp_CadastraClienteCompleto`

Este stored procedure facilita o cadastro completo de um novo cliente (Pessoa Física ou Jurídica), incluindo seu endereço e telefone, de forma transacional.

**Parâmetros:**

* `@Tipopessoa CHAR(1)`: Indica o tipo de pessoa ('F' para Física, 'J' para Jurídica).
* `@CPF NVARCHAR(11) NULL`: CPF da pessoa física.
* `@DataNascimento DATE NULL`: Data de nascimento da pessoa física.
* `@CNPJ NVARCHAR(14) NULL`: CNPJ da pessoa jurídica.
* `@DataCriacao DATE NULL`: Data de criação da pessoa jurídica.
* `@Nome NVARCHAR(60)`: Nome completo ou Razão Social.
* `@Email NVARCHAR(60)`: Email para contato.
* `@Pais NVARCHAR(50)`: País do endereço.
* `@Estado NVARCHAR(50)`: Estado do endereço.
* `@Cidade NVARCHAR(50)`: Cidade do endereço.
* `@Bairro NVARCHAR(50)`: Bairro do endereço.
* `@Rua NVARCHAR(100)`: Logradouro do endereço.
* `@Numero INT`: Número do endereço.
* `@CEP INT`: CEP do endereço.
* `@DDI numeric(3,0)`: Código DDI do telefone.
* `@DDD numeric(3,0)`: Código DDD do telefone.
* `@NumeroTelefone numeric(9,0)`: Número do telefone.

**Funcionamento:**

1.  Inicia uma transação.
2.  Insere os dados de endereço na tabela `Endereco`.
3.  Insere os dados de telefone na tabela `Telefone`.
4.  Verifica o `@Tipopessoa`:
    * Se 'F', insere os dados na tabela `Pessoa_Fisica`.
    * Se 'J', insere os dados na tabela `Pessoa_Juridica`.
    * Caso contrário, levanta um erro.
5.  Insere os dados na tabela `Pessoas`, referenciando os IDs gerados para endereço, telefone e pessoa física/jurídica.
6.  Se todas as etapas forem bem-sucedidas, a transação é confirmada (`COMMIT`).
7.  Em caso de erro, a transação é revertida (`ROLLBACK`) e uma mensagem de erro é exibida.

## Tecnologias Utilizadas

* **Banco de Dados:** Microsoft SQL Server
* **Linguagem:** T-SQL (Transact-SQL)

## Como Utilizar o Esquema

1.  **Pré-requisitos:**
    * Tenha uma instância do Microsoft SQL Server instalada e em execução.
    * Utilize uma ferramenta de gerenciamento de banco de dados, como SQL Server Management Studio (SSMS) ou Azure Data Studio.

2.  **Configuração do Banco:**
    * Crie um novo banco de dados (ex: `BankManagementSystem`) ou conecte-se a um existente.
    * Execute o comando `CREATE SCHEMA dbo;` caso o schema padrão não esteja disponível ou precise ser recriado.

3.  **Criação das Tabelas:**
    * Execute os scripts `CREATE TABLE` na ordem correta para respeitar as dependências de chaves estrangeiras (foreign keys).
    * **Ordem Sugerida (geralmente):**
        1.  Tabelas sem chaves estrangeiras ou que são referenciadas por muitas outras (ex: `Endereco`, `Telefone`, `Nivel_Acesso`, `Status_Conta`, `Tipo_Conta`, `Setor`).
        2.  Tabelas que dependem das anteriores (ex: `Pessoa_Fisica`, `Pessoa_Juridica`).
        3.  Tabelas de ligação e principais (ex: `Pessoas`, `Agencia`, `Cargo`).
        4.  Tabelas que dependem das anteriores (ex: `Cliente`, `Funcionarios`, `Conta`).
        5.  Tabelas de histórico e operações (ex: `Historico_Conta`, `Cobranca`, `Negociacao_Divida`, etc.).
    * Assegure-se de criar as constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK) e `ALTER TABLE` para adicionar constraints após a criação das tabelas, se necessário.

4.  **Criação dos Stored Procedures:**
    * Após a criação de todas as tabelas, execute o script `CREATE PROCEDURE sp_CadastraClienteCompleto`.

Este esquema fornece uma base robusta e bem estruturada para o desenvolvimento de um sistema de gerenciamento bancário completo.