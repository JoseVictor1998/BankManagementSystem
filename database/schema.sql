CREATE PROCEDURE sp_CadastraClienteCompleto
 @Tipopessoa CHAR(1), -- 'F' ou 'J'
 @CPF NVARCHAR(11) NULL,
 @Data_Nascimento DATE NULL,
 @Data_Criacao DATE NULL,
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
 
 DECLARE @PF_ID INT ;
 DECLARE @PJ_ID INT ;
 
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
 
 
 EXEC sp_CadastraClienteCompleto
 @Tipopessoa ='F',
 @CPF = '12345678901',
 @Data_Nascimento ='1998-01-20',
 @Data_Criacao = NULL,
 @CNPJ = NULL,
 @Nome ='Joao da Silva',
 @Email = 'joaodasilva@email',
 @Pais = 'Brasil',
 @Estado = 'Paraiba',
 @Rua = 'Rua Das Flores',
 @Cidade = 'Paldalho',
 @Bairro = 'Centro',
 @CEP = '87000000',
 @Numero = '69',
 @DDI = '55',
 @DDD = '69',
 @NumeroTelefone = '699669965';
 
 
 EXEC sp_CadastraClienteCompleto
 @Tipopessoa ='J',
 @CPF = null,
 @Data_Nascimento =null,
 @Data_Criacao = '20-01-2024',
 @CNPJ = '00123456000198',
 @Nome ='Jotafer',
 @Email = 'jotafer@email',
 @Pais = 'Brasil',
 @Estado = 'Parana',
 @Rua = 'Rua Das Flores',
 @Cidade = 'Paldalho',
 @Bairro = 'Centro',
 @CEP = '87000000',
 @Numero = '69',
 @DDI = '55',
 @DDD = '44',
 @NumeroTelefone = '699669565';
 
 SELECT * FROM Pessoa_Juridica;
 
 
 
 EXEC sp_CadastraClienteCompleto
 @Tipopessoa ='F',
 @CPF = '12345648901',
 @Data_Nascimento ='2025-01-20',
 @Data_Criacao = NULL,
 @CNPJ = NULL,
 @Nome ='Joao da Silva',
 @Email = 'joaodasilva@email',
 @Pais = 'Brasil',
 @Estado = 'Paraiba',
 @Rua = 'Rua Das Flores',
 @Cidade = 'Paldalho',
 @Bairro = 'Centro',
 @CEP = '87000000',
 @Numero = '59',
 @DDI = '55',
 @DDD = '59',
 @NumeroTelefone = '695669965';
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 