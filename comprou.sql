
--         criando as tabelas

create table fabricantes(
id_fabricante serial,
nome varchar (40),
data_cadastro date,
data_alteracao date
);
alter table fabricantes alter column id_fabricante set not null,
	                alter column nome set not null,
	                alter column data_cadastro set not null,
	                add constraint id_fabricante_pk primary key (id_fabricante);


create table status(
id_status serial,
descricao varchar(80)
);
alter table status alter column id_status set not null,
                   alter column descricao set not null,
                   add constraint id_status_pk primary key (id_status);

create table clientes(
id_cliente serial,
nome varchar(80),
email varchar(80),
senha varchar(8),
telefone numeric(12,0),
endereco varchar(60),
data_cadastro date,
data_alteracao date
);
alter table clientes alter column id_cliente set not null,
		    alter column nome set not null,
		    alter column email set not null,
		    alter column senha set not null,
		    alter column telefone set not null,
		    alter column endereco set not null,
		    alter column data_cadastro set not null,
		    add constraint id_cliente_pk primary key (id_cliente);

create table categorias(
id_categoria serial,
nome varchar(40),
data_cadastro date,
data_alteracao date
);
alter table categorias alter column id_categoria set not null,
		       alter column nome set not null,
		       alter data_cadastro set not null,
		       add id_sub_categoria integer,
		       --alter column id_sub_categoria set not null,
		       alter column id_sub_categoria set default null,
		       add constraint id_categoria_pk primary key (id_categoria),
		       add constraint id_sub_categoria_fk foreign key (id_sub_categoria)
		       references categorias(id_categoria);

create table compras(
id_compra serial,
id_cliente integer,
id_status integer,
codigo varchar(20),
total numeric(8,2),
data_cadastro date,
data_alteracao date
);
alter table compras alter column id_compra set not null,
		    alter column id_cliente set not null,
		    alter column id_status set not null,
		    alter column codigo set not null,
		    alter column total set not null,
		    alter column data_cadastro set not null,
		    add constraint id_compra_pk primary key (id_compra),
		    add constraint id_cliente_fk foreign key(id_cliente) references clientes(id_cliente),
		    add constraint id_status_fk foreign key(id_status) references status(id_status); 

create table produtos(
id_produto serial,
id_categoria integer,
id_fabricante integer,
nome varchar(80),
valor numeric(8,2),
descricao text,
estoque integer,
data_cadastro date,
data_alteracao date
);
alter table produtos alter column id_produto set not null,
		     alter column id_categoria set not null,
		     alter column id_fabricante set not null,
		     alter column nome set not null,
		     alter column valor set not null,
		     alter column descricao set not null,
		     alter column estoque set not null,
		     alter column data_cadastro set not null,
		     add constraint id_produto_pk primary key (id_produto),
		     add constraint id_categoria_fk foreign key (id_categoria) references categorias(id_categoria),
		     add constraint id_fornecedor_fk foreign key (id_fabricante) references fabricantes(id_fabricante);

create table compras_produtos(
id_produto integer,
id_compra integer,
quantidade integer,
valor_unitario numeric(8,2)
);
alter table compras_produtos alter column id_produto set not null,
		             alter column id_compra set not null,
		             alter column quantidade set not null,
		             alter column valor_unitario set not null,
		             add constraint compras_produto_pk primary key (id_produto,id_compra),
		             add foreign key (id_produto) references produtos (id_produto),
		             add foreign key (id_compra) references compras (id_compra);

create table especificacoes(
id_especificacoes serial,
nome varchar(50),
descricao text,
id_produto integer
);
alter table especificacoes alter column id_especificacoes set not null,
			   alter column nome set not null,
			   alter column id_produto set not null,
			   add constraint id_especificacoes_pk primary key (id_especificacoes),
			   add constraint id_produto_fk foreign key (id_produto) references produtos(id_produto);

