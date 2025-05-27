-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- BankManagementSystem.dbo.Endereco definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Endereco;

CREATE TABLE BankManagementSystem.dbo.Endereco (
	ID int IDENTITY(1,1) NOT NULL,
	Pais nvarchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	Estado nvarchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	Cidade nvarchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	Bairro nvarchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	Logradouro nvarchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	Numero int NOT NULL,
	CONSTRAINT PK__Endereco__3214EC27E5F4F6B2 PRIMARY KEY (ID)
);


-- BankManagementSystem.dbo.Nivel_Acesso definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Nivel_Acesso;

CREATE TABLE BankManagementSystem.dbo.Nivel_Acesso (
	Nivel_Acesso_ID int IDENTITY(1,1) NOT NULL,
	Nome nvarchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	Prioridade int NOT NULL,
	CONSTRAINT PK__Nivel_Ac__9C7AF76BB45CEA85 PRIMARY KEY (Nivel_Acesso_ID)
);


-- BankManagementSystem.dbo.Pessoa_Fisica definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Pessoa_Fisica;

CREATE TABLE BankManagementSystem.dbo.Pessoa_Fisica (
	PF_ID int IDENTITY(1,1) NOT NULL,
	CPF nvarchar(11) COLLATE Latin1_General_CI_AS NOT NULL,
	Data_Nascimento date NOT NULL,
	CONSTRAINT PK__Clientes__BF68E4E2D9893DE3 PRIMARY KEY (PF_ID),
	CONSTRAINT UQ__Clientes__C1F89731B7A4661B UNIQUE (CPF)
);
ALTER TABLE BankManagementSystem.dbo.Pessoa_Fisica WITH NOCHECK ADD CONSTRAINT CK_Idade_Minima CHECK ((dateadd(year,(18),[Data_Nascimento])<=CONVERT([date],getdate())));


-- BankManagementSystem.dbo.Pessoa_Juridica definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Pessoa_Juridica;

CREATE TABLE BankManagementSystem.dbo.Pessoa_Juridica (
	PJ_ID int IDENTITY(1,1) NOT NULL,
	CNPJ nvarchar(14) COLLATE Latin1_General_CI_AS NOT NULL,
	Data_Criaca date NOT NULL,
	CONSTRAINT PK__Ciente_P__C812C1A863E9CC38 PRIMARY KEY (PJ_ID),
	CONSTRAINT UQ__Ciente_P__AA57D6B4FC7C77CF UNIQUE (CNPJ)
);


-- BankManagementSystem.dbo.Setor definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Setor;

CREATE TABLE BankManagementSystem.dbo.Setor (
	SetorID int IDENTITY(1,1) NOT NULL,
	Nome_Setor nvarchar(25) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT PK__Setor__26AA3A2386C520CA PRIMARY KEY (SetorID)
);


-- BankManagementSystem.dbo.Status_Conta definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Status_Conta;

CREATE TABLE BankManagementSystem.dbo.Status_Conta (
	StatusID int IDENTITY(1,1) NOT NULL,
	Nome_Status nvarchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	Descricao nvarchar(255) COLLATE Latin1_General_CI_AS NULL,
	Permite_Transacao bit DEFAULT 1 NOT NULL,
	CONSTRAINT PK__Status_C__C8EE2043A813D4D0 PRIMARY KEY (StatusID),
	CONSTRAINT UQ__Status_C__53D192CC0FD8D172 UNIQUE (Nome_Status)
);


-- BankManagementSystem.dbo.Telefone definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Telefone;

CREATE TABLE BankManagementSystem.dbo.Telefone (
	TelefoneID int IDENTITY(1,1) NOT NULL,
	Codigo_Pais numeric(3,0) NOT NULL,
	DDD numeric(3,0) NOT NULL,
	Numero numeric(9,0) NOT NULL,
	CONSTRAINT PK__Telefone__5BD0BFE557436717 PRIMARY KEY (TelefoneID)
);


