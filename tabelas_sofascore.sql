create table pessoas 
(cod_pessoa int not null primary key,
nomep varchar(50) not null,
rating float not null check(rating>=0 and rating<=10),
pais char(2) not null);

create table tecnicos
(cod_tec int not null primary key,
cod_pessoa int not null,
foreign key (cod_pessoa) references pessoas);

create table equipes
(cod_equ int not null primary key,
nomee varchar(50) not null,
pais char(2) not null,
cod_tec int not null,
foreign key (cod_tec) references tecnicos);

create table clubes 
(cod_clu int not null primary key,
cod_equ int not null,
foreign key (cod_equ) references equipes);

create table selecoes
(cod_sel int not null primary key,
cod_equ int not null,
foreign key (cod_equ) references equipes);

create table estadios
(cod_est int not null primary key,
cod_clu int not null,
nomeest varchar(50) not null,
local varchar(50) not null,
foreign key (cod_clu) references clubes,
unique(nomeest, local));

create table jogadores
(cod_jog int not null primary key,
cod_pessoa int not null,
idade int not null check(idade>=0),
pos1 varchar(50) not null,
pos2 varchar(50),
pos3 varchar(50),
ini_contrato date not null,
fim_contrato date not null,
cod_equ int,
foreign key (cod_pessoa) references pessoas,
foreign key (cod_equ) references equipes);

create table usuarios
(cpf int not null primary key,
nomeu varchar(50) not null,
email varchar(50) not null,
cod_equ int,
foreign key (cod_equ) references equipes);

create table avaliacoes
(cod_av int not null primary key,
cpf int not null,
cod_pessoa int not null,
foreign key (cpf) references usuarios,
foreign key (cod_pessoa) references pessoas);

create table federacoes
(cod_fed int not null primary key,
nomef varchar(50) not null,
presidente varchar(50) not null,
pais char(2) not null,
unique(nomef));

create table arbitros
(cod_arb int not null primary key,
nomea varchar(50) not null,
pais char(2) not null,
funcao varchar(50) not null,
cod_fed int not null,
foreign key (cod_fed) references federacoes);

create table ligas
(cod_liga int not null primary key,
nomel varchar(50),
pais char(2),
cod_fed int not null,
foreign key (cod_fed) references federacoes,
unique(nomel));

create table equipes_de_abitragem
(cod_eda int not null primary key,
cod_liga int not null,
cod_arb int not null,
foreign key (cod_liga) references ligas,
foreign key (cod_arb) references arbitros);

create table competidores
(cod_comp int not null primary key,
cod_liga int not null,
cod_equ int not null,
foreign key (cod_liga) references ligas,
foreign key (cod_equ) references equipes);

create table transmissoes
(cod_tran int not null primary key,
nomet varchar(50) not null,
pais char(2) not null,
unique(nomet,pais));

create table jogos
(cod_jogo int not null primary key,
placar varchar(7) not null,
cod_est int not null,
cod_arb int,
cod_liga int not null,
foreign key (cod_est) references estadios,
foreign key (cod_arb) references arbitros,
foreign key (cod_liga) references ligas);

create table confrontos
(cod_con int not null primary key,
odd_casa float not null check(odd_casa>=1),
odd_emp float not null check(odd_emp>=1),
odd_vis float not null check(odd_vis>=1),
equipe1 int not null,
equipe2 int not null,
mandante int not null check(mandante=1 or mandante=2),
cod_jogo int not null,
foreign key (equipe1) references equipes,
foreign key (equipe2) references equipes,
foreign key (cod_jogo) references jogos);

create table transmissoes_ao_vivo
(cod_tav int not null primary key,
cod_tran int not null,
cod_jogo int not null,
foreign key (cod_tran) references transmissoes,
foreign key (cod_jogo) references jogos);
