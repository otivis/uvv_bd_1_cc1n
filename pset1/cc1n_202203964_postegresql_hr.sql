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
 
 /*cargos*/
 
CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT pk_cargos PRIMARY KEY (id_cargo)
);

CREATE UNIQUE INDEX cargos_idx ON cargos (cargo);

COMMENT ON TABLE cargos IS 'Relação de cargos
Atributos: nome, salario max e min e codigo';
COMMENT ON COLUMN cargos.id_cargo IS 'Chave estrangeira de empregados, e chave primaria da relacao';
COMMENT ON COLUMN cargos.cargo IS 'Atributo nome';
COMMENT ON COLUMN cargos.salario_minimo IS 'Atributo salario base';
COMMENT ON COLUMN cargos.salario_maximo IS 'Atributo salario maximo';




CREATE TABLE regioes (
                id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT regioes_pk PRIMARY KEY (id_regiao)
                
);

CREATE UNIQUE INDEX regioes_ak ON regioes (nome);
COMMENT ON TABLE regioes IS 'Tabela de regioes, contendo codigo e nome das regioes.';
COMMENT ON COLUMN regioes.id_regiao IS 'PK da tabela de regioes, utilizada como FK na tabela de paises.';
COMMENT ON COLUMN regioes.nome IS 'Chave secundaria da tabela de regioes; correspondendo tambem a uma unica linha da tabela.';




CREATE TABLE paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER NOT NULL,
                CONSTRAINT pk_paises PRIMARY KEY (id_pais)
);


CREATE UNIQUE INDEX paises_ak ON paises (nome);
COMMENT ON TABLE paises IS 'Relacao paises com atributo de nome, codigo e codigo das regioes do pais. onta o endereco com a relacao de localizacoes e a tabela de regioes, relaciona com a tabela de localizacoes atraves da FK no atributo id_pais na relacao de localizacoes
';
COMMENT ON COLUMN paises.id_pais IS 'Chave primaria da relacao usada como chave estrangeira da relacao de localizacaoes.';

COMMENT ON COLUMN paises.id_regiao IS 'Chave estrangeira de regioes		';




CREATE TABLE localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2) NOT NULL,
                CONSTRAINT pk_localizacoes PRIMARY KEY (id_localizacao)
);
COMMENT ON TABLE localizacoes IS 'Relacao localizacoes
Atributos: nome, codigo, cidade, codigo estado, codigo pais. Com Chave estrangeira do id da relacao de departamentos';
COMMENT ON COLUMN localizacoes.id_localizacao IS 'Chave primaria usada como estrangeira da tabela de departamento';
COMMENT ON COLUMN localizacoes.endereco IS 'Numero do departamento e nome da rua';
COMMENT ON COLUMN localizacoes.cep IS 'Codigo postal da cidade de um departamento';
COMMENT ON COLUMN localizacoes.cidade IS 'Codigo da cidade e de um departamento';
COMMENT ON COLUMN localizacoes.uf IS 'Codigo do estado e de um departamento';
COMMENT ON COLUMN localizacoes.id_pais IS 'Chave estrangeira de paises';


CREATE TABLE departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_localizacao INTEGER NOT NULL,
                id_gerente INTEGER,
                CONSTRAINT pk_dep PRIMARY KEY (id_departamento)
);
CREATE UNIQUE INDEX departamentos_ak ON departamentos (nome);
COMMENT ON TABLE departamentos IS 'Relacao departamentos
   Atributos: nome, codigo, e chaves estrangeiras de id(empregados e localizacaoes)';
COMMENT ON COLUMN departamentos.id_departamento IS 'Chave primaria da relacao';
COMMENT ON COLUMN departamentos.nome IS 'Atributo com departamento';
COMMENT ON COLUMN departamentos.id_localizacao IS 'Chave estrangeira da localizacaoes dos departamentos';
COMMENT ON COLUMN departamentos.id_gerente IS 'Chave estrangeira de empregados';