-- BankManagementSystem.dbo.Tipo_Conta definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Tipo_Conta;

CREATE TABLE BankManagementSystem.dbo.Tipo_Conta (
	ID int IDENTITY(1,1) NOT NULL,
	Nome nvarchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	Observacao nvarchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	CONSTRAINT PK__Tipo_Con__3214EC27CCDF0E55 PRIMARY KEY (ID)
);


-- BankManagementSystem.dbo.Agencia definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Agencia;

CREATE TABLE BankManagementSystem.dbo.Agencia (
	AgenciaID int IDENTITY(1,1) NOT NULL,
	TelefoneID int NOT NULL,
	EnderecoID int NOT NULL,
	Numero_Agencia numeric(5,0) NOT NULL,
	Nome_Agencia nvarchar(30) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT PK__Agencia__996EE73CF1262B24 PRIMARY KEY (AgenciaID),
	CONSTRAINT fk_EnderecoID FOREIGN KEY (EnderecoID) REFERENCES BankManagementSystem.dbo.Endereco(ID),
	CONSTRAINT fk_TelefoneID FOREIGN KEY (TelefoneID) REFERENCES BankManagementSystem.dbo.Telefone(TelefoneID)
);


-- BankManagementSystem.dbo.Cargo definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Cargo;

CREATE TABLE BankManagementSystem.dbo.Cargo (
	CargoID int IDENTITY(1,1) NOT NULL,
	Nome_Cargo nvarchar(25) COLLATE Latin1_General_CI_AS NOT NULL,
	Nivel_Acesso int NOT NULL,
	CONSTRAINT PK__Cargo__B4E665ED890B94E5 PRIMARY KEY (CargoID),
	CONSTRAINT fk_Nivel_Acesso FOREIGN KEY (Nivel_Acesso) REFERENCES BankManagementSystem.dbo.Nivel_Acesso(Nivel_Acesso_ID)
);


-- BankManagementSystem.dbo.Pessoas definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Pessoas;

CREATE TABLE BankManagementSystem.dbo.Pessoas (
	PessoaID int IDENTITY(1,1) NOT NULL,
	EnderecoID int NOT NULL,
	PF_ID int NULL,
	PJ_ID int NULL,
	TelefoneID int NOT NULL,
	Nome nvarchar(60) COLLATE Latin1_General_CI_AS NOT NULL,
	Email nvarchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT PK__Pessoas__2F5F56325F06F500 PRIMARY KEY (PessoaID),
	CONSTRAINT fk_Endereco_ID FOREIGN KEY (EnderecoID) REFERENCES BankManagementSystem.dbo.Endereco(ID),
	CONSTRAINT fk_PF_ID FOREIGN KEY (PF_ID) REFERENCES BankManagementSystem.dbo.Pessoa_Fisica(PF_ID),
	CONSTRAINT fk_PJ_ID FOREIGN KEY (PJ_ID) REFERENCES BankManagementSystem.dbo.Pessoa_Juridica(PJ_ID),
	CONSTRAINT fk_Telefone_ID FOREIGN KEY (TelefoneID) REFERENCES BankManagementSystem.dbo.Telefone(TelefoneID)
);
ALTER TABLE BankManagementSystem.dbo.Pessoas WITH NOCHECK ADD CONSTRAINT ck_PF_PJ CHECK (([PF_ID] IS NOT NULL AND [PJ_ID] IS NULL OR [PF_ID] IS NULL AND [PJ_ID] IS NOT NULL));


-- BankManagementSystem.dbo.Cliente definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Cliente;

