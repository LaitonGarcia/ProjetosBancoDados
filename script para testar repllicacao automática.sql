select * from insert_replicacao;
select * from aluno;
select * from professor_temporario;
select * from excecoes_replicacao;

/* truncate aluno cascade;
truncate professor_temporario cascade;
truncate insert_replicacao; 
truncate excecoes_replicacao;*/

-- Tutorial Testando Replicação
-- Certamente você já deverá ter rodado o outro script criando as 
-- tabelas insert_replicacao, update_replicacao e os gatilhos e 
-- a tabela pessoa já esta atualizada com senha, nivel_acesso e tipo_pessoa no BD cad_uespi.

	-- 1º Crie um novo BD no Postgresql cad_uespi_backup, siga o script
create database cad_uespi_backup;

-- drop database cad_uespi_backup;

create table matricula(   -- 1 atributo
id_matricula varchar(7),
constraint matricula_pk primary key (id_matricula)
);

create table curso(    -- 2 atributos
id_curso serial,
nome_curso varchar(50) not null,
constraint curso_pk primary key (id_curso)
);


create table setor(    -- 2 atributos
id_setor serial,
nome_setor varchar (20) not null,
constraint setor_pk primary key (id_setor)
);
alter table setor add constraint unicidade_nome_setor unique (nome_setor);

create table bolsa (     -- 2 atributos
id_bolsa serial,
nome_bolsa varchar(20) not null,
constraint bolsa_pk primary key(id_bolsa),
constraint unicidade_nome_bolsa unique(nome_bolsa)
);

create table disciplina(   -- 2 atributos
id_disciplina serial,
nome_disciplina varchar(50) not null,
constraint disciplina_pk primary key(id_disciplina),
constraint unicidade_nome_disciplina unique(nome_disciplina)
);

create table pessoa(      -- 40 atributos + 1 auto incremento 'data_cadastro' OBS: 2 (status e senha)serão inseridas posteriormente 
cpf varchar(11) unique not null,
nome varchar(50)not null,
nivel_acesso char(1) default 0,    --  intervalo 0-5, status ZERO usuário sem privilegios  
senha varchar(10)default 0,  --  ZERO usuário ainda não cadastrou senha
rg varchar(20)not null,
rg_orgao_emissor varchar(10)not null,
rg_orgao_emissor_uf varchar(2)not null,
rg_data_emissao date not null,
data_nascimento date not null,
nacionalidade varchar(30)not null,
naturalidade varchar (50)not null,
naturalidade_uf char(2) not null,
estado_civil varchar(20) not null,
sexo char(1) not null,
grau_escolaridade varchar(40)not null,
titulo_eleitor varchar(12) not null,
titulo_eleitor_secao varchar(5) not null,
titulo_eleitor_zona varchar(5) not null,
titulo_eleitor_uf char(2)not null,
titulo_eleitor_data_emissao date not null,
certificado_militar_numero varchar(15),
certificado_militar_tipo varchar(15),
certificado_militar_serie varchar(15),
certificado_militar_categoria varchar(15),
certificado_militar_csm varchar(15),
certificado_militar_rm varchar(15),
grupo_sanguineo char(2),
fator_rh varchar(8),
filiacao_mae varchar(50) not null,
filiacao_pai varchar(50),
email varchar(50),
telefone_1 varchar(11) not null,
telefone_2 varchar(11),
data_cadastro date default current_date,
endereco varchar(40) not null,
numero varchar(8) not null,
bairro varchar(20) not null,
municipio varchar(30) not null,
uf char(2) not null,
cep varchar(8) not null,
tipo_pessoa varchar(20),
constraint pessoa_pk primary key(cpf)
);

--alter table pessoa add tipo_pessoa char(2);
--alter table pessoa alter column tipo_pessoa type varchar(20); 
/*sera atribuido valor automático para atributo no insert
a = aluno / s = servidor / pe = professor efetivo / pt = professor temporário / t = terceirizado*/