select * from fabricantes order by id_fabricante asc;	
select * from status;
select * from clientes order by id_cliente asc;
select * from categorias order by id_categoria asc;
select * from compras;
select * from produtos order by id_produto asc;
select * from compras_produtos;
select * from especificacoes;
 


--         povoando as tabelas

insert into clientes(nome,email,senha,telefone,endereco,data_cadastro)
values
('Rangel da Silva','rangelsilva@','silva',8911112222,'Rua Prof Rangel, 111, centro','2000-06-15'),
('Ana Maria','mariaana@','maria',8922223333,'Rua Ana Maria, 222, manguinha','2005-02-10'),
('Laiton Garcia','laitongarcia@','garcia',8933334444,'Rua Desem everton, 333, manguinha','2013-06-20'),
('Ana Patrica','anapatricia@','patricia',8944445555,'Rua Aluna Ana, 444, centro','2014-10-01'),
('Joao Batista','batistajoao@','batista',8955556666,'Rua Prof Batista, 555, Alvorada','2008-12-30');
update clientes set data_alteracao = '2010-09-09' where id_cliente = 1;

insert into status(descricao)values ('aguardando pagamento'),
('pago'),('enviado'),('analise de credito');

insert into fabricantes(nome,data_cadastro)values
('Sony','2000-01-01'),('Samsung','2002-06-15'),('Brastemp','2001-07-30'),
('Hering','2008-09-29'),('Cristal','2005-06-06'),('HP','2003-03-03');
update fabricantes set data_alteracao = '2007-05-05' where nome = 'Sony';
update fabricantes set data_alteracao = '2011-02-02' where id_fabricante = '3';

insert into categorias(nome,data_cadastro) values
 ('eletrodomésticos','2000-05-03'),('informática','2003-06-30'),
 ('alimentos','2004-08-09'),('confeccoes','2008-09-29'),
 ('eletroportateis','2010-04-09');

 --select * from categorias
 
insert into categorias(nome,data_cadastro,id_sub_categoria) values
 ('fogao','2000-05-03',1),('refrigerador','2003-06-30',1),
 ('notebook','2004-08-09',2),('camiseta','2008-09-29',4),
 ('cuidado pessoal','2010-04-09',5),('cameras','2005-09-15',2),('tablets','2011-09-07',2);
update categorias set data_alteracao = '2012-09-09' where nome = 'alimentos';
--select * from produtos
insert into produtos(id_categoria,id_fabricante,nome,valor,descricao,estoque,data_cadastro)
values
(7,3,'Refrigerador ff 480l',3500,'frost free 220v',5,'2001-05-02'),
(6,3,'Fogão Facilite',1000,'4 bocas inox',10,'2005-05-09'),
(8,6,'Notebook HP200',3200,'HD750 pl video dedicada 1Gb',4,'2013-03-30'),
(11,1,'Camera ws3500',1800,'semi prof 30MP zoom 16X',30,'2010-09-05'),
(2,2,'Pendrive 16Gb',110,'Classe 10 azul',50,'2012-06-03'),
(3,5,'Arroz Cristal',14,'Agulhinha tipo a classe 1',200,'2014-05-04'),
(9,4,'camiseta polo',45,'gola polo M verde',80,'2013-06-02'),
(10,3,'Secador BR2000',145,'2000wats 220volts',100,'2013-06-05'),
(12,6,'Tablet hp1.4',1230,'10P Wi-Fi 16Gb',30,'2011-10-01');
update produtos set data_alteracao = '2014-06-05' where id_produto = 7;


insert into compras(id_cliente,id_status,codigo,total,data_cadastro)
values
(1,1,'xxx111',5300,'2013-05-04'),
(3,3,'xxx222',1110,'2013-06-02'),
(5,2,'xxx333',1800,'2014-04-30'),
(4,4,'xxx444',3200,'2014-06-05'),
(1,2,'xxx555',1000,'2014-05-01'),
(3,3,'xxx666',1350,'2012-01-25');

