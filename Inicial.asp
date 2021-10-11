<%
	'Conectando na master para saber se existe a base de dados desse sistema '

	connString = "PROVIDER=SQLOLEDB;DATA SOURCE=L008105\LOCALHOST;UID=dev;PWD=bkur6etc-10;DATABASE=master"
	set objConn = Server.CreateObject("ADODB.Connection")
	objConn.open = connString

	VerificaSeExiteBaseDeDados = "DECLARE @dbname nvarchar(128) SET @dbname = N'Crud' IF (NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = @dbname OR name = @dbname)) ) CREATE DATABASE Crud"

	set consulta = objConn.execute(VerificaSeExiteBaseDeDados)

	'Saindo da master e entrando na base de dados criada pelo código'
	connString = "PROVIDER=SQLOLEDB;DATA SOURCE=L008105\LOCALHOST;UID=dev;PWD=bkur6etc-10;DATABASE=Crud"
	set session("conexao") = Server.CreateObject("ADODB.Connection")
	session("conexao").open = connString

	'Verificando se a tabela de pessoas existe'
	SQL = "if object_id('PESSOAS') is null BEGIN CREATE TABLE PESSOAS(PESSOA_ID INT IDENTITY(1,1) PRIMARY KEY, NOME VARCHAR(100) NOT NULL, DOCUMENTO VARCHAR(15) NOT NULL, DOC_ID SMALLINT, ENDERECO VARCHAR(100), CONTATO VARCHAR(100) NOT NULL, CONT_ID SMALLINT) END"
	set consulta = session("conexao").execute(SQL)	

	response.redirect "crud_lista.asp"
%>