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


-- Instâncias para a tabela 'pessoas'
INSERT INTO pessoas (cod_pessoa, nomep, rating, pais) VALUES
(1, 'Lionel Messi', 9.9, 'AR'),
(2, 'Cristiano Ronaldo', 9.8, 'PT'),
(3, 'Neymar Jr.', 9.0, 'BR'),
(4, 'Robert Lewandowski', 9.2, 'PL'),
(5, 'Xavi Hernandez', 8.5, 'ES'),
(6, 'Erik ten Hag', 8.2, 'NL'),
(7, 'Christophe Galtier', 8.0, 'FR'),
(8, 'Julian Nagelsmann', 8.1, 'DE'),
(9, 'Gabriel Barbosa', 8.7, 'BR'),
(10, 'Everton Ribeiro', 8.6, 'BR'),
(11, 'Dudu', 8.5, 'BR'),
(12, 'Giorgian De Arrascaeta', 8.8, 'UY'),
(13, 'Felipe Melo', 7.5, 'BR'),
(14, 'Kevin De Bruyne', 9.3, 'BE'),
(15, 'Luka Modrić', 9.4, 'HR'),
(16, 'Mohamed Salah', 9.1, 'EG'),
(17, 'Virgil van Dijk', 9.0, 'NL'),
(18, 'Kylian Mbappé', 9.5, 'FR'),
(19, 'Pep Guardiola', 9.7, 'ES'),
(20, 'Jurgen Klopp', 9.6, 'DE'),
(21, 'Dorival Junior', 7.2, 'BR'),
(22, 'Lionel Scaloni', 7.4, 'AR'),
(23, 'Tite', 7.3, 'BR');

-- Instâncias para a tabela 'tecnicos'
INSERT INTO tecnicos (cod_tec, cod_pessoa) VALUES
(1, 5), -- Xavi Hernandez para o FC Barcelona
(2, 6), -- Erik ten Hag para o Manchester United
(3, 7), -- Christophe Galtier para o PSG
(4, 8), -- Julian Nagelsmann para o Bayern Munich
(5, 13), -- Felipe Melo como técnico do Palmeiras
(7,21), -- Dorival técnico Brasil
(8,22), -- Scaloni técnico Argentina
(9, 19), -- Pep Guardiola para o Manchester City
(10, 20),
(11,21),
(12,22),
(13,23);

-- Instâncias para a tabela 'equipes'
INSERT INTO equipes (cod_equ, nomee, pais, cod_tec) VALUES
(1, 'FC Barcelona', 'ES', 1),
(2, 'Manchester United', 'GB', 2),
(3, 'Paris Saint-Germain', 'FR', 3),
(4, 'Bayern Munich', 'DE', 4),
(5, 'Flamengo', 'BR', 13),
(6, 'Palmeiras', 'BR', 5),
(7, 'Brasil', 'BR', 11),
(8, 'Argentina', 'AR', 12),
(9, 'Manchester City', 'GB', 9),
(10, 'Liverpool', 'GB', 10);

-- Instâncias para a tabela 'clubes'
INSERT INTO clubes (cod_clu, cod_equ) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5), -- Flamengo
(6, 6), -- Palmeiras
(9, 9), -- Manchester City
(10, 10); -- Liverpool

-- Instâncias para a tabela 'selecoes'
INSERT INTO selecoes (cod_sel, cod_equ) VALUES
(1, 7),
(2, 8);

-- Instâncias para a tabela 'estadios'
INSERT INTO estadios (cod_est, cod_clu, nomeest, local) VALUES
(1, 1, 'Camp Nou', 'Barcelona'),
(2, 2, 'Old Trafford', 'Manchester'),
(3, 3, 'Parc des Princes', 'Paris'),
(4, 4, 'Allianz Arena', 'Munich'),
(5, 5, 'Maracanã', 'Rio de Janeiro'),
(6, 6, 'Allianz Parque', 'São Paulo'),
(7, 7, 'Etihad Stadium', 'Manchester'),
(8, 8, 'Anfield', 'Liverpool');

-- Instâncias para a tabela 'jogadores'
INSERT INTO jogadores (cod_jog, cod_pessoa, idade, pos1, pos2, pos3, ini_contrato, fim_contrato, cod_equ) VALUES
(1, 1, 36, 'Atacante', NULL, NULL, '2021-08-01', '2024-06-30', 1),
(2, 2, 39, 'Atacante', NULL, NULL, '2022-08-01', '2024-06-30', 2),
(3, 3, 32, 'Atacante', 'Ponta', NULL, '2021-08-01', '2025-06-30', 3),
(4, 4, 35, 'Atacante', 'Centroavante', NULL, '2021-08-01', '2024-06-30', 4),
(5, 9, 27, 'Atacante', NULL, NULL, '2020-01-01', '2025-12-31', 5),
(6, 10, 33, 'Meio-campo', NULL, NULL, '2017-01-01', '2024-12-31', 5),
(7, 11, 31, 'Atacante', NULL, NULL, '2015-01-01', '2024-12-31', 6),
(8, 12, 30, 'Meio-campo', NULL, NULL, '2019-01-01', '2024-12-31', 5),
(9, 14, 32, 'Meio-campo', NULL, NULL, '2015-07-01', '2025-06-30', 9), -- Kevin De Bruyne no Manchester City
(10, 15, 38, 'Meio-campo', NULL, NULL, '2012-08-01', '2024-06-30', 9), -- Luka Modrić no Manchester City
(11, 16, 32, 'Atacante', NULL, NULL, '2017-06-01', '2025-06-30', 10), -- Mohamed Salah no Liverpool
(12, 17, 32, 'Zagueiro', NULL, NULL, '2018-01-01', '2025-06-30', 10); -- Virgil van Dijk no Liverpool

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
(4, 'German Football Association', 'Bernd Neuendorf', 'DE'),
(5, 'Confederação Brasileira de Futebol', 'Ednaldo Rodrigues', 'BR');

