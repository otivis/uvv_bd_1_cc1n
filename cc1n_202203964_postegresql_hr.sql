/* Criando o usuario com senha
*/
CREATE USER otavio WITH
	ENRYPTED PASSWORD 'senhaboa'
	CREATEDB;
-- Acesso \connect uvv otavio

/*CRIANDO DATABASE*/
CREATE DATABASE UVV
	owner "otavio"
	template "template0"
	encoding "UTF8"
	lc_collate "pt_BR.UTF-8" 
    	lc_ctype "pt_BR.UTF-8" 
    	allow_connections "true";

--Criando o SCHEMA dando privilegio pro usuario    	
 CREATE SCHEMA hr AUTHORIZATION otavio;
 
 
 --ALterando o schema hr como default 
 ALTER USER otavio
 USER SEARCH_PATH TO hr,"$user", public;
 
 
 /* COMEÇO DA ESTRUTURA DO BANCO DE DADOS BASEADO NO MODELO */
 
 /*REGIOES*/
 CREATE TABLE regioes(
 id_regiao integer constraint pk_regioes PRIMARY KEY,
 nome VARCHAR(25) not null);
 
 /*Paises*/
 CREATE TABLE paises(
 id_pais CHAR(2) not null constraint pk_paises PRIMARY KEY, 
 nome VARCHAR(50) not null constraint ak_paises ALTERNATIVE KEY,
 id_regiao integer not null);
 
 /*Localizacoes*/
 CREATE TABLE localizacoes(
 id_localizacao INTEGER not null constraint pk_local PRIMARY KEY,
 endereco VARCHAR(50) NOT NULL,
 cep VARCHAR(12) NOT NULL,
 cidade VARCHAR(50) NOT NULL,
 uf VARCHAR (25) NOT NULL,
 id_pais CHAR(2));
 
 
 /* ADICIONANDO constraint */ 
ALTER TABLE localizacoes add constraint fk_local FOREIGN KEY (id_pais) REFERENCES paises(id_regiao);

/*Departamentos*/
CREATE TABLE departamentos( 
id_departamento INTEGER NOT NULL constraint pk_departamento PRIMARY KEY,
nome VARCHAR(50) NOT NULL constraint ak_departamento ALTERNATIVE KEY,
id_localizacao INTEGER NOT NULL,
id_gerente INTEGER NOT NULL);

/*EMPREGADOS*/
CREATE TABLE empregados(
id_empregado INTEGER NOT NULL constraint pk_empregados PRIMARY KEY,
nome VARCHAR(75) NOT NULL,
email VARCHAR(35) NOT NULL constraint ak_empregados ALTERNATIVE KEY,
telefone VARCHAR(20),
data_contratacao DATE NOT NULL,
id_cargo VARCHAR(10) NOT NULL,
salario DECIMAL(8,2),
comissao DECIMAL(8,2),
id_departamento INTEGER,
id_supervisor INTEGER);

/*Tabela de cargos*/
CREATE TABLE cargos(
id_cargo VARCHAR(10) NOT NULL constraint pk_cargos PRIMARY KEY,
cargo VARCHAR(35) NOT NULL constraint ak_cargos ALTERNATIVE KEY,
salario_minimo DECIMAL(8,2),
salario_maximo DECIMAL(8,2));

/*Tabela de histórico de cargos*/
CREATE TABLE historico_cargos(
id_empregado INTEGER NOT NULL constraint pfk_his PRIMARY KEY,
data_inicial DATE NOT NULL constraint Pk_his PRIMARY KEY,
data_final DATE NOTE NULL,
id_cargo VARCHAR NOT NULL,
id_departamento INTEGER);

/*Adicionando todas as constraints*/

ALTER TABLE departamentos add constraint fk_dp FOREIGN KEY id_localizacao REFERENCES localizacoes(id_localizacao);

ALTER TABLE departamentos add constraint fk2_dp FOREIGN KEY id_gerente REFERENCES empregados(id_supervisor);

ALTER TABLE empregados add constraint fk_ep FOREIGN KEY id_cargo REFERENCES cargos(id_cargo);

ALTER TABLE empregados add constraint fk2_ep FOREIGN KEY id_departamento REFERENCES deparamentos(id_departamento);

ALTER TABLE empregados add constraint fk3_dp FOREIGN KEY id_supervisor REFERENCES empregados(id_supervisor);

ALTER TABLE historico_cargos add constraint pfk_his FOREIGN KEY id_empregado REFERENCES empregados(id_empregado);

ALTER TABLE historico_cargos add constraint fk_his FOREIGN KEY id_departamento REFERENCES departamentos(id_departamento);

ALTER TABLE historico_cargos add constraint fk2_his FOREIGN KEY id_localizacao REFERENCES cargos(id_cargo);

/*INSERINDO DADOS*/
SELECT
'INSERT INTO empregados (id_empregado, nome, email,
telefone, data_contratacao, id_cargo, salario,
comissao, id_supervisor, id_departamento) VALUES
(' || employee_id || ', ''' || first_name || ' ' ||
last_name || ''', ''' || email || ''', ''' ||
phone_number || ''', ''' ||
TO_CHAR(hire_date, 'YYYY-MM-DD') || ', ''' ||
job_id || ''', ' || salary || ', ' ||
NVL(TO_CHAR(commission_pct), 'null') || ', ' ||
NVL(TO_CHAR(manager_id), 'null') || ', ' ||
NVL(TO_CHAR(department_id), 'null') || ');'
FROM employees;

SELECT
' INSERT INTO cargos(id_cargo,cargo,salario_minimo,salario_maximo)
VALUES ('||job_id || ''', ''' || job_name ||''',' || salary || ');
FROM jobs;


















