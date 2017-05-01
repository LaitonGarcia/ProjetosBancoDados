-- Database: "Biblioteca"

-- DROP DATABASE "Biblioteca";

CREATE DATABASE "Biblioteca"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;

create table tipo_usuario (
id_tipo_usuario serial,
descricao       varchar(50),
qtd_dias_emprestimo integer,
qtd_publicacoes integer,
valor_multa numeric(8,2)
);

alter table tipo_usuario alter column id_tipo_usuario set not null;
alter table tipo_usuario alter column descricao set not null;
alter table tipo_usuario alter column qtd_dias_emprestimo set not null;
alter table tipo_usuario add constraint tipo_usuario_pk primary key (id_tipo_usuario);
alter table tipo_usuario alter column valor_multa set default 1.00;




create table funcionario(
matricula serial,
nome varchar (50),
senha varchar(20)
);
alter table funcionario alter column matricula set not null;
alter table funcionario alter column nome set not null;
alter table funcionario alter column senha set not null;
alter table funcionario add constraint funcionario_pk primary key (matricula);


create table tipo_publicacao (
id_tipo_publicacao serial,
descricao varchar (50)
);
alter table tipo_publicacao alter column id_tipo_publicacao set not null;
alter table tipo_publicacao alter column descricao set not null;
alter table tipo_publicacao add constraint tipo_publicacao_pk primary key (id_tipo_publicacao);

create table usuario(
id_usuario serial,
nome_completo varchar(40),
nome_usuario varchar(21),
senha varchar(21),
id_tipo_usuario integer
);

alter table usuario alter column id_usuario set not null;
alter table usuario alter column nome_completo set not null;
alter table usuario alter column nome_usuario set not null;
alter table usuario alter column senha set not null;
alter table usuario alter column id_tipo_usuario set not null;
alter table usuario add constraint usuario_pk primary key (id_usuario);
alter table usuario add constraint usuario_fk foreign key (id_tipo_usuario) references tipo_usuario (id_tipo_usuario) ; 



create table publicacao(
id_publicacao serial,
titulo varchar(50),
ano_publicacao integer,
id_tipo_publicacao integer
);
alter table publicacao alter column id_publicacao set not null;
alter table publicacao alter column titulo set not null;
alter table publicacao alter column ano_publicacao set not null;
alter table publicacao alter column id_tipo_publicacao set not null;
alter table publicacao add constraint publicacao_pk primary key (id_publicacao);
alter table publicacao add constraint publicacao_fk foreign key (id_tipo_publicacao) references tipo_publicacao(id_tipo_publicacao); 


create table reserva (
id_reserva serial,
data_reserva date,
id_usuario integer,
id_publicacao integer
);
alter table reserva alter column id_reserva set not null,
	alter column data_reserva set not null,   
	alter column id_usuario set not null,
	alter column id_publicacao set not null,
	add constraint reserva_pk primary key (id_reserva),
	add constraint reserva_usuario_fk foreign key (id_usuario) references usuario(id_usuario),
	add constraint reserva_publicacao_fk foreign key (id_publicacao) references publicacao(id_publicacao);

create table exemplar (
id_exemplar serial,
isbn varchar (13),
status varchar(20),
id_publicacao integer
);
alter table exemplar alter column id_exemplar set not null,
	alter column isbn set not null,
	alter column status set not null,
	alter column id_publicacao set not null,
	add constraint exemplar_pk primary key (id_exemplar),
	add constraint exemplar_fk foreign key (id_publicacao) references publicacao(id_publicacao);

create table emprestimo (
id_emprestimo serial,
data_emprestimo date,
data_prevista_devolucao date,
multa numeric (8,2),
id_usuario integer,
id_exemplar integer,
matricula integer
);
alter table emprestimo alter column id_emprestimo set not null,
	alter column data_emprestimo set not null,
	alter column id_usuario set not null,
	alter column id_exemplar set not null,
	alter column matricula set not null,
	add constraint emprestimo_pk primary key (id_emprestimo),
	add constraint emprestimo_usuario_fk foreign key (id_usuario) references usuario (id_usuario),
	add constraint emprestimo_exemplar_fk foreign key (id_exemplar) references exemplar (id_exemplar),
	add constraint emprestimo_matricula_fk foreign key (matricula) references funcionario(matricula);
alter table emprestimo alter column data_emprestimo set default current_date;
alter table emprestimo alter column data_prevista_devolucao set default current_date + integer '7';
alter table emprestimo alter column multa set default 0.00;





-- POVOANDO TABELA FUNCIONARIO

insert into funcionario(nome,senha) values
('Luis Augusto',11111),
('Rubens Lopes',22222),
('Laiton Garcia',33333),
('João Batista',44444),
('Felipe Mateus',55555);

	
-- POVOANDO TABELA TIPO_USUARIO

