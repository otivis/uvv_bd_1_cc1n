CREATE UER 'otavio@localhost' 
IDENTIFIED BY 'senhaboa';

GRANT ALL PRIVILEGES ON * . * TO 'otavio'@'localhost';
FLUSH PRIVILEGES;

CREATE DATABASE uvv
DEFAULT CHARACTER SET= 'UTF8'
DEFAULT COLLATE = 'utf8_general_ci';

SYSTEM mysql -u otavio -p

USE UVV

CREATE TABLE cargos (
id_cargo VARCHAR(10) NOT NULL,
cargo VARCHAR(35) NOT NULL,
salario_minimo DECIMAL(8,2),
salario_maximo DECIMAL(8,2)
);
ALTER TABLE cargos add constraint  PRIMARY KEY (id_cargos);
CREATE UNIQUE INDEX idx_cargos ON cargos (cargo);

CREATE TABLE regioes (
id_regiao INT NOT NULL,
nome VARCHAR(25) NOT NULL
);

ALTER TABLE regioes add constraint  PRIMARY KEY (id_regiao);

CREATE UNIQUE INDEX ak_regioes ON regioes (nome);

CREATE TABLE paises (
id_pais CHAR(2) NOT NULL,
nome VARCHAR(50) NOT NULL ,
id_regiao INT NOT NULL
);

ALTER TABLE paises add constraint PRIMARY KEY(id_pais);

CREATE UNIQUE INDEX ak_paises ON paises (nome);

CREATE TABLE localizacoes (
id_localizacao INT NOT NULL,
endereco VARCHAR(50),
cep VARCHAR(12),
cidade VARCHAR(50),
uf VARCHAR(25),
id_pais CHAR(2) NOT NULL
);

ALTER TABLE localizacoes add constraint  PRIMARY KEY (id_localizacao);

CREATE TABLE departamentos (
id_departamento INTEGER NOT NULL,
nome VARCHAR(50) NOT NULL,
id_localizacao INTEGER NOT NULL,
id_gerente INTEGER
);

ALTER TABLE departamentos add constraint  PRIMARY KEY (id_departamento);
CREATE UNIQUE INDEX ak_departamentos ON departamentos (nome);

CREATE TABLE empregados (
id_empregado INT NOT NULL,
nome VARCHAR(75) NOT NULL DEFAULT " ",
email VARCHAR(35) NOT NULL DEFAULT " ",
telefone VARCHAR(20),
data_contratacao DATE NOT NULL,
id_cargo VARCHAR(10) NOT NULL DEFAULT " ",
salario DECIMAL(8,2),
comissao DECIMAL(4,2),
id_departamento INT,
id_supervisor INT
);

ALTER TABLE empregados add constraint  PRIMARY KEY (id_empregado);
CREATE UNIQUE INDEX ak_empregados ON empregados( email );

CREATE TABLE historico_cargos (
data_inicial DATE NOT NULL,
id_empregado INT NOT NULL,
data_final DATE NOT NULL,
id_cargo VARCHAR(10) NOT NULL DEFAULT " ",
id_departamento INT NOT NULL
);

ALTER TABLE empregados add constraint  PRIMARY KEY (data_inicial,id_empregado);

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
-- Cargos

-- Departamentos
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
SET FOREIGN_KEY_CHECKS=1; 