create table aluno(    -- 0 atributos + (39 atributos + 1 auto incremento 'data_cadastro' OBS: (status e senha)serão inseridas posteriormente)
constraint aluno_pk primary key (cpf)
)inherits (pessoa);

/*    modificado pois precisamos id_aluno_bolsa como primary key
create table aluno_bolsa(   -- 5 atributos
id_setor integer,
id_bolsa integer,
cpf varchar(11),
data_inicio date not null,
data_final date not null,
constraint aluno_bolsa_pk primary key (id_setor,id_bolsa,cpf),
constraint aluno_bolsa_id_setor_fk foreign key(id_setor) references setor(id_setor),
constraint aluno_bolsa_id_bolsa_fk foreign key(id_bolsa) references bolsa(id_bolsa),
constraint aluno_bolsa_cpf_fk foreign key(cpf) references aluno(cpf)
);*/

create table aluno_bolsa(   -- 6 atributos
id_aluno_bolsa serial,
id_setor integer,
id_bolsa integer,
cpf varchar(11),
data_inicio date not null,
data_final date not null,
constraint id_aluno_bolsa_pk primary key (id_aluno_bolsa),
constraint aluno_bolsa_id_setor_fk foreign key(id_setor) references setor(id_setor),
constraint aluno_bolsa_id_bolsa_fk foreign key(id_bolsa) references bolsa(id_bolsa),
constraint aluno_bolsa_cpf_fk foreign key(cpf) references aluno(cpf)
);

create table aluno_curso(   -- 2 atributos
cpf varchar(11),
id_curso integer,
constraint aluno_curso_pk primary key (cpf,id_curso),
constraint aluno_curso_cpf_fk foreign key(cpf) references aluno(cpf),
constraint aluno_curso_id_curso_fk foreign key(id_curso) references curso(id_curso)
);

create table matricula_aluno(  -- 3 atributos
cpf varchar(11), 
id_matricula varchar(7), 
data_matricula date,
constraint matricula_aluno_pk primary key(cpf,id_matricula),
constraint matricula_aluno_cpf_fk foreign key (cpf) references aluno(cpf),
constraint matricula_aluno_id_matricula_fk foreign key (id_matricula) references matricula(id_matricula)
);

create table servidor( -- 11 atributos + (39 atributos + 1 auto incremento 'data_cadastro' OBS: (status e senha)serão inseridas posteriormente)
pis varchar(12) not null,
pis_data_inscricao date,
carteira_trabalho varchar(20) not null,
carteira_trabalho_serie varchar(10) not null,
carteira_trabalho_uf char(2) not null,
carteira_trabalho_data_emissao date not null,
cnh varchar(12),
cnh_categoria varchar(3),
cnh_data_emissao date,
conjuge varchar(50),
conjuge_cpf varchar(11),
constraint servidor_pk primary key (cpf)
)inherits (pessoa);

create table terceirizado(   -- 13 atributos + (39 atributos + 1 auto incremento 'data_cadastro' OBS: (status e senha)serão inseridas posteriormente)
pis varchar(12) not null,
pis_data_inscricao date,
carteira_trabalho varchar(20) not null,
carteira_trabalho_serie varchar(10) not null,
carteira_trabalho_uf char(2) not null,
carteira_trabalho_data_emissao date not null,
data_inicio date not null,
data_recisao date,
cnh varchar(12),
cnh_categoria varchar(3),
cnh_data_emissao date,
conjuge varchar(50),
conjuge_cpf varchar(11),
constraint terceirizado_pk primary key (cpf)
)inherits (pessoa);