insert into tipo_usuario(descricao,qtd_dias_emprestimo,qtd_publicacoes,valor_multa) values
('ALUNO',7,3,1.00),
('PROFESSOR',7,4,1.00),
('SERVIDOR',7,3,1.00);


-- POVOANDO TABELA TIPO_PUBLICAÇÃO

insert into tipo_publicacao(descricao) values
('MONOGRAFIA'),
('PERIODICO'),
('FASCICULO'),
('ARTIGO');


-- POVOANDO TABELA USUARIO

insert into usuario(nome_completo,nome_usuario,senha,id_tipo_usuario) values 
('Maria Luiza Silva','maria',777,1),
('Luis Roberto','luis',999,3),
('João Pimenta','joao',888,2),
('Fulano de Tal','fulano',666,2),
('Raimundo Pereira','raimundo',222,1),
('Arnaldo Jabor','jabor',333,2),
('Amarildo Sousa','sousa',444,1);





-- POVOANDO TABELA PUBLICAÇÃO

insert into publicacao(titulo,ano_publicacao,id_tipo_publicacao) values
('PostgreSQL',2010,4),
('Arte da Guerra',1500,1),
('O Meu Chefe é um Idiota',2000,1),
('Galileu',2014,2),
('Enciclopedia Barsa',1800,3);


-- POVOANDO TABELA EXEMPLAR

insert into exemplar(isbn,status,id_publicacao) values 
('AAAA1111','OK',1),
('BBBB2222','OK',2),
('CCCC3333','OK',3),
('DDDD4444','OK',4),
('EEEE5555','OK',5),
('AAAA1111','OK',1);


-- POVOANDO TABELA RESERVA 

insert into reserva(data_reserva,id_usuario,id_publicacao) values

('2014-05-30','4','1'),
('2014-05-29','3','5'),
('2014-06-01','1','4');


-- POVOANDO TABELA EMPRESTIMO

insert into emprestimo(multa,id_usuario,id_exemplar,matricula) values 

(default,3,2,1),
(3.00,2,3,5),
(default,4,1,2),
(10.00,4,5,3);



-- SELECTS
SELECT * FROM TIPO_USUARIO
SELECT * FROM TIPO_PUBLICACAO
SELECT * FROM FUNCIONARIO
SELECT * FROM USUARIO
SELECT * FROM RESERVA
SELECT * FROM PUBLICACAO
SELECT * FROM EMPRESTIMO
SELECT * FROM EXEMPLAR



----------- LISTA DE CONSULTAS --------

--A) Recupere todos os usuários do tipo aluno que começam com a letra ‘A’;

select usuario.* from tipo_usuario natural join usuario 
where nome_completo ilike 'a%' and  descricao ilike 'aluno';

--B) Selecione todos os usuários que fizeram algum empréstimo;

select DISTINCT nome_completo usuarios_fizeram_emprestimo,data_emprestimo from usuario natural join emprestimo;

--C) Selecione o título de todas as publicações que foram emprestadas pelo usuário ‘Luis’;

-- Que o usuario Luis pegou emprestado

select nome_completo Nome_Usuario,titulo from usuario join emprestimo using (id_usuario)  
join exemplar using (id_exemplar) join publicacao using (id_publicacao)
where nome_usuario ilike 'luis';

-- Que o funcionario Luis emprestou 

select nome Funcionario_Emprestou,titulo from funcionario join emprestimo using (matricula) join exemplar using (id_exemplar) join publicacao using (id_publicacao)
where nome ilike 'luis%';

--D) Selecione o nome de todos os usuários que reservaram o livro “PostgreSQL”;

select nome_usuario,data_reserva,titulo from usuario join reserva using(id_usuario) join publicacao using (id_publicacao) 
where titulo ilike 'postgresql'; 
            -- upper todos os caracteres em caixa alta
select nome_usuario, data_reserva, titulo from usuario join reserva using(id_usuario) join publicacao using (id_publicacao)
where upper(titulo)= upper('postgresql');  
            -- lower todos os caracteres em caixa baixa
select nome_usuario, data_reserva, titulo from usuario join reserva using(id_usuario) join publicacao using (id_publicacao)
where lower(titulo)= lower('postgresql');

--E) Selecione os nomes dos usuários que fizeram o empréstimo dos livros “Arte da guerra” e “O meu chefe é um idiota”;

select nome_usuario,titulo,data_emprestimo from usuario join emprestimo using(id_usuario) join exemplar using(id_exemplar) join publicacao using (id_publicacao)
where titulo ilike 'arte da guerra' or titulo ilike 'o meu chefe é um idiota';