CREATE TABLE empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2),
                id_departamento INTEGER,
                id_supervisor INTEGER,
                CONSTRAINT pk_emp PRIMARY KEY (id_empregado)
);

CREATE UNIQUE INDEX empregados_ak ON empregados  (email);
COMMENT ON TABLE empregados IS 'Relação empregados,
   Atributos: email, nome, codigo, data contracao, telefone, salario e comissao;';
COMMENT ON COLUMN empregados.id_empregado IS 'Chave primaria Tabela';
COMMENT ON COLUMN empregados.nome IS 'Atributo com o nome do funcionario';
COMMENT ON COLUMN empregados.email IS 'Atributo com email do funcionario, usando uma chave estrangeira';
COMMENT ON COLUMN empregados.telefone IS 'Atributo do telefone';
COMMENT ON COLUMN empregados.data_contratacao IS 'Atributo da data de contratacao do funcionario';
COMMENT ON COLUMN empregados.id_cargo IS 'Chave estrangeira ';
COMMENT ON COLUMN empregados.salario IS 'atributo do salario';
COMMENT ON COLUMN empregados.comissao IS 'Coluna contendo a taxa de comissao do funcionario';
COMMENT ON COLUMN empregados.id_departamento IS 'Chave estrangeira de departamentos';
COMMENT ON COLUMN empregados.id_supervisor IS 'Chave estrangeira de auto-relacionamento';




CREATE TABLE historico_cargos (
                data_inicial DATE NOT NULL,
                id_empregado INTEGER NOT NULL,
                data_final VARCHAR NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT pk_his PRIMARY KEY (data_inicial, id_empregado)
);
COMMENT ON TABLE historico_cargos IS 'Relação de histórico de cargos dos funcionarios';
COMMENT ON COLUMN historico_cargos.data_inicial IS 'Chave primaria da relacao';
COMMENT ON COLUMN historico_cargos.id_empregado IS 'Chave primaria da relacao';
COMMENT ON COLUMN historico_cargos.id_cargo IS 'Chave estrangeira de empregados e chave primaria da propria tabela';
COMMENT ON COLUMN historico_cargos.id_departamento IS 'Chave primaria da relacao';