create table professor(     -- 11 atributos + (39 atributos + 1 auto incremento 'data_cadastro' OBS: (status e senha)serão inseridas posteriormente)
pis varchar(12) not null,
pis_data_inscricao date,
carteira_trabalho varchar(20) not null,
carteira_trabalho_serie varchar(10) not null,
carteira_trabalho_uf char(2) not null,
carteira_trabalho_data_emissao date not null,
cnh varchar(12),
cnh_categoria varchar(3),
cnh_data_emissao date,
conjuge varchar(50),
conjuge_cpf varchar(11),
constraint professor_pk primary key (cpf)
)inherits (pessoa);

create table professor_temporario(   -- 11 atributos + (39 atributos + 1 auto incremento 'data_cadastro' OBS: (status e senha)serão inseridas posteriormente)
pis varchar(12) not null,
pis_data_inscricao date,
carteira_trabalho varchar(20) not null,
carteira_trabalho_serie varchar(10) not null,
carteira_trabalho_uf char(2) not null,
carteira_trabalho_data_emissao date not null,
cnh varchar(12),
cnh_categoria varchar(3),
cnh_data_emissao date,
conjuge varchar(50),
conjuge_cpf varchar(11),
constraint professor_temporario_pk primary key (cpf)
)inherits (pessoa);

                   
create table disciplina_professor(    -- 4 atributos
id_disciplina integer,
cpf varchar(11),
semestre varchar(1),
ano varchar(4),
constraint disciplina_professor_pk primary key (id_disciplina,cpf),
constraint disciplina_professor_id_disciplina_fk foreign key (id_disciplina) references disciplina(id_disciplina),
constraint disciplina_professor_cpf_fk foreign key (cpf) references professor(cpf)
);
create table disciplina_professor_temporario(  -- 4 atributos
id_disciplina integer,
cpf varchar(11),
semestre varchar(1),
ano varchar(4),
constraint disciplina_professor_temporario_pk primary key (id_disciplina,cpf),
constraint disciplina_professor_temporario_id_disciplina_fk foreign key (id_disciplina) references disciplina(id_disciplina),
constraint disciplina_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf)
);

create table matricula_professor(   -- 3 atributos
id_matricula varchar(7),
cpf varchar(11),
data_matricula date,
constraint matricula_professor_pk primary key(cpf,id_matricula),
constraint matricula_professor_cpf_fk foreign key (cpf) references professor(cpf),
constraint matricula_professor_id_matricula_fk foreign key (id_matricula) references matricula(id_matricula)
);
create table matricula_professor_temporario(  -- 3 atributos
id_matricula varchar(7),
cpf varchar(11),
data_matricula date,
constraint matricula_professor_temporario_pk primary key(cpf,id_matricula),
constraint matricula_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf),
constraint matricula_professor_temporario_id_matricula_fk foreign key (id_matricula) references matricula(id_matricula)
);
create table matricula_servidor(  -- 3 atributos
id_matricula varchar(7),
cpf varchar(11),
data_matricula date,
constraint matricula_servidor_pk primary key(cpf,id_matricula),
constraint matricula_servidor_cpf_fk foreign key (cpf) references servidor(cpf),
constraint matricula_servidor_id_matricula_fk foreign key (id_matricula) references matricula(id_matricula)
);

create table dependente( -- 3 atributos + 1 auto incremento 'id_dependente'
id_dependente serial,
nome varchar(50) not null,
grau_parentesco varchar(20)not null,
data_nascimento date not null,
constraint dependente_pk primary key (id_dependente)
);
create table dependente_servidor(  -- 2 atributos
id_dependente integer,
cpf varchar(11),
constraint dependente_servidor_pk primary key (id_dependente,cpf),
constraint dependente_servidor_id_dependente_fk foreign key (id_dependente) references dependente(id_dependente),
constraint dependente_servidor_cpf_fk foreign key (cpf) references servidor(cpf)
);
create table dependente_professor(  -- 2 atributos
id_dependente integer,
cpf varchar(11),
constraint dependente_professor_pk primary key (id_dependente,cpf),
constraint dependente_professor_id_dependente_fk foreign key (id_dependente) references dependente(id_dependente),
constraint dependente_professor_cpf_fk foreign key (cpf) references professor(cpf)
);
create table dependente_professor_temporario(  -- 2 atributos
id_dependente integer,
cpf varchar(11),
constraint dependente_professor_temporario_pk primary key (id_dependente,cpf),
constraint dependente_professor_temporario_id_dependente_fk foreign key (id_dependente) references dependente(id_dependente),
constraint dependente_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf)
);

