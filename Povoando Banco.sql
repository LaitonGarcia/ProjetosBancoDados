create table matricula(
id_matricula varchar(7),
constraint matricula_pk primary key (id_matricula)
)


create table curso(
id_curso serial,
nome_curso varchar(50) not null,
constraint curso_pk primary key (id_curso)
)


create table setor(
id_setor serial,
nome_setor varchar (20) not null,
constraint setor_pk primary key (id_setor)
)
alter table setor add constraint unicidade_nome_setor unique (nome_setor);

create table bolsa (
id_bolsa serial,
nome_bolsa varchar(20) not null,
constraint bolsa_pk primary key(id_bolsa),
constraint unicidade_nome_bolsa unique(nome_bolsa)
)

create table disciplina(
id_disciplina serial,
nome_disciplina varchar(50) not null,
constraint disciplina_pk primary key(id_disciplina),
constraint unicidade_nome_disciplina unique(nome_disciplina)
)

create table pessoa(        -- 38 atributos sendo 1 auto incremento 'data_cadastro'
cpf varchar(11) unique not null,
nome varchar(50)not null,
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
grau_escolaridade varchar(20)not null,
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
filiacao_pai varchar(50)not null,
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
constraint pessoa_pk primary key(cpf)
)

create table aluno(
constraint aluno_pk primary key (cpf)
)inherits (pessoa);

create table aluno_bolsa(
id_setor integer,
id_bolsa integer,
cpf varchar(11),
data_inicio date not null,
data_final date not null,
constraint aluno_bolsa_pk primary key (id_setor,id_bolsa,cpf),
constraint aluno_bolsa_id_setor_fk foreign key(id_setor) references setor(id_setor),
constraint aluno_bolsa_id_bolsa_fk foreign key(id_bolsa) references bolsa(id_bolsa),
constraint aluno_bolsa_cpf_fk foreign key(cpf) references aluno(cpf)
);

create table aluno_curso(
cpf varchar(11),
id_curso integer,
constraint aluno_curso_pk primary key (cpf,id_curso),
constraint aluno_curso_cpf_fk foreign key(cpf) references aluno(cpf),
constraint aluno_curso_id_curso_fk foreign key(id_curso) references curso(id_curso)
);

create table matricula_aluno(
cpf varchar(11), 
id_matricula varchar(7), 
data_matricula date,
constraint matricula_aluno_pk primary key(cpf,id_matricula),
constraint matricula_aluno_cpf_fk foreign key (cpf) references aluno(cpf),
constraint matricula_aluno_id_matricula_fk foreign key (id_matricula) references matricula(id_matricula)
);

create table servidor(
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

create table terceirizado(
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


create table professor(
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

create table professor_temporario(
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

                   
create table disciplina_professor(
id_disciplina integer,
cpf varchar(11),
semestre varchar(1),
ano varchar(4),
constraint disciplina_professor_pk primary key (id_disciplina,cpf),
constraint disciplina_professor_id_disciplina_fk foreign key (id_disciplina) references disciplina(id_disciplina),
constraint disciplina_professor_cpf_fk foreign key (cpf) references professor(cpf)
);
create table disciplina_professor_temporario(
id_disciplina integer,
cpf varchar(11),
semestre varchar(1),
ano varchar(4),
constraint disciplina_professor_temporario_pk primary key (id_disciplina,cpf),
constraint disciplina_professor_temporario_id_disciplina_fk foreign key (id_disciplina) references disciplina(id_disciplina),
constraint disciplina_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf)
);


create table matricula_professor(
id_matricula varchar(7),
cpf varchar(11),
data_matricula date,
constraint matricula_professor_pk primary key(cpf,id_matricula),
constraint matricula_professor_cpf_fk foreign key (cpf) references professor(cpf),
constraint matricula_professor_id_matricula_fk foreign key (id_matricula) references matricula(id_matricula)
);
create table matricula_professor_temporario(
id_matricula varchar(7),
cpf varchar(11),
data_matricula date,
constraint matricula_professor_temporario_pk primary key(cpf,id_matricula),
constraint matricula_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf),
constraint matricula_professor_temporario_id_matricula_fk foreign key (id_matricula) references matricula(id_matricula)
);
create table matricula_servidor(
id_matricula varchar(7),
cpf varchar(11),
data_matricula date,
constraint matricula_servidor_pk primary key(cpf,id_matricula),
constraint matricula_servidor_cpf_fk foreign key (cpf) references servidor(cpf),
constraint matricula_servidor_id_matricula_fk foreign key (id_matricula) references matricula(id_matricula)
);

create table dependente(
id_dependente serial,
nome varchar(50) not null,
grau_parentesco varchar(20)not null,
data_nascimento date not null,
constraint dependente_pk primary key (id_dependente)
);
create table dependente_servidor(
id_dependente integer,
cpf varchar(11),
constraint dependente_servidor_pk primary key (id_dependente,cpf),
constraint dependente_servidor_id_dependente_fk foreign key (id_dependente) references dependente(id_dependente),
constraint dependente_servidor_cpf_fk foreign key (cpf) references servidor(cpf)
);
create table dependente_professor(
id_dependente integer,
cpf varchar(11),
constraint dependente_professor_pk primary key (id_dependente,cpf),
constraint dependente_professor_id_dependente_fk foreign key (id_dependente) references dependente(id_dependente),
constraint dependente_professor_cpf_fk foreign key (cpf) references professor(cpf)
);
create table dependente_professor_temporario(
id_dependente integer,
cpf varchar(11),
constraint dependente_professor_temporario_pk primary key (id_dependente,cpf),
constraint dependente_professor_temporario_id_dependente_fk foreign key (id_dependente) references dependente(id_dependente),
constraint dependente_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf)
);

create table contrato(
numero_contrato varchar(15),
constraint contrato_pk primary key (numero_contrato)
);
create table contrato_professor_temporario(
numero_contrato varchar(15),
cpf varchar(11),
data_inicio date not null,
data_final date,
constraint contrato_professor_temporario_pk primary key (numero_contrato,cpf),
constraint contrato_professor_temporario_numero_contrato_fk foreign key (numero_contrato) references contrato(numero_contrato),
constraint contrato_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf)
);