ALTER TABLE empregados ADD CONSTRAINT fk_empregados_cargos FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT fk_his_cargos FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE paises ADD CONSTRAINT fk_regioes_pais FOREIGN KEY (id_regiao)
REFERENCES regioes (id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE localizacoes ADD CONSTRAINT fk_localizacoes_pais FOREIGN KEY (id_pais)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE departamentos ADD CONSTRAINT fk_departamentos_dep FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT fk_dep_emp FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT fk_his_dep FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE empregados ADD CONSTRAINT fk_emp_emp FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargos ADD CONSTRAINT fk_emp_his FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/* inserts */
    INSERT INTO regioes (id_regiao, nome) VALUES (1, 'Europe');
    INSERT INTO regioes (id_regiao, nome) VALUES (2, 'Americas');
    INSERT INTO regioes (id_regiao, nome) VALUES (3, 'Asia');
    INSERT INTO regioes (id_regiao, nome) VALUES (4, 'Middle East and Africa');

    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('AR', 2, 'Argentina');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('AU', 3, 'Australia');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('BE', 1, 'Belgium');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('BR', 2, 'Brazil');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('CA', 2, 'Canada');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('CH', 1, 'Switzerland');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('CN', 3, 'China');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('DE', 1, 'Germany');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('DK', 1, 'Denmark');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('EG', 4, 'Egypt');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('FR', 1, 'France');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('IL', 4, 'Israel');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('IN', 3, 'India');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('IT', 1, 'Italy');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('JP', 3, 'Japan');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('KW', 4, 'Kuwait');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('ML', 3, 'Malaysia');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('MX', 2, 'Mexico');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('NG', 4, 'Nigeria');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('NL', 1, 'Netherlands');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('SG', 3, 'Singapore');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('UK', 1, 'United Kingdom');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('US', 2, 'United States of America');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('ZM', 4, 'Zambia');
    INSERT INTO paises (id_pais, id_regiao, nome) VALUES ('ZW', 4, 'Zimbabwe');

    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1000, '1297 Via Cola di Rie', '00989', 'Roma', '', 'IT');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1100, '93091 Calle della Testa', '10934', 'Venice', '', 'IT');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', '', 'JP');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2000, '40-5-12 Laogianggen', '190518', 'Beijing', '', 'CN');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2300, '198 Clementi North', '540198', 'Singapore', '', 'SG');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2400, '8204 Arthur St', '', 'London', '', 'UK');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');
    INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais) VALUES (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');

    INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AD_PRES'
        , 'President'
        , 20080
        , 40000
        );
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AD_VP'
        , 'Administration Vice President'
        , 15000
        , 30000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AD_ASST'
        , 'Administration Assistant'
        , 3000
        , 6000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'FI_MGR'
        , 'Finance Manager'
        , 8200
        , 16000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'FI_ACCOUNT'
        , 'Accountant'
        , 4200
        , 9000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AC_MGR'
        , 'Accounting Manager'
        , 8200
        , 16000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'AC_ACCOUNT'
        , 'Public Accountant'
        , 4200
        , 9000
        );
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'SA_MAN'
        , 'Sales Manager'
        , 10000
        , 20080
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'SA_REP'
        , 'Sales Representative'
        , 6000
        , 12008
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'PU_MAN'
        , 'Purchasing Manager'
        , 8000
        , 15000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'PU_CLERK'
        , 'Purchasing Clerk'
        , 2500
        , 5500
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'ST_MAN'
        , 'Stock Manager'
        , 5500
        , 8500
        );
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'ST_CLERK'
        , 'Stock Clerk'
        , 2008
        , 5000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'SH_CLERK'
        , 'Shipping Clerk'
        , 2500
        , 5500
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'IT_PROG'
        , 'Programmer'
        , 4000
        , 10000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'MK_MAN'
        , 'Marketing Manager'
        , 9000
        , 15000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'MK_REP'
        , 'Marketing Representative'
        , 4000
        , 9000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'HR_REP'
        , 'Human Resources Representative'
        , 4000
        , 9000
        );

INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo) VALUES 
        ( 'PR_REP'
        , 'Public Relations Representative'
        , 4500
        , 10500
        );

    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (120
        , 'Treasury'
        
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (130
        , 'Corporate Tax'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (140
        , 'Control And Credit'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (150
        , 'Shareholder Services'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (160
        , 'Benefits'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (170
        , 'Manufacturing'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (180
        , 'Construction'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (190
        , 'Contracting'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (200
        , 'Operations'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (210
        , 'IT Support'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (220
        , 'NOC'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (230
        , 'IT Helpdesk'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (240
        , 'Government Sales'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (250
        , 'Retail Sales'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (260
        , 'Recruiting'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (270
        , 'Payroll'
        , 1700
        , null);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (30
        , 'Purchasing'
        , 1700
        , 114);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (50
        , 'Shipping'
        , 1500
        , 121);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (60
        , 'IT'
        , 1400
        , 103);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (80
        , 'Sales'
        , 2500
        , 145);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (90
        , 'Executive'
        , 1700
        , 100);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (100
        , 'Finance'
        , 1700
        , 108);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (110
        , 'Accounting'
        , 1700
        , 148);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (10
        , 'Administration'
        , 1700
        , 148);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (20
        , 'Marketing'
        , 1800
        , 148);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (40
        , 'Human Resources'
        , 2400
        , 148);
    INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente) VALUES 
        (70
        , 'Public Relations'
        , 2700
        , 148);

    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (100, 'Steven King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000, null, null, 90);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (101, 'Neena Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000, null, 100, 90);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (102, 'Lex De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000, null, 100, 90);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (103, 'Alexander Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000, null, 102, 60);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (104, 'Bruce Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000, null, 103, 60);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (105, 'David Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800, null, 103, 60);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (106, 'Valli Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800, null, 103, 60);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (107, 'Diana Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200, null, 103, 60);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (108
    , 'Nancy Greenberg'
    , 'NGREENBE'
    , '515.124.4569'
    , '2002-08-17'
    , 'FI_MGR'
    , 12008
    , null
    , 101
    , 100);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (109, 'Daniel Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000, null, 108, 100);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (110, 'John Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200, null, 108, 100);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (111, 'Ismael Sciarra', 'ISCIARRA', '515.124.4369', '2005-09-30', 'FI_ACCOUNT', 7700, null, 108, 100);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (112, 'Jose Manuel Urman', 'JMURMAN', '515.124.4469', '2006-03-07', 'FI_ACCOUNT', 7800, null, 108, 100);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (113, 'Luis Popp', 'LPOPP', '515.124.4567', '2007-12-07', 'FI_ACCOUNT', 6900, null, 108, 100);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
        (114
        , 'Den Raphaely'
        , 'DRAPHEAL'
        , '515.127.4561'
        , '2002-12-07'
        , 'PU_MAN'
        , 11000
        , null
        , 100
        , 30);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (115, 'Alexander Khoo', 'AKHOO', '515.127.4562', '2003-05-18', 'PU_CLERK', 3100, null, 114, 30);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (116, 'Shelli Baida', 'SBAIDA', '515.127.4563', '2005-12-24', 'PU_CLERK', 2900, null, 114, 30);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (117, 'Sigal Tobias', 'STOBIAS', '515.127.4564', '2005-07-24', 'PU_CLERK', 2800, null, 114, 30);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (118, 'Guy Himuro', 'GHIMURO', '515.127.4565', '2006-11-15', 'PU_CLERK', 2600, null, 114, 30);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (119, 'Karen Colmenares', 'KCOLMENA', '515.127.4566', '2007-08-10', 'PU_CLERK', 2500, null, 114, 30);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (120, 'Matthew Weiss', 'MWEISS', '650.123.1234', '2004-07-18', 'ST_MAN', 8000, null, 100, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (121, 'Adam Fripp', 'AFRIPP', '650.123.2234', '2005-04-10', 'ST_MAN', 8200, null, 100, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (122, 'Payam Kaufling', 'PKAUFLIN', '650.123.3234', '2003-05-01', 'ST_MAN', 7900, null, 100, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (123, 'Shanta Vollman', 'SVOLLMAN', '650.123.4234', '2005-10-10', 'ST_MAN', 6500, null, 100, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (124, 'Kevin Mourgos', 'KMOURGOS', '650.123.5234', '2007-11-16', 'ST_MAN', 5800, null, 100, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (125, 'Julia Nayer', 'JNAYER', '650.124.1214', '2005-07-16', 'ST_CLERK', 3200, null, 120, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (126, 'Irene Mikkilineni', 'IMIKKILI', '650.124.1224', '2006-09-28', 'ST_CLERK', 2700, null, 120, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (127, 'James Landry', 'JLANDRY', '650.124.1334', '2007-01-14', 'ST_CLERK', 2400, null, 120, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (128, 'Steven Markle', 'SMARKLE', '650.124.1434', '2008-03-08', 'ST_CLERK', 2200, null, 120, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (129, 'Laura Bissot', 'LBISSOT', '650.124.5234', '2005-08-20', 'ST_CLERK', 3300, null, 121, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (130, 'Mozhe Atkinson', 'MATKINSO', '650.124.6234', '2005-10-30', 'ST_CLERK', 2800, null, 121, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (131, 'James Marlow', 'JAMRLOW', '650.124.7234', '2005-02-16', 'ST_CLERK', 2500, null, 121, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (132, 'TJ Olson', 'TJOLSON', '650.124.8234', '2007-04-10', 'ST_CLERK', 2100, null, 121, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (133, 'Jason Mallin', 'JMALLIN', '650.127.1934', '2004-06-14', 'ST_CLERK', 3300, null, 122, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (134, 'Michael Rogers', 'MROGERS', '650.127.1834', '2006-08-26', 'ST_CLERK', 2900, null, 122, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (135, 'Ki Gee', 'KGEE', '650.127.1734', '2007-12-12', 'ST_CLERK', 2400, null, 122, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (136, 'Hazel Philtanker', 'HPHILTAN', '650.127.1634', '2008-02-06', 'ST_CLERK', 2200, null, 122, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (137, 'Renske Ladwig', 'RLADWIG', '650.121.1234', '2003-07-14', 'ST_CLERK', 3600, null, 123, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (138, 'Stephen Stiles', 'SSTILES', '650.121.2034', '2005-10-26', 'ST_CLERK', 3200, null, 123, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (139, 'John Seo', 'JSEO', '650.121.2019', '2006-02-12', 'ST_CLERK', 2700, null, 123, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (140, 'Joshua Patel', 'JPATEL', '650.121.1834', '2006-04-06', 'ST_CLERK', 2500, null, 123, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (141, 'Trenna Rajs', 'TRAJS', '650.121.8009', '2003-10-17', 'ST_CLERK', 3500, null, 124, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (142, 'Curtis Davies', 'CDAVIES', '650.121.2994', '2005-01-29', 'ST_CLERK', 3100, null, 124, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (143, 'Randall Matos', 'RMATOS', '650.121.2874', '2006-03-15', 'ST_CLERK', 2600, null, 124, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (144, 'Peter Vargas', 'PVARGAS', '650.121.2004', '2006-07-09', 'ST_CLERK', 2500, null, 124, 50);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
        ( 145
        , 'John Russell'
        , 'JRUSSEL'
        , '011.44.1344.429268'
        , '2004-10-01'
        , 'SA_MAN'
        , 14000
        , 0.4
        , 100
        , 80 );
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
    (146, 'Karen Partners', 'KPARTNER', '011.44.1344.467268', '2005-01-05', 'SA_MAN', 13500, .3, 100, 80);
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
        ( 147
        , 'Alberto Errazuriz'
        , 'AERRAZUR'
        , '011.44.1344.429278'
        , '2005-03-10'
        , 'SA_MAN'
        , 12000
        , 0.3
        , 100
        , 80 );
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
        ( 148
        , 'Gerald Cambrault'
        , 'GCAMBRAU'
        , '011.44.1344.619268'
        , '2007-10-15'
        , 'SA_MAN'
        , 11000
        , 0.3
        , 100
        , 80 );
    INSERT INTO empregados (id_empregado, nome, email, telefone, data_contratacao, id_cargo, salario,
    comissao, id_supervisor, id_departamento) VALUES
        ( 149
        , 'Eleni Zlotkey'
        , 'EZLOTKEY'
        , '011.44.1344.429018'
        , '2008-01-29'
        , 'SA_MAN'
        , 10500
        , 0.2
        , 100
        , 80 );

    INSERT INTO historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2001-01-13', '102', '2006-07-24', 60, 'IT_PROG');
    INSERT INTO historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2001-10-28', '101', '2005-03-15', 110, 'AC_MGR');
    INSERT INTO historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2004-02-17', '148', '2007-12-19', 20, 'MK_REP');
    INSERT INTO historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2006-03-24', '114', '2007-12-31', 50, 'ST_CLERK');
    INSERT INTO historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2007-01-01', '122', '2007-12-31', 50, 'ST_CLERK');
    INSERT INTO historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('1995-09-17', '149', '2001-06-17', 90, 'AD_ASST');
    INSERT INTO historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2006-03-24', '136', '2006-12-31', 80, 'SA_REP');
    INSERT INTO historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2007-01-01', '136', '2007-12-31', 80, 'SA_MAN');
    INSERT INTO historico_cargos (data_inicial, id_empregado, data_final, id_departamento, id_cargo) VALUES ('2002-07-01', '147', '2006-12-31', 90, 'AC_ACCOUNT');


ALTER TABLE hr.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;