select nome_usuario, titulo, data_emprestimo from usuario join emprestimo using(id_usuario) join exemplar using(id_exemplar)
join publicacao using(id_publicacao)
where upper(titulo) = upper('arte da gerra') and upper(titulo)= upper('o meu chefe é um idiota');

select nome_usuario, titulo, data_emprestimo from usuario join emprestimo using(id_usuario) join exemplar using(id_exemplar)
join publicacao using(id_publicacao)
where titulo in('Arte da guerra','O meu chefe é um idiota');

--F) Quais os tipos de publicações foram reservadas pelos usuários do tipo professor;
select nome_completo professores_reservaram,tipo_publicacao.descricao tipo_publicacao from 
tipo_publicacao join publicacao using(id_tipo_publicacao) join reserva using(id_publicacao) 
join usuario using(id_usuario) join tipo_usuario using(id_tipo_usuario)
where tipo_usuario.descricao ilike 'professor';

select nome_completo professores_reservaram,tipo_publicacao.descricao tipo_publicacao from 
tipo_publicacao join publicacao using(id_tipo_publicacao) join reserva using(id_publicacao) 
join usuario using(id_usuario) join tipo_usuario using(id_tipo_usuario)
where upper(tipo_usuario.descricao)= upper('professor');


select distinct tipo_publicacao.descricao publicacoes_reservadas_professor from tipo_publicacao join publicacao using(id_tipo_publicacao) join reserva using(id_publicacao) join usuario using(id_usuario) join tipo_usuario using(id_tipo_usuario)
where tipo_usuario.descricao ilike 'professor'; 

--G) Quais publicações ainda não foram emprestadas?
select  titulo publicacoes_sem_emprestimos from publicacao join exemplar using(id_publicacao) right join emprestimo using(id_exemplar)
where data_emprestimo isnull;

-- e quando tem mais de um exemplar na biblioteca.....
select  titulo publicacoes_sem_emprestimos from publicacao join exemplar using(id_publicacao) right join emprestimo using(id_exemplar) 
where data_emprestimo isnull and not exists(select  titulo publicacoes_sem_emprestimos from publicacao join exemplar using(id_publicacao) right join emprestimo using(id_exemplar))
select  distinct titulo publicacoes_sem_emprestimos from publicacao join exemplar using(id_publicacao) left join emprestimo using(id_exemplar)where titulo!= (select  titulo publicacoes_sem_emprestimos from publicacao join exemplar using(id_publicacao) right join emprestimo using(id_exemplar) )

-- resposta do Jhon,porque parece que o resultado é igual??????

select titulo,data_emprestimo from emprestimo join exemplar using (id_exemplar)right join publicacao using (id_publicacao) where id_emprestimo isnull;
select titulo,data_emprestimo from emprestimo join exemplar using (id_exemplar)right join publicacao using (id_publicacao) where emprestimo.id_exemplar isnull;

-- porque ao inverter sentido das junçoes não se consegue o resultado esperado
select titulo, data_emprestimo from publicacao left join exemplar using(id_publicacao)left join emprestimo using (id_exemplar) where emprestimo.id_exemplar isnull

-- Porque da o mesmo retorno com dois left ??????

select * from publicacao left join exemplar using(id_publicacao) left join emprestimo using(id_exemplar)
where data_emprestimo isnull;

-- H) Quais os títulos e o tipo das publicações que ainda não foram reservadas?
select titulo Titulos_Nao_Reservados,descricao,data_reserva from tipo_publicacao join publicacao using(id_tipo_publicacao) 
left join reserva using (id_publicacao)
where data_reserva isnull;

--Questão extra de update

update tipo_publicacao set descricao='MONOGRAFIA'
where descricao='MANOGRAFIA'

select * from usuario natural join emprestimo


select * from usuario order by 2 asc;
select * from usuario where usuario.nome_completo ilike '%iZa%'


-- Function exemplo:

create or replace function adicionaTipoPublicacao(descricao varchar(30))
returns void
as
$$
begin
insert into tipo_publicacao values(default,descricao);
raise notice 'cadastro efetuado com sucesso!';
end
$$
language 'plpgsql';

select adicionaTipoPublicacao ('revista');

-- Exemplo function com found

CREATE FUNCTION consultaUsuario (id integer) RETURNS varchar AS
$$
DECLARE
registro RECORD;
BEGIN
SELECT * INTO registro FROM usuario WHERE id_usuario = id;
IF not FOUND THEN
RAISE EXCEPTION 'não existe aluno com a matricula %', id;
END IF;
RETURN registro.nome_completo;
END;
$$
LANGUAGE 'plpgsql';

select consultaUsuario (20);    -- chamando a função