CREATE TABLE BankManagementSystem.dbo.Cliente (
	ClienteID int IDENTITY(1,1) NOT NULL,
	PessoaID int NOT NULL,
	Data_Cadastro date DEFAULT getdate() NOT NULL,
	CONSTRAINT PK__Cliente__71ABD0A7E95CD738 PRIMARY KEY (ClienteID),
	CONSTRAINT fk_Pessoa_ID FOREIGN KEY (PessoaID) REFERENCES BankManagementSystem.dbo.Pessoas(PessoaID)
);


-- BankManagementSystem.dbo.Conta definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Conta;

CREATE TABLE BankManagementSystem.dbo.Conta (
	ContaID int IDENTITY(1,1) NOT NULL,
	AgenciaID int NOT NULL,
	Tipo_ContaID int NOT NULL,
	ClienteID int NOT NULL,
	StatusID int DEFAULT 1 NOT NULL,
	Numero_Conta varchar(20) COLLATE Latin1_General_CI_AS NOT NULL,
	Digito_Verificacao char(1) COLLATE Latin1_General_CI_AS NULL,
	Saldo decimal(19,4) NULL,
	Data_Abertura date DEFAULT getdate() NOT NULL,
	Data_Encerramento date NULL,
	Limite_Credito decimal(19,4) NULL,
	CONSTRAINT PK__Conta__F7CF1DD40D65736F PRIMARY KEY (ContaID),
	CONSTRAINT UQ__Conta__DF1C573EA62CCEED UNIQUE (Numero_Conta),
	CONSTRAINT fk_AgenciaConta FOREIGN KEY (AgenciaID) REFERENCES BankManagementSystem.dbo.Agencia(AgenciaID),
	CONSTRAINT fk_ClienteConta FOREIGN KEY (ClienteID) REFERENCES BankManagementSystem.dbo.Cliente(ClienteID),
	CONSTRAINT fk_StatusConta FOREIGN KEY (StatusID) REFERENCES BankManagementSystem.dbo.Status_Conta(StatusID),
	CONSTRAINT fk_Tipo_Conta FOREIGN KEY (Tipo_ContaID) REFERENCES BankManagementSystem.dbo.Tipo_Conta(ID)
);
ALTER TABLE BankManagementSystem.dbo.Conta WITH NOCHECK ADD CONSTRAINT ck_Saldo_Positivo CHECK (([Saldo]>=( -isnull([Limite_Credito],(0)))));


-- BankManagementSystem.dbo.Funcionarios definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Funcionarios;

CREATE TABLE BankManagementSystem.dbo.Funcionarios (
	FuncionarioID int IDENTITY(1,1) NOT NULL,
	CargoID int NOT NULL,
	SetorID int NOT NULL,
	PessoaID int NOT NULL,
	AgenciaID int NOT NULL,
	Data_Admissao date DEFAULT getdate() NOT NULL,
	Ativo bit DEFAULT 1 NOT NULL,
	Salario_Base decimal(10,2) NULL,
	Data_Demissao date NULL,
	CONSTRAINT PK__Funciona__297ECD4A34E729DF PRIMARY KEY (FuncionarioID),
	CONSTRAINT fk_AgenciaID FOREIGN KEY (AgenciaID) REFERENCES BankManagementSystem.dbo.Agencia(AgenciaID),
	CONSTRAINT fk_CargoID FOREIGN KEY (CargoID) REFERENCES BankManagementSystem.dbo.Cargo(CargoID),
	CONSTRAINT fk_IDPessoa FOREIGN KEY (PessoaID) REFERENCES BankManagementSystem.dbo.Pessoas(PessoaID),
	CONSTRAINT fk_SetorID FOREIGN KEY (SetorID) REFERENCES BankManagementSystem.dbo.Setor(SetorID)
);
ALTER TABLE BankManagementSystem.dbo.Funcionarios WITH NOCHECK ADD CONSTRAINT ck_Datas_Validas CHECK (([Data_Demissao] IS NULL OR [Data_Demissao]>=[Data_Admissao]));


-- BankManagementSystem.dbo.Historico_Conta definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Historico_Conta;