create table formacao(
id_formacao serial,
nome varchar(50),
titulacao varchar(50),
lotacao varchar(50),
constraint formacao_pk primary key (id_formacao)
);
create table formacao_servidor(
id_formacao integer,
cpf varchar(11),
constraint formacao_servidor_pk primary key (id_formacao,cpf),
constraint formacao_servidor_id_formacao_fk foreign key (id_formacao) references formacao(id_formacao),
constraint formacao_servidor_cpf_fk foreign key (cpf) references servidor(cpf)
);
create table formacao_professor(
id_formacao integer,
cpf varchar(11),
constraint formacao_professor_pk primary key (id_formacao,cpf),
constraint formacao_professor_id_formacao_fk foreign key (id_formacao) references formacao(id_formacao),
constraint formacao_professor_cpf_fk foreign key (cpf) references professor(cpf)
);
create table formacao_professor_temporario(
id_formacao integer,
cpf varchar(11),
constraint formacao_professor_temporario_pk primary key (id_formacao,cpf),
constraint formacao_professor_temporario_id_formacao_fk foreign key (id_formacao) references formacao(id_formacao),
constraint formacao_professor_temporario_cpf_fk foreign key (cpf) references professor_temporario(cpf)
);


/*         escolher forma de contrato temporario

alter table professor_temporario add column contrato_1 varchar(15),
		                 add column contrato_1_data_inicio date,
		                 add column contrato_1_data_final date,
		                 add column contrato_2 varchar(15),
		                 add column contrato_2_data_inicio date,
		                 add column contrato_2_data_final date;


      --  ou formação
                
alter table servidor add column formacao_1 varchar(50),
		     add column formacao_1_titulacao varchar(50),
		     add column formacao_1_lotacao varchar(50),	
		     add column formacao_2 varchar(50),
		     add column formacao_2_titulacao varchar(50),
		     add column formacao_2_lotacao varchar(50),

alter table professor add column formacao_1 varchar(50),
		     add column formacao_1_titulacao varchar(50),
		     add column formacao_1_lotacao varchar(50),	
		     add column formacao_2 varchar(50),
		     add column formacao_2_titulacao varchar(50),
		     add column formacao_2_lotacao varchar(50),

alter table professor_temporario 
		     add column formacao_1 varchar(50),
		     add column formacao_1_titulacao varchar(50),
		     add column formacao_1_lotacao varchar(50),	
		     add column formacao_2 varchar(50),
		     add column formacao_2_titulacao varchar(50),
		     add column formacao_2_lotacao varchar(50),
*/
                   


		/*Povoando tabelas*/

delete from professor_temporario where cpf = '67923267391';

select * from professor_temporario;
select * from contrato;
select * from contrato_professor_temporario;
select * from disciplina;
select * from disciplina_professor_temporario;
select * from formacao;
select * from formacao_professor_temporario;
select * from dependente;
select * from dependente_professor_temporario;
select * from matricula;
select * from matricula_professor_temporario;
select * from insert_replicacao;
select * from update_replicacao;
truncate insert_replicacao; -- ou delete from insert_replicacao; -- mas deletar não limpa memoria
truncate update_replicacao; -- ou delete from update_replicacao; -- mas deletar não limpa memoria


