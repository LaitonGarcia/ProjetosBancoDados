select * from insert_replicacao;
select * from update_replicacao;
select * from aluno;
select * from professor_temporario;
select * from excecoes_replicacao;



/* truncate aluno cascade;
truncate insert_replicacao; 
truncate professor_temporario cascade;
truncate excecoes_replicacao;
*/

delete from insert_replicacao where cpf = '11111111111';