-- Instâncias para a tabela 'arbitros'
INSERT INTO arbitros (cod_arb, nomea, pais, funcao, cod_fed) VALUES
(1, 'Antonio Mateu Lahoz', 'ES', 'Árbitro Principal', 1),
(2, 'Michael Oliver', 'GB', 'Assistente', 2),
(3, 'Clément Turpin', 'FR', 'VAR', 3),
(4, 'Felix Zwayer', 'DE', 'Árbitro Principal', 4),
(5, 'Anderson Daronco', 'BR', 'Árbitro Principal', 5);

-- Instâncias para a tabela 'ligas'
INSERT INTO ligas (cod_liga, nomel, pais, cod_fed) VALUES
(1, 'La Liga', 'ES', 1),
(2, 'Premier League', 'GB', 2),
(3, 'Ligue 1', 'FR', 3),
(4, 'Bundesliga', 'DE', 4),
(5, 'Brasileirão Série A', 'BR', 5),
(6, 'UEFA Champions League', NULL, 2); -- Liga europeia

-- Instâncias para a tabela 'equipes_de_abitragem'
INSERT INTO equipes_de_abitragem (cod_eda, cod_liga, cod_arb) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 1), -- Arbitragem para o Brasileirão Série A
(6, 6, 4); -- Arbitragem para a UEFA Champions League

-- Instâncias para a tabela 'competidores'
INSERT INTO competidores (cod_comp, cod_liga, cod_equ) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5), -- Flamengo no Brasileirão
(6, 5, 6), -- Palmeiras no Brasileirão;
(7, 6, 9), -- Manchester City na UEFA Champions League
(8, 6, 10); -- Liverpool na UEFA Champions League

-- Instâncias para a tabela 'transmissoes'
INSERT INTO transmissoes (cod_tran, nomet, pais) VALUES
(1, 'ESPN', 'ES'),
(2, 'Sky Sports', 'GB'),
(3, 'Canal+', 'FR'),
(4, 'DAZN', 'DE'),
(5, 'Globo', 'BR'), -- Transmissão no Brasil
(6, 'BT Sport', 'GB'); -- Transmissão no Reino Unido

-- Instâncias para a tabela 'jogos'
INSERT INTO jogos (cod_jogo, placar, cod_est, cod_arb, cod_liga) VALUES
(1, '3-1', 1, 1, 1),
(2, '2-2', 2, 2, 2),
(3, '1-0', 3, 3, 3),
(4, '4-1', 4, 4, 4),
(5, '2-1', 5, 1, 5), -- Jogo no Maracanã
(6, '1-1', 6, 5, 5),
(7, '3-2', 7, 4, 6), -- Jogo no Etihad Stadium
(8, '2-1', 8, 4, 6); -- Jogo no Anfield

-- Instâncias para a tabela 'confrontos'
INSERT INTO confrontos (cod_con, odd_casa, odd_emp, odd_vis, equipe1, equipe2, mandante, cod_jogo) VALUES
(1, 1.8, 3.4, 4.0, 1, 2, 1, 1),
(2, 2.2, 3.1, 3.6, 2, 3, 2, 2),
(3, 1.6, 3.5, 3.8, 3, 4, 1, 3),
(4, 2.0, 3.2, 3.9, 4, 1, 2, 4),
(5, 1.9, 3.2, 4.2, 5, 6, 1, 5), -- Flamengo x Palmeiras no Maracanã
(6, 2.1, 3.3, 3.7, 6, 5, 2, 6),
(7, 1.7, 3.5, 4.5, 7, 8, 1, 7), -- Manchester City x Liverpool no Etihad
(8, 1.9, 3.2, 4.0, 8, 7, 1, 8); -- Liverpool x Manchester City no Anfield

-- Instâncias para a tabela 'transmissoes_ao_vivo'
INSERT INTO transmissoes_ao_vivo (cod_tav, cod_tran, cod_jogo) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5), -- Transmissão do jogo no Maracanã
(6, 5, 6), -- Transmissão do jogo no Allianz Parque;
(7, 6, 7), -- Transmissão do jogo no Etihad Stadium
(8, 6, 8); -- Transmissão do jogo no Anfield