insert into compras_produtos(id_produto,id_compra,quantidade,valor_unitario)
values
(4,1,1,1800),(1,1,1,3500),(2,2,1,1000),
(5,2,1,110),(4,3,1,1800),(3,4,1,3200),(2,5,1,1000),(9,6,1,1230);

insert into especificacoes (nome,descricao,id_produto)values
('Refrigerador ff 480l','2 portas, consumo 56w/h selo procel A',1),
('Fogao Facilite','4 bocas, auto acendimento, mesa inox',2),
('Notebook HP200','hd750, 6Gb ram, placa video dedicada 1Gb, 15P',3),
('Camera ws3500','semiprofissional, 30MP, zoom optico 16x',4),
('Pendrive Sony','16Gb Classe 10 azul',5),
('Arroz Cristal','branco, tipo 1, Agulhinha, 5Kg',6),
('camiseta polo','manga curta, M, verde, microfibra',7),
('Secador br2000','portatil, 2000wats, 220volts, cabo giratorio',8),
('Tablet HP1.4','Tela 10 polegadas, processador 1.4Ghz, 16Gb Black',9);

--I - Quais os nomes dos produtos comprados pelo cliente Rangel no dia 04/05/2013
select produtos.nome Compras_Rangel from produtos join compras_produtos using(id_produto)
 join compras using(id_compra) join clientes using(id_cliente) where clientes.nome ilike 'rangel%' and compras.data_cadastro = '04-05-2013'

--II - Quais os nomes dos fabricantes que fabricaram os produtos comprados no dia 02/06/2013
select fabricantes.nome Nome_Fabricante from fabricantes join produtos using(id_fabricante)
 join compras_produtos using(id_produto) join compras using(id_compra)
 where compras.data_cadastro = '02-06-2013'

 --III - Quais os status das compras que possuem produtos da Sony
 select status.descricao from status join compras using(id_status)
 join compras_produtos using(id_compra) join produtos using(id_produto)
 join fabricantes using(id_fabricante) where upper(fabricantes.nome) = upper('sony')

--IV - Quais as especificacoes dos produtos comprados pela 'Ana'
select especificacoes.nome,especificacoes.descricao from
 especificacoes join produtos using(id_produto)
 join compras_produtos using(id_produto)
 join compras using(id_compra) join clientes using
(id_cliente) where clientes.nome ilike 'Ana%';

select categorias.nome,categorias.id_categoria,produtos.nome from produtos join categorias using(id_categoria)
-- V - Quais clientes compraram eletrodomésticos
select clientes.nome, produtos.nome Comprou from categorias join produtos using(id_categoria) 
join compras_produtos using(id_produto)join compras using(id_compra)
join clientes using(id_cliente)
where  id_categoria in  
(select id_categoria from categorias c where c.id_sub_categoria in 
(select id_categoria from categorias where categorias.nome = 'eletrodomésticos'));


-- VI - Quais categorias de produtos ainda estão com status da compra 'aguardando pagamento'
select categorias.nome from categorias join produtos using(id_categoria) 
join compras_produtos using(id_produto)join compras using(id_compra)
join status using(id_status)
where status.descricao = 'aguardando pagamento';
-- TIRA TEIMA select compras.id_compra,produtos.nome,status.descricao from status join compras using(id_status) join compras_produtos using(id_compra)join produtos using(id_produto);

-- VII - Quais os nomes e emails dos clientes que compraram notebooks da HP?
select clientes.nome Cliente,clientes.email E_mail, produtos.nome Comprou,fabricantes.nome from 
clientes join compras using(id_cliente)join compras_produtos using(id_compra)
join produtos using(id_produto)join fabricantes using(id_fabricante)
where upper(fabricantes.nome)= upper('hp') and 
produtos.id_produto in ( select produtos.id_produto from categorias join produtos using(id_categoria) where categorias.nome ilike 'notebook')

select *from clientes join compras using (id_cliente)