insert into professor_temporario (cpf,nome,nivel_acesso, senha,rg,rg_orgao_emissor ,rg_orgao_emissor_uf ,rg_data_emissao,data_nascimento,nacionalidade,naturalidade,naturalidade_uf,estado_civil,
sexo,grau_escolaridade,titulo_eleitor,titulo_eleitor_secao,titulo_eleitor_zona,titulo_eleitor_uf,titulo_eleitor_data_emissao,certificado_militar_numero,certificado_militar_tipo,
certificado_militar_serie,certificado_militar_categoria,certificado_militar_csm,certificado_militar_rm,grupo_sanguineo,fator_rh,filiacao_mae,filiacao_pai,email,telefone_1,
telefone_2,endereco,numero,bairro,municipio,uf,cep,pis,pis_data_inscricao,carteira_trabalho,carteira_trabalho_serie,carteira_trabalho_uf,carteira_trabalho_data_emissao,
cnh,cnh_categoria,cnh_data_emissao,conjuge,conjuge_cpf, tipo_pessoa ) values (
'67923267391','Aliprecídio José de Siqueira Filho', '1','111','362341473',
'SSP-SP','PI','1998-05-26','1974-07-10','Brasileiro','Arraial','PI','Divorciado','M',
'Mestrado','016857091570','0013','0077','PI','1991-03-13','010200449','xxxxxxxxxxxxxxx',
'aaaaaaaaaaaaaaa','aaaaaaaaaaaaaa','111111111111111','111111111111111','aa','11111111',
'Maria Siqueira','Jose Pimenteira','jose@hotmail.com','8994155668','8994719494',
'Rua Francilma de Dias','50','Cajueiro II','Floriano','PI','64800000','aaaaaaaaaaaa','1993-05-12','11111111111111111111','1111111111','PI','1993-05-12','01643343974','ab','2010-12-27',
'não tem','não tem', 'pt');


insert into contrato (numero_contrato) values ('111111111111111');

insert into contrato_professor_temporario(numero_contrato,cpf,data_inicio,data_final) values ('111111111111111','67923267391','2014-06-25',
'2016-06-25');

insert into disciplina (nome_disciplina) values 
('Programação Comercial')
('Direiro Previdenciario')
('Biologia Celular');

insert into disciplina_professor_temporario(id_disciplina,cpf,semestre,ano) values (
	1,'67923267391','1','2014'
);

insert into formacao(nome,titulacao,lotacao) values 
	('Docencia do Ensino Superior','Especialização','Floriano')
	('Docencia do Ensino Superior','Especialização','Floriano');

insert into formacao_professor_temporario(id_formacao,cpf) values (
1,'67923267391'
);

insert into dependente(nome,grau_parentesco,data_nascimento) values 
('Marcos Luan Bueno Siqueira','Filho','2002-03-26')
('Hilbenia Lunane Bueno Siqueira','Filha','2012-05-08');


insert into dependente_professor_temporario(id_dependente,cpf) values
(1,'67923267391')
(2,'67923267391');

insert into matricula(id_matricula) values
(1111111),
(2222222),
(3333333);

insert into matricula_professor_temporario(id_matricula,cpf,data_matricula) values ('1111111','67923267391','2014-06-25');

        -- CADASTRANDO ALUNO
select * from aluno;
insert into aluno (cpf, nome, nivel_acesso, senha, rg, rg_orgao_emissor, rg_orgao_emissor_uf , rg_data_emissao, 
	data_nascimento, nacionalidade, naturalidade, naturalidade_uf, estado_civil, sexo, 
	grau_escolaridade, titulo_eleitor, titulo_eleitor_secao, titulo_eleitor_zona, 
	titulo_eleitor_uf, titulo_eleitor_data_emissao, certificado_militar_numero, 
	certificado_militar_tipo, certificado_militar_serie, certificado_militar_categoria, 
	certificado_militar_csm, certificado_militar_rm, grupo_sanguineo, fator_rh, 
	filiacao_mae, filiacao_pai, email, telefone_1, telefone_2, endereco, numero, bairro, municipio, uf, cep, tipo_pessoa) 
values
('11111111111', 'laiton garcia', '1','111','2791136', 'NI', 'PI', '1994-05-26', '1989-01-14', 
'Brasileiro', 'Floriano', 'PI','Solteiro', 'F', 'Superior Incompleto', '036303011511', '39', '61', 'PI', 
'2007-03-13', '111111111111', 'abc', '432', 'dc', '55555', 'ddd', 'a+', '22222222', 'PEDRA P DE SOUSA', 
'ABRAAO O DE SOUSA', 'juliana@hotmail.com', '8935224351', '8994567654', 'MANOEL DE S SANTOS', '50', 
'EMÍLIO FALCÃO', 'Floriano', 'PI', '64800000', 'aluno');

update aluno set nome = 'joão batista' where cpf ='11111111111';


select * from insert_replicacao;
select * from update_replicacao;
truncate insert_replicacao;
truncate update_replicacao;
select * from aluno;
truncate aluno cascade;
select * from professor_temporario;
truncate professor_temporario cascade;

insert into insert_replicacao(cpf,tipo_pessoa) 
values('02881476341','aluno'),
('11111111111','aluno'),('22222222222','professor'),('33333333333','aluno'),('44444444444','terceirizado');

insert into update_replicacao(cpf,tipo_pessoa) 
values('77777777777','aluno'),
('11111111111','servidor');--('22222222222','d'),('33333333333','t'),('44444444444','g'),('55555555555','h');