create table contrato(      -- 1 atributo
numero_contrato varchar(15),
constraint contrato_pk primary key (numero_contrato)
);
create table contrato_professor_temporario(   --  ATENÇÃO   4 atributos    ATENCAO, 'data_final' é pra ser um gatilho auto incremento
numero_contrato varchar(15),
cpf varchar(11),
data_inicio date not null,
data_final date,
constraint contrato_professor_temporario_pk primary key (numero_contrato,cpf),
constraint contrato_professor_temporario_numero_contrato_fk foreign key (numero_contrato) references contrato(numero_contrato),
constraint contrato_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf)
);

create table formacao(  -- 3 atributos + 1 auto incremento 'id_formacao'
id_formacao serial,
nome varchar(50),
titulacao varchar(50),
lotacao varchar(50),
cpf varchar(11),
constraint formacao_pk primary key (id_formacao)
);

-- alter table formacao add column cpf varchar(11);
 
create table formacao_servidor(   -- 2 atributos
id_formacao integer,
cpf varchar(11),
constraint formacao_servidor_pk primary key (id_formacao,cpf),
constraint formacao_servidor_id_formacao_fk foreign key (id_formacao) references formacao(id_formacao),
constraint formacao_servidor_cpf_fk foreign key (cpf) references servidor(cpf)
);
create table formacao_professor(  -- 2 atributos
id_formacao integer,
cpf varchar(11),
constraint formacao_professor_pk primary key (id_formacao,cpf),
constraint formacao_professor_id_formacao_fk foreign key (id_formacao) references formacao(id_formacao),
constraint formacao_professor_cpf_fk foreign key (cpf) references professor(cpf)
);
create table formacao_professor_temporario(   -- 2 atributos
id_formacao integer,
cpf varchar(11),
constraint formacao_professor_temporario_pk primary key (id_formacao,cpf),
constraint formacao_professor_temporario_id_formacao_fk foreign key (id_formacao) references formacao(id_formacao),
constraint formacao_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf)
);
 
	-- 2º Agora utilize os comandos para limpar as tabelas do cad_uespi: 

truncate insert_replicacao;
truncate update_replicacao;
truncate excecoes_replicacao;
truncate aluno cascade;
truncate professor_temporario cascade;

	-- 3º Povoe o cad_uespi com estes dados:

insert into aluno (cpf, nome, nivel_acesso, senha, rg, rg_orgao_emissor, 
	rg_orgao_emissor_uf , rg_data_emissao, data_nascimento, nacionalidade, 
	naturalidade, naturalidade_uf, estado_civil, sexo, grau_escolaridade, 
	titulo_eleitor, titulo_eleitor_secao, titulo_eleitor_zona, titulo_eleitor_uf, 
	titulo_eleitor_data_emissao, certificado_militar_numero, certificado_militar_tipo, 
	certificado_militar_serie, certificado_militar_categoria, certificado_militar_csm, 
	certificado_militar_rm, grupo_sanguineo, fator_rh, filiacao_mae, filiacao_pai, 
	email, telefone_1, telefone_2, endereco, numero, bairro, municipio, uf, cep, tipo_pessoa) 
