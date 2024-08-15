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
cod_arb int not null,
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


-- Instâncias para a tabela 'pessoas'
INSERT INTO pessoas (cod_pessoa, nomep, rating, pais) VALUES
(1, 'Lionel Messi', 9.9, 'AR'),
(2, 'Cristiano Ronaldo', 9.8, 'PT'),
(3, 'Neymar Jr.', 9.0, 'BR'),
(4, 'Robert Lewandowski', 9.2, 'PL'),
(5, 'Xavi Hernandez', 8.5, 'ES'),
(6, 'Erik ten Hag', 8.2, 'NL'),
(7, 'Christophe Galtier', 8.0, 'FR'),
(8, 'Julian Nagelsmann', 8.1, 'DE');

-- Instâncias para a tabela 'tecnicos'
INSERT INTO tecnicos (cod_tec, cod_pessoa) VALUES
(1, 5), -- Xavi Hernandez para o FC Barcelona
(2, 6), -- Erik ten Hag para o Manchester United
(3, 7), -- Christophe Galtier para o PSG
(4, 8); -- Julian Nagelsmann para o Bayern Munich

-- Instâncias para a tabela 'equipes'
INSERT INTO equipes (cod_equ, nomee, pais, cod_tec) VALUES
(1, 'FC Barcelona', 'ES', 1),
(2, 'Manchester United', 'GB', 2),
(3, 'Paris Saint-Germain', 'FR', 3),
(4, 'Bayern Munich', 'DE', 4);

-- Instâncias para a tabela 'clubes'
INSERT INTO clubes (cod_clu, cod_equ) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Instâncias para a tabela 'selecoes'
-- Assumindo que as seleções não são diretamente relacionadas aos clubes neste exemplo
INSERT INTO selecoes (cod_sel, cod_equ) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Instâncias para a tabela 'estadios'
-- Utilizando estádios reais dos clubes
INSERT INTO estadios (cod_est, cod_clu, nomeest, local) VALUES
(1, 1, 'Camp Nou', 'Barcelona'),
(2, 2, 'Old Trafford', 'Manchester'),
(3, 3, 'Parc des Princes', 'Paris'),
(4, 4, 'Allianz Arena', 'Munich');

-- Instâncias para a tabela 'jogadores'
INSERT INTO jogadores (cod_jog, cod_pessoa, idade, pos1, pos2, pos3, ini_contrato, fim_contrato, cod_equ) VALUES
(1, 1, 36, 'Atacante', NULL, NULL, '2021-08-01', '2024-06-30', 1),
(2, 2, 39, 'Atacante', NULL, NULL, '2022-08-01', '2024-06-30', 2),
(3, 3, 32, 'Atacante', 'Ponta', NULL, '2021-08-01', '2025-06-30', 3),
(4, 4, 35, 'Atacante', 'Centroavante', NULL, '2021-08-01', '2024-06-30', 4);

-- Instâncias para a tabela 'usuarios'
INSERT INTO usuarios (cpf, nomeu, email, cod_equ) VALUES
(12345678901, 'Ana Costa', 'ana.costa@example.com', 1),
(23456789012, 'John Smith', 'john.smith@example.com', 2),
(34567890123, 'Marie Dubois', 'marie.dubois@example.com', 3),
(45678901234, 'Hans Müller', 'hans.muller@example.com', 4);

-- Instâncias para a tabela 'avaliacoes'
INSERT INTO avaliacoes (cod_av, cpf, cod_pessoa) VALUES
(1, 12345678901, 1),
(2, 23456789012, 2),
(3, 34567890123, 3),
(4, 45678901234, 4);

-- Instâncias para a tabela 'federacoes'
INSERT INTO federacoes (cod_fed, nomef, presidente, pais) VALUES
(1, 'Real Federación Española de Fútbol', 'Luis Rubiales', 'ES'),
(2, 'Football Association', 'Mark Bullingham', 'GB'),
(3, 'Ligue de Football Professionnel', 'Vincent Labrune', 'FR'),
(4, 'German Football Association', 'Bernd Neuendorf', 'DE');

-- Instâncias para a tabela 'arbitros'
INSERT INTO arbitros (cod_arb, nomea, pais, funcao, cod_fed) VALUES
(1, 'Antonio Mateu Lahoz', 'ES', 'Árbitro Principal', 1),
(2, 'Michael Oliver', 'GB', 'Árbitro Principal', 2),
(3, 'Clément Turpin', 'FR', 'Árbitro Principal', 3),
(4, 'Felix Zwayer', 'DE', 'Árbitro Principal', 4);

-- Instâncias para a tabela 'ligas'
INSERT INTO ligas (cod_liga, nomel, pais, cod_fed) VALUES
(1, 'La Liga', 'ES', 1),
(2, 'Premier League', 'GB', 2),
(3, 'Ligue 1', 'FR', 3),
(4, 'Bundesliga', 'DE', 4);

-- Instâncias para a tabela 'equipes_de_abitragem'
INSERT INTO equipes_de_abitragem (cod_eda, cod_liga, cod_arb) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4);

-- Instâncias para a tabela 'competidores'
INSERT INTO competidores (cod_comp, cod_liga, cod_equ) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4);

-- Instâncias para a tabela 'transmissoes'
INSERT INTO transmissoes (cod_tran, nomet, pais) VALUES
(1, 'ESPN', 'ES'),
(2, 'Sky Sports', 'GB'),
(3, 'Canal+', 'FR'),
(4, 'DAZN', 'DE');

-- Instâncias para a tabela 'jogos'
INSERT INTO jogos (cod_jogo, placar, cod_est, cod_arb, cod_liga) VALUES
(1, '3-1', 1, 1, 1),
(2, '2-2', 2, 2, 2),
(3, '1-0', 3, 3, 3),
(4, '4-1', 4, 4, 4);

-- Instâncias para a tabela 'confrontos'
INSERT INTO confrontos (cod_con, odd_casa, odd_emp, odd_vis, equipe1, equipe2, mandante, cod_jogo) VALUES
(1, 1.8, 3.4, 4.0, 1, 2, 1, 1),
(2, 2.2, 3.1, 3.6, 2, 3, 2, 2),
(3, 1.6, 3.5, 3.8, 3, 4, 1, 3),
(4, 2.0, 3.2, 3.9, 4, 1, 2, 4);

-- Instâncias para a tabela 'transmissoes_ao_vivo'
INSERT INTO transmissoes_ao_vivo (cod_tav, cod_tran, cod_jogo) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4);







