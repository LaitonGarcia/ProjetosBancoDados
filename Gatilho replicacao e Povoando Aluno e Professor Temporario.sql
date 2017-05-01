-- DROP TRIGGER replicacao_gatilho ON aluno;
-- DROP FUNCTION replicacao_gatilho();

create function replicacao_gatilho() returns trigger as $$
begin
if (TG_OP = 'INSERT') then
insert into insert_replicacao (cpf,tipo_pessoa)values(new.cpf, new.tipo_pessoa);
elsif (TG_OP = 'UPDATE') then
insert into update_replicacao (cpf,tipo_pessoa)values(new.cpf, new.tipo_pessoa);
end if;
return new;
end;
$$ language plpgsql;

create trigger replicacao_gatilho after insert or update on aluno
for each row execute procedure replicacao_gatilho();

create trigger replicacao_gatilho after insert or update on professor
for each row execute procedure replicacao_gatilho();

create trigger replicacao_gatilho after insert or update on professor_temporario
for each row execute procedure replicacao_gatilho();

create trigger replicacao_gatilho after insert or update on servidor
for each row execute procedure replicacao_gatilho();

create trigger replicacao_gatilho after insert or update on terceirizado
for each row execute procedure replicacao_gatilho();

truncate insert_replicacao;
truncate update_replicacao; 
select cpf as CPF_a_Replicar, tipo_pessoa from insert_replicacao;
select cpf as Atualizar_Dados, tipo_pessoa from update_replicacao;

insert into aluno (cpf, nome, nivel_acesso, senha, rg, rg_orgao_emissor, 
	rg_orgao_emissor_uf , rg_data_emissao, data_nascimento, nacionalidade, 
	naturalidade, naturalidade_uf, estado_civil, sexo, grau_escolaridade, 
	titulo_eleitor, titulo_eleitor_secao, titulo_eleitor_zona, titulo_eleitor_uf, 
	titulo_eleitor_data_emissao, certificado_militar_numero, certificado_militar_tipo, 
	certificado_militar_serie, certificado_militar_categoria, certificado_militar_csm, 
	certificado_militar_rm, grupo_sanguineo, fator_rh, filiacao_mae, filiacao_pai, 
	email, telefone_1, telefone_2, endereco, numero, bairro, municipio, uf, cep, tipo_pessoa) 
values
	('33333333333', 'rubens lopes', '1','111','2791136', 'NI', 'PI', '1994-05-26', 
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
	('11111111111', 'joao batista', '1','111','2791136', 'NI', 'PI', '1994-05-26', 
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

select * from professor_temporario;
select * from aluno;
select * from insert_replicacao;
select * from update_replicacao;

insert into aluno (cpf, nome, nivel_acesso, senha, rg, rg_orgao_emissor, 
	rg_orgao_emissor_uf , rg_data_emissao, data_nascimento, nacionalidade, 
	naturalidade, naturalidade_uf, estado_civil, sexo, grau_escolaridade, 
	titulo_eleitor, titulo_eleitor_secao, titulo_eleitor_zona, titulo_eleitor_uf, 
	titulo_eleitor_data_emissao, certificado_militar_numero, certificado_militar_tipo, 
	certificado_militar_serie, certificado_militar_categoria, certificado_militar_csm, 
	certificado_militar_rm, grupo_sanguineo, fator_rh, filiacao_mae, filiacao_pai, 
	email, telefone_1, telefone_2, endereco, numero, bairro, municipio, uf, cep, tipo_pessoa) 
values
	('77777777777', 'eu sou o temporizador', '1','111','2791136', 'NI', 'PI', '1994-05-26', 
	'1989-01-14', 'Brasileiro', 'Floriano', 'PI','Solteiro', 'F', 'Superior Incompleto', 
	'036303011511', '39', '61', 'PI', '2007-03-13', '111111111111', 'abc', '432', 'dc', 
	'55555', 'ddd', 'a+', '22222222', 'PEDRA P DE SOUSA', 'ABRAAO O DE SOUSA', 
	'juliana@hotmail.com', '8935224351', '8994567654', 'MANOEL DE S SANTOS', '50', 
	'EMÍLIO FALCÃO', 'Floriano', 'PI', '64800000', 'aluno');

insert into aluno (cpf, nome, nivel_acesso, senha, rg, rg_orgao_emissor, 
	rg_orgao_emissor_uf , rg_data_emissao, data_nascimento, nacionalidade, 
	naturalidade, naturalidade_uf, estado_civil, sexo, grau_escolaridade, 
	titulo_eleitor, titulo_eleitor_secao, titulo_eleitor_zona, titulo_eleitor_uf, 
	titulo_eleitor_data_emissao, certificado_militar_numero, certificado_militar_tipo, 
	certificado_militar_serie, certificado_militar_categoria, certificado_militar_csm, 
	certificado_militar_rm, grupo_sanguineo, fator_rh, filiacao_mae, filiacao_pai, 
	email, telefone_1, telefone_2, endereco, numero, bairro, municipio, uf, cep, tipo_pessoa) 
values
	('99999999999', 'eu confirmo o temporizador', '1','111','2791136', 'NI', 'PI', '1994-05-26', 
	'1989-01-14', 'Brasileiro', 'Floriano', 'PI','Solteiro', 'F', 'Superior Incompleto', 
	'036303011511', '39', '61', 'PI', '2007-03-13', '111111111111', 'abc', '432', 'dc', 
	'55555', 'ddd', 'a+', '22222222', 'PEDRA P DE SOUSA', 'ABRAAO O DE SOUSA', 
	'juliana@hotmail.com', '8935224351', '8994567654', 'MANOEL DE S SANTOS', '50', 
	'EMÍLIO FALCÃO', 'Floriano', 'PI', '64800000', 'aluno');
/*truncate aluno cascade;
truncate professor_temporario cascade;
truncate update_replicacao;
truncate insert_replicacao;*/