values
	('11111111111', 'rubens lopes', '1','111','2791136', 'NI', 'PI', '1994-05-26', 
	'1989-01-14', 'Brasileiro', 'Floriano', 'PI','Solteiro', 'F', 'Superior Incompleto', 
	'036303011511', '39', '61', 'PI', '2007-03-13', '111111111111', 'abc', '432', 'dc', 
	'55555', 'ddd', 'a+', '22222222', 'PEDRA P DE SOUSA', 'ABRAAO O DE SOUSA', 
	'juliana@hotmail.com', '8935224351', '8994567654', 'MANOEL DE S SANTOS', '50', 
	'EMÍLIO FALCÃO', 'Floriano', 'PI', '64800000', 'aluno'),
	 
	('22222222222', 'laiton garcia', '1','111','2791136', 'NI', 'PI', '1994-05-26', 
	'1989-01-14', 'Brasileiro', 'Floriano', 'PI','Solteiro', 'F', 'Superior Incompleto', 
	'036303011511', '39', '61', 'PI', '2007-03-13', '111111111111', 'abc', '432', 'dc', 
	'55555', 'ddd', 'a+', '22222222', 'PEDRA P DE SOUSA', 'ABRAAO O DE SOUSA', 
	'juliana@hotmail.com', '8935224351', '8994567654', 'MANOEL DE S SANTOS', '50', 
	'EMÍLIO FALCÃO', 'Floriano', 'PI', '64800000', 'aluno');

--update aluno set nome = 'xxxxxxx xxxxxxx' where cpf ='22222222222';

insert into professor_temporario (cpf,nome,nivel_acesso, senha,rg,rg_orgao_emissor,
	rg_orgao_emissor_uf ,rg_data_emissao,data_nascimento,nacionalidade,
	naturalidade,naturalidade_uf,estado_civil, sexo,grau_escolaridade,titulo_eleitor,
	titulo_eleitor_secao,titulo_eleitor_zona,titulo_eleitor_uf,titulo_eleitor_data_emissao,
	certificado_militar_numero,certificado_militar_tipo, certificado_militar_serie,
	certificado_militar_categoria,certificado_militar_csm,certificado_militar_rm,
	grupo_sanguineo,fator_rh,filiacao_mae,filiacao_pai,email,telefone_1,telefone_2,
	endereco,numero,bairro,municipio,uf,cep,pis,pis_data_inscricao,carteira_trabalho,
	carteira_trabalho_serie,carteira_trabalho_uf,carteira_trabalho_data_emissao,
	cnh,cnh_categoria,cnh_data_emissao,conjuge,conjuge_cpf, tipo_pessoa ) 
values 
	('67923267391','Aliprecídio José de Siqueira Filho', '1','111','362341473',
	'SSP-SP','PI','1998-05-26','1974-07-10','Brasileiro','Arraial','PI','Divorciado','M',
	'Mestrado','016857091570','0013','0077','PI','1991-03-13','010200449','xxxxxxxxxxxxxxx',
	'aaaaaaaaaaaaaaa','aaaaaaaaaaaaaa','111111111111111','111111111111111','aa','11111111',
	'Maria Siqueira','Jose Pimenteira','jose@hotmail.com','8994155668','8994719494',
	'Rua Francilma de Dias','50','Cajueiro II','Floriano','PI','64800000','aaaaaaaaaaaa',
	'1993-05-12','11111111111111111111','1111111111','PI','1993-05-12','01643343974',
	'ab','2010-12-27', 'não tem','não tem', 'professor_temporario');

--update professor_temporario set nome = 'yyyyyyyy yyyyyyyyy' where cpf ='67923267391';

insert into aluno (cpf, nome, nivel_acesso, senha, rg, rg_orgao_emissor, 
	rg_orgao_emissor_uf , rg_data_emissao, data_nascimento, nacionalidade, 
	naturalidade, naturalidade_uf, estado_civil, sexo, grau_escolaridade, 
	titulo_eleitor, titulo_eleitor_secao, titulo_eleitor_zona, titulo_eleitor_uf, 
	titulo_eleitor_data_emissao, certificado_militar_numero, certificado_militar_tipo, 
	certificado_militar_serie, certificado_militar_categoria, certificado_militar_csm, 
	certificado_militar_rm, grupo_sanguineo, fator_rh, filiacao_mae, filiacao_pai, 
	email, telefone_1, telefone_2, endereco, numero, bairro, municipio, uf, cep, tipo_pessoa) 
