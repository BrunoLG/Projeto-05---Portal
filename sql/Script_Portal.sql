create table tb_permissao (
    cd_permissao BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_permissao varchar(20)
);

insert into tb_permissao values 
    (default,'admin'),
    (default,'professor'),
    (default,'aluno');

create table tb_curso (
    cd_curso BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_curso varchar(60)
);

insert into tb_curso values 
    (default, 'Análise e Desenvolvimento de Sistemas'),
    (default, 'Comércio Exterior'),
    (default, 'Processos Químicos');

create table tb_usuario (
    cd_usuario BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_usuario varchar(100),
    nm_login varchar(30),
    cd_senha BIGINT,
    cd_curso BIGINT,
    cd_permissao BIGINT,

    constraint fk_usuario_curso foreign key (cd_curso) references tb_curso (cd_curso),
    constraint fk_usuario_permissao foreign key (cd_permissao) references tb_permissao (cd_permissao)
);

insert into tb_usuario values 
    (default, 'Administrador Supremo', 'admin', 1509442, null, 1),
    (default, 'Fernando Bacic', 'professor', 1509442, 1, 2),
    (default, 'Ricardo Pupo', 'pupo', 1509442, 2, 2),
    (default, 'Paolla Gil', 'paolla', 1509442, 1, 3),
    (default, 'Milena ALves', 'milena', 1509442, 2, 3),
    (default, 'Fernando Costa', 'fernando', 1509442, 3, 3);

create table tb_disciplina (
    cd_disciplina BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_disciplina varchar(100),
    cd_curso BIGINT,
    
    constraint fk_disciplina_curso foreign key (cd_curso) references tb_curso (cd_curso)
);

insert into tb_disciplina values 
    (default, 'Matemática Discreta', 1),
    (default, 'Arquitetura de Computadores', 1),
    (default, 'Economia e Finanças', 2),
    (default, 'Química', 3),
    (default, 'Física', 3);

create table tb_aula (
    cd_aula BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_aula varchar(100),
    ds_conteudo varchar(10000),
    cd_disciplina BIGINT,

    constraint fk_aula_disciplina foreign key (cd_disciplina) references tb_disciplina (cd_disciplina)
);

insert into tb_aula values 
    (default, 'Distribuição Eletrônica', 'Nesta aula....', 3),
    (default, 'Números Binários', 'Nesta aula....', 2),
    (default, 'Conjuntos Númericos', 'Nesta aula....', 1);

create table tb_teste (
    cd_teste BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_teste varchar(100),
    cd_disciplina BIGINT,
    
    constraint fk_teste_disciplina foreign key (cd_disciplina) references tb_disciplina (cd_disciplina)
);

insert into tb_teste values 
    (default, 'Teste Final - Matemática Discreta', 1),
    (default, 'Teste Final - Arquitetura de Computadores', 2),
    (default, 'Teste Final - Economia e Finanças', 3);

create table tb_questao (
    cd_questao BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    ds_questao varchar(1000),
    nm_resposta varchar(30),
    cd_teste BIGINT,

    constraint fk_questao_teste foreign key (cd_teste) references tb_teste (cd_teste)
);

insert into tb_questao values 
    (default, 'Questão 1', 'Inteiros', 1),
    (default, 'Questão 2', 'Tende ao infinito', 1),
    (default, 'Questão 1', '1010', 2),
    (default, 'Questão 2', '1111', 2),
    (default, 'Questão 1', 'Estados Unidos', 3),
    (default, 'Questão 2', 'Amortização Constante', 3);

create table tb_alternativa (
    cd_alternativa BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    nm_alternativa varchar(30),
    cd_questao BIGINT,

    constraint fk_alternativa_questao foreign key (cd_questao) references tb_questao (cd_questao)
);

insert into tb_alternativa values 
    (default, 'Inteiros', 1),
    (default, 'Tende ao infinito', 2),
    (default, 'Tende ao negativo', 2),
    (default, '1111', 4),
    (default, '1011', 4),
    (default, 'Amortização Constante', 6),
    (default, 'Amortização Simples', 6);

create table tb_historico_teste (
    cd_historico BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    cd_nota double,
    dt_teste date,
    cd_teste BIGINT,
    cd_usuario BIGINT,

    constraint fk_historico_teste_teste foreign key (cd_teste) references tb_teste (cd_teste),
    constraint fk_historico_teste_usuario foreign key (cd_usuario) references tb_usuario (cd_usuario)
);

insert into tb_historico_teste values 
    (default, 6.4, '2018-12-01', 3, 4),
    (default, 9.0, '2018-11-28', 1, 4),
    (default, 2.8, '2018-11-25', 2, 5);

create table tb_historico_aula (
    cd_historico BIGINT not null primary key
        generated ALWAYS as identity
        (start with 1, INCREMENT by 1),
    cd_aula BIGINT,
    cd_usuario BIGINT,

    constraint fk_historico_aula_aula foreign key (cd_aula) references tb_aula (cd_aula),
    constraint fk_historico_aula_usuario foreign key (cd_usuario) references tb_usuario (cd_usuario)
);

insert into tb_historico_aula values 
    (default, 1, 4),
    (default, 1, 5),
    (default, 3, 5);