CREATE TABLE BankManagementSystem.dbo.Historico_Conta (
	HistoricoID int IDENTITY(1,1) NOT NULL,
	ContaID int NOT NULL,
	Tipo_Operacao nvarchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	Data_Hora date DEFAULT getdate() NOT NULL,
	Observacao nvarchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	Usuario_Responsavel nvarchar(100) COLLATE Latin1_General_CI_AS NULL,
	CONSTRAINT PK__Historic__4A561D76F6D591A7 PRIMARY KEY (HistoricoID),
	CONSTRAINT fk_ContaID FOREIGN KEY (ContaID) REFERENCES BankManagementSystem.dbo.Conta(ContaID)
);


 CREATE TABLE Configuracao_Juros(
 Configuracao_ID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
 Taxa_Juros_dia DECIMAL (3,3) NOT NULL CHECK (Taxa_Juros_dia >= 0),
 Dias_Gratuitos INT NOT NULL CHECK (Dias_Gratuitos >=0),
 Data_Inicio_Vigencia DATE NOT NULL,
 Data_Fim_Vigencia DATE NULL
 );
 
 CREATE TABLE Cobranca(
 Cobranca_ID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
 Conta_ID INT NOT NULL,
 Valor_Original DECIMAL (10,4) NOT NULL CHECK (Valor_Original >= 0),
 Data_Vencimento DATE NOT NULL,
 Data_Pagamento DATE NULL,
 Valor_Juros_Aplicado DECIMAL (10,4) NOT NULL DEFAULT 0 CHECK (Valor_Juros_Aplicado >= 0 ),
 Status_Cobranca NVARCHAR (25) NOT NULL DEFAULT 'Pendente',
  Valor_Total AS (Valor_Original + Valor_Juros_Aplicado) PERSISTED,
 CONSTRAINT fk_Conta_Cobranca FOREIGN KEY (Conta_ID) REFERENCES Conta(ContaID)
 );
 
 CREATE TABLE Historico_Cobranca(
 Historico_ID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
 Cobranca_ID INT NOT NULL,
 Data_Alteracao DATETIME NOT NULL DEFAULT GETDATE(),
 Tipo_Alteracao NVARCHAR (25) NOT NULL CHECK (Tipo_Alteracao IN ('Pendente','Pago','Cancelado','Atrasado','Atualizado')),
 Observacao NVARCHAR (MAX),
 CONSTRAINT fk_Cobranca_Historico FOREIGN KEY (Cobranca_ID) REFERENCES Cobranca(Cobranca_ID)
 );
 
 CREATE TABLE Negociacao_Divida(
 Negociacao_ID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
 Cliente_ID INT NOT NULL,
 Data_Negociacao DATETIME NOT NULL DEFAULT GETDATE(),
 Valor_Total_Negociacao DECIMAL (10,2) NOT NULL CHECK (Valor_Total_Negociacao > 0),
 Numero_Parcelas INT NOT NULL CHECK (Numero_Parcelas >0),
 Status NVARCHAR (25) NOT NULL CHECK (Status IN('Em andamento', 'Concluida','Cancelada')),
 CONSTRAINT fk_Cliente_Negociacao FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ClienteID)
 );
 
 
 CREATE TABLE Parcela_Negociacao(
 Parcela_ID INT NOT NULL PRIMARY KEY IDENTITY (1,1), 
 Negociacao_ID INT NOT NULL,
 Valor_Parcela DECIMAL (10,2) NOT NULL CHECK (Valor_Parcela > 0),
 Data_Vencimento DATE NOT NULL,
 Data_Pagamento DATE NULL,
 Status NVARCHAR (25) NOT NULL CHECK (Status IN('Paga','Em aberto','Vencida')),
 CONSTRAINT fk_Parcela_Negociacao FOREIGN KEY (Negociacao_ID) REFERENCES Negociacao_Divida(Negociacao_ID)
 );
 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 