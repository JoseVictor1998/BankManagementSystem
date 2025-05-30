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
	CEP int NOT NULL,
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
	CONSTRAINT UQ__Clientes__C1F89731B7A4661B UNIQUE (CPF),
	CONSTRAINT uq_Pessoa_Fisica_CPF UNIQUE (CPF)
);
ALTER TABLE BankManagementSystem.dbo.Pessoa_Fisica WITH NOCHECK ADD CONSTRAINT CK_Idade_Minima CHECK ((dateadd(year,(18),[Data_Nascimento])<=CONVERT([date],getdate())));


-- BankManagementSystem.dbo.Pessoa_Juridica definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Pessoa_Juridica;

CREATE TABLE BankManagementSystem.dbo.Pessoa_Juridica (
	PJ_ID int IDENTITY(1,1) NOT NULL,
	CNPJ nvarchar(14) COLLATE Latin1_General_CI_AS NOT NULL,
	Data_Criacao date NOT NULL,
	CONSTRAINT PK__Ciente_P__C812C1A863E9CC38 PRIMARY KEY (PJ_ID),
	CONSTRAINT UQ__Ciente_P__AA57D6B4FC7C77CF UNIQUE (CNPJ),
	CONSTRAINT uq_Pessoa_Juridica_CNPJ UNIQUE (CNPJ)
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


-- BankManagementSystem.dbo.Negociacao_Divida definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Negociacao_Divida;

CREATE TABLE BankManagementSystem.dbo.Negociacao_Divida (
	Negociacao_ID int IDENTITY(1,1) NOT NULL,
	Cliente_ID int NOT NULL,
	Data_Negociacao datetime DEFAULT getdate() NOT NULL,
	Valor_Total_Negociacao decimal(10,2) NOT NULL,
	Numero_Parcelas int NOT NULL,
	Status nvarchar(25) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT PK__Negociac__9F7D87770ADAAECE PRIMARY KEY (Negociacao_ID),
	CONSTRAINT fk_Cliente_Negociacao FOREIGN KEY (Cliente_ID) REFERENCES BankManagementSystem.dbo.Cliente(ClienteID)
);
ALTER TABLE BankManagementSystem.dbo.Negociacao_Divida WITH NOCHECK ADD CONSTRAINT CK__Negociaca__Valor__5BAD9CC8 CHECK (([Valor_Total_Negociacao]>(0)));
ALTER TABLE BankManagementSystem.dbo.Negociacao_Divida WITH NOCHECK ADD CONSTRAINT CK__Negociaca__Numer__5CA1C101 CHECK (([Numero_Parcelas]>(0)));
ALTER TABLE BankManagementSystem.dbo.Negociacao_Divida WITH NOCHECK ADD CONSTRAINT CK__Negociaca__Statu__5D95E53A CHECK (([Status]='Cancelada' OR [Status]='Concluida' OR [Status]='Em andamento'));


-- BankManagementSystem.dbo.Parcela_Negociacao definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Parcela_Negociacao;

CREATE TABLE BankManagementSystem.dbo.Parcela_Negociacao (
	Parcela_ID int IDENTITY(1,1) NOT NULL,
	Negociacao_ID int NOT NULL,
	Valor_Parcela decimal(10,2) NOT NULL,
	Data_Vencimento date NOT NULL,
	Data_Pagamento date NULL,
	Status nvarchar(25) COLLATE Latin1_General_CI_AS NOT NULL,
	CONSTRAINT PK__Parcela___37A20910A8E6B4B9 PRIMARY KEY (Parcela_ID),
	CONSTRAINT fk_Parcela_Negociacao FOREIGN KEY (Negociacao_ID) REFERENCES BankManagementSystem.dbo.Negociacao_Divida(Negociacao_ID)
);
ALTER TABLE BankManagementSystem.dbo.Parcela_Negociacao WITH NOCHECK ADD CONSTRAINT CK__Parcela_N__Valor__6166761E CHECK (([Valor_Parcela]>(0)));
ALTER TABLE BankManagementSystem.dbo.Parcela_Negociacao WITH NOCHECK ADD CONSTRAINT CK__Parcela_N__Statu__625A9A57 CHECK (([Status]='Vencida' OR [Status]='Em aberto' OR [Status]='Paga'));


-- BankManagementSystem.dbo.Cobranca definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Cobranca;

CREATE TABLE BankManagementSystem.dbo.Cobranca (
	Cobranca_ID int IDENTITY(1,1) NOT NULL,
	Conta_ID int NOT NULL,
	Valor_Original decimal(10,4) NOT NULL,
	Data_Vencimento date NOT NULL,
	Data_Pagamento date NULL,
	Valor_Juros_Aplicado decimal(10,4) DEFAULT 0 NOT NULL,
	Status_Cobranca nvarchar(25) COLLATE Latin1_General_CI_AS DEFAULT 'Pendente' NOT NULL,
	Valor_Total AS ([Valor_Original]+[Valor_Juros_Aplicado]) PERSISTED,
	CONSTRAINT PK__Cobranca__2375483AA8C63E9C PRIMARY KEY (Cobranca_ID),
	CONSTRAINT fk_Conta_Cobranca FOREIGN KEY (Conta_ID) REFERENCES BankManagementSystem.dbo.Conta(ContaID)
);
ALTER TABLE BankManagementSystem.dbo.Cobranca WITH NOCHECK ADD CONSTRAINT CK__Cobranca__Valor___4F47C5E3 CHECK (([Valor_Original]>=(0)));
ALTER TABLE BankManagementSystem.dbo.Cobranca WITH NOCHECK ADD CONSTRAINT CK__Cobranca__Valor___51300E55 CHECK (([Valor_Juros_Aplicado]>=(0)));


-- BankManagementSystem.dbo.Historico_Cobranca definição

-- Drop table

-- DROP TABLE BankManagementSystem.dbo.Historico_Cobranca;

CREATE TABLE BankManagementSystem.dbo.Historico_Cobranca (
	Historico_ID int IDENTITY(1,1) NOT NULL,
	Cobranca_ID int NOT NULL,
	Data_Alteracao datetime DEFAULT getdate() NOT NULL,
	Tipo_Alteracao nvarchar(25) COLLATE Latin1_General_CI_AS NOT NULL,
	Observacao nvarchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	CONSTRAINT PK__Historic__53C81D444A893342 PRIMARY KEY (Historico_ID),
	CONSTRAINT fk_Cobranca_Historico FOREIGN KEY (Cobranca_ID) REFERENCES BankManagementSystem.dbo.Cobranca(Cobranca_ID)
);
ALTER TABLE BankManagementSystem.dbo.Historico_Cobranca WITH NOCHECK ADD CONSTRAINT CK__Historico__Tipo___56E8E7AB CHECK (([Tipo_Alteracao]='Atualizado' OR [Tipo_Alteracao]='Atrasado' OR [Tipo_Alteracao]='Cancelado' OR [Tipo_Alteracao]='Pago' OR [Tipo_Alteracao]='Pendente'));



CREATE PROCEDURE sp_CadastraClienteCompleto
 @Tipopessoa CHAR(1), -- 'F' ou 'J'
 @CPF NVARCHAR(11) NULL,
 @DataNascimento DATE NULL,
 @DataCriacao DATE NULL,
 @CNPJ NVARCHAR (14) NULL,
 @Nome NVARCHAR(60),
 @Email NVARCHAR(60),
 @Pais NVARCHAR (50),
 @Estado NVARCHAR (50),
 @Rua NVARCHAR (100),
 @Cidade NVARCHAR(50),
 @Bairro NVARCHAR(50),
 @CEP INT,
 @Numero INT,
 @DDI numeric(3,0),
 @DDD numeric(3,0),
 @NumeroTelefone numeric(9,0)
 AS 
 BEGIN 
 	 SET NOCOUNT ON;
 BEGIN TRY 
   BEGIN TRANSACTION;
 -- Inserir Endereço 
 INSERT INTO Endereco (Pais, Estado, Cidade, Bairro, Logradouro, Numero, CEP)
 VALUES (@Pais, @Estado, @Cidade, @Bairro, @Rua, @Numero, @CEP);
 DECLARE @EnderecoID INT = SCOPE_IDENTITY();
 -- Inserir Telefone
 INSERT INTO Telefone (Codigo_Pais, DDD, Numero)
 VALUES (@DDI,@DDD,@NumeroTelefone);
 DECLARE @TelefoneID INT = SCOPE_IDENTITY();
 
 DECLARE @PF_ID INT NULL;
 DECLARE @PJ_ID INT NULL;
 
 --Inserir PF ou PJ
 IF @TipoPessoa = 'F'
 BEGIN
 	INSERT INTO Pessoa_Fisica (CPF,Data_Nascimento)
 	VALUES (@CPF,@Data_Nascimento);
 	SET @PF_ID = SCOPE_IDENTITY();
 END
 ELSE IF @TipoPessoa = 'J'
 BEGIN
 	INSERT INTO Pessoa_Juridica (CNPJ,Data_Criacao)
 	VALUES (@CNPJ, @Data_Criacao);
    SET @PJ_ID = SCOPE_IDENTITY();
 END
 ELSE
 BEGIN
 	-- Se @TipoPessoa não for 'F' nem 'J', Levanta um erro.
	 RAISERROR('Tipo de pessoa invàlido. Use"F" para Pessoa Fìsica ou "V" para Pessoa Jurìdica.', 16,1);
 END
 --Inserir Pessoa 
 INSERT INTO Pessoas (EnderecoID,PF_ID,PJ_ID, TelefoneID,Nome,Email)
 VALUES (@EnderecoID,@PF_ID,@PJ_ID,@TelefoneID,@Nome,@Email);
 DECLARE @PessoaID INT = SCOPE_IDENTITY();
COMMIT;
PRINT 'Pessoa cadastrada com sucesso. ID: '+ CAST (@PessoaID AS NVARCHAR);
END TRY

BEGIN CATCH
ROLLBACK;

PRINT 'Erro ao cadastrar pessoa completa: '+ ERROR_MESSAGE();
END CATCH

END;