values
	('33333333333', 'joao batista', '1','111','2791136', 'NI', 'PI', '1994-05-26', 
	'1989-01-14', 'Brasileiro', 'Floriano', 'PI','Solteiro', 'F', 'Superior Incompleto', 
	'036303011511', '39', '61', 'PI', '2007-03-13', '111111111111', 'abc', '432', 'dc', 
	'55555', 'ddd', 'a+', '22222222', 'PEDRA P DE SOUSA', 'ABRAAO O DE SOUSA', 
	'juliana@hotmail.com', '8935224351', '8994567654', 'MANOEL DE S SANTOS', '50', 
	'EMÍLIO FALCÃO', 'Floriano', 'PI', '64800000', 'aluno');

insert into professor_temporario (cpf,nome,nivel_acesso, senha,rg,rg_orgao_emissor,
	rg_orgao_emissor_uf ,rg_data_emissao,data_nascimento,nacionalidade,
	naturalidade,naturalidade_uf,estado_civil, sexo,grau_escolaridade,titulo_eleitor,
	titulo_eleitor_secao,titulo_eleitor_zona,titulo_eleitor_uf,titulo_eleitor_data_emissao,
	certificado_militar_numero,certificado_militar_tipo, certificado_militar_serie,
	certificado_militar_categoria,certificado_militar_csm,certificado_militar_rm,
	grupo_sanguineo,fator_rh,filiacao_mae,filiacao_pai,email,telefone_1,telefone_2,
	endereco,numero,bairro,municipio,uf,cep,pis,pis_data_inscricao,carteira_trabalho,
	carteira_trabalho_serie,carteira_trabalho_uf,carteira_trabalho_data_emissao,
	cnh,cnh_categoria,cnh_data_emissao,conjuge,conjuge_cpf, tipo_pessoa ) 
values 
	('41255852100','aaaaaa bbbb cccc ddddddd', '1','111','362341473',
	'SSP-SP','PI','1998-05-26','1974-07-10','Brasileiro','Arraial','PI','Divorciado','M',
	'Mestrado','016857091570','0013','0077','PI','1991-03-13','010200449','xxxxxxxxxxxxxxx',
	'aaaaaaaaaaaaaaa','aaaaaaaaaaaaaa','111111111111111','111111111111111','aa','11111111',
	'Maria Siqueira','Jose Pimenteira','jose@hotmail.com','8994155668','8994719494',
	'Rua Francilma de Dias','50','Cajueiro II','Floriano','PI','64800000','aaaaaaaaaaaa',
	'1993-05-12','11111111111111111111','1111111111','PI','1993-05-12','01643343974',
	'ab','2010-12-27', 'não tem','não tem', 'professor_temporario');

	-- 4º Confira tabelas no cad_uespi:
	
select * from professor_temporario;
select * from aluno;
select * from insert_replicacao;
select * from update_replicacao;
select * from excecoes_replicacao;

	-- 5º Antes de rodar o aplicativo CadUespi versão CadUespi_POO_2015_06_08 verifique
	    -- as senhas de acesso de seu usuário postgres nas classes ConnectionFactory 
		-- e ConnectionFactoryCliente em dao.conexao.
		
	-- 6º Agora rode o aplicativo CadUespi versão CadUespi_POO_2015_06_08.
	
	-- 7º Confira replicação nas tabelas aluno e professor_temporario no BD cad_uespi_backup:
	
select * from professor_temporario;
select * from aluno;

	-- 8º Agora insira outro aluno no cad_uespi:
	
insert into aluno (cpf, nome, nivel_acesso, senha, rg, rg_orgao_emissor, 
	rg_orgao_emissor_uf , rg_data_emissao, data_nascimento, nacionalidade, 
	naturalidade, naturalidade_uf, estado_civil, sexo, grau_escolaridade, 
	titulo_eleitor, titulo_eleitor_secao, titulo_eleitor_zona, titulo_eleitor_uf, 
	titulo_eleitor_data_emissao, certificado_militar_numero, certificado_militar_tipo, 
	certificado_militar_serie, certificado_militar_categoria, certificado_militar_csm, 
	certificado_militar_rm, grupo_sanguineo, fator_rh, filiacao_mae, filiacao_pai, 
	email, telefone_1, telefone_2, endereco, numero, bairro, municipio, uf, cep, tipo_pessoa) 
values
	('66666666666', 'eu sou o temporizador', '1','111','2791136', 'NI', 'PI', '1994-05-26', 
	'1989-01-14', 'Brasileiro', 'Floriano', 'PI','Solteiro', 'F', 'Superior Incompleto', 
	'036303011511', '39', '61', 'PI', '2007-03-13', '111111111111', 'abc', '432', 'dc', 
	'55555', 'ddd', 'a+', '22222222', 'PEDRA P DE SOUSA', 'ABRAAO O DE SOUSA', 
	'juliana@hotmail.com', '8935224351', '8994567654', 'MANOEL DE S SANTOS', '50', 
	'EMÍLIO FALCÃO', 'Floriano', 'PI', '64800000', 'aluno');
	
	-- 9º Paciência, confira rotina temporizada na tabela aluno no cad_uespi_backup, 
	      -- deve repetir a cada 2 minutos:
select * from aluno;

	-- 10º Só pra confirmar repita ações:

insert into aluno (cpf, nome, nivel_acesso, senha, rg, rg_orgao_emissor, 
	rg_orgao_emissor_uf , rg_data_emissao, data_nascimento, nacionalidade, 
	naturalidade, naturalidade_uf, estado_civil, sexo, grau_escolaridade, 
	titulo_eleitor, titulo_eleitor_secao, titulo_eleitor_zona, titulo_eleitor_uf, 
	titulo_eleitor_data_emissao, certificado_militar_numero, certificado_militar_tipo, 
	certificado_militar_serie, certificado_militar_categoria, certificado_militar_csm, 
	certificado_militar_rm, grupo_sanguineo, fator_rh, filiacao_mae, filiacao_pai, 
	email, telefone_1, telefone_2, endereco, numero, bairro, municipio, uf, cep, tipo_pessoa) 
values
	('77777777777', 'o temporizador funfou', '1','111','2791136', 'NI', 'PI', '1994-05-26', 
	'1989-01-14', 'Brasileiro', 'Floriano', 'PI','Solteiro', 'F', 'Superior Incompleto', 
	'036303011511', '39', '61', 'PI', '2007-03-13', '111111111111', 'abc', '432', 'dc', 
	'55555', 'ddd', 'a+', '22222222', 'PEDRA P DE SOUSA', 'ABRAAO O DE SOUSA', 
	'juliana@hotmail.com', '8935224351', '8994567654', 'MANOEL DE S SANTOS', '50', 
	'EMÍLIO FALCÃO', 'Floriano', 'PI', '64800000', 'aluno');

	-- 11º Paciência, confira no cad_uespi_backup:
select * from aluno;

	-- 12º Pode inserir um novo aluno pelo aplicativo, sem finalizá-lo, 
		-- e conferir novamente no cad_uespi_backup.

/* 
select true from pg_tables from table_name = 'pessoa';
select * from pg_class;
select true from table_name = "pessoa";
SELECT true
FROM information_schema.tables
WHERE table_name = 'pessoa';

SELECT * FROM information_schema.tables WHERE table_name = 'arara';*/
 