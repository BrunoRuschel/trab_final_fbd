-- equipes treinadas por técnicos com rating acima da média
SELECT nomee
from equipes e
WHERE cod_tec IN (
  SELECT cod_tec 
  from tecnicos t JOIN pessoas p ON t.cod_pessoa = p.cod_pessoa
  WHERE rating > (SELECT AVG(rating) FROM pessoas WHERE cod_pessoa IN (SELECT cod_pessoa FROM tecnicos))
 );
  
-- número de jogos realizados em cada estádio, agrupados pela liga dos jogos
SELECT nomeest AS Estádio, nomel AS Liga, COUNT(cod_jogo) AS Total_Jogos
FROM jogos j NATURAL JOIN estadios es NATURAL JOIN ligas l
GROUP BY nomeest, nomel;

-- equipes que jogaram brasileirão série A e 
-- tiveram algum jogo transmitido pelo globo
SELECT nomee
FROM equipes
WHERE cod_equ IN (
    SELECT cod_equ
    FROM competidores NATURAL JOIN ligas NATURAL JOIN jogos NATURAL JOIN transmissoes_ao_vivo NATURAL JOIN transmissoes
    WHERE nomel = 'Brasileirão Série A' AND nomet = 'Globo'
);

-- equipes que possuem pelo menos um jogador com mais de 35 anos
-- e a média de avaliação (rating) doesses jogadores é maior que 9.
SELECT e.nomee AS Equipe, COUNT(j.cod_jog) AS Total_Jogadores, AVG(p.rating) AS Média_Avaliação
FROM equipes e
JOIN jogadores j ON e.cod_equ = j.cod_equ JOIN pessoas p ON j.cod_pessoa = p.cod_pessoa
WHERE j.idade > 35
GROUP BY e.nomee
HAVING AVG(p.rating) > 9.0;

-- lista os canais de transmissão que 
-- não transmitem nenhum jogo do campeonato brasileiro série A
SELECT nomet
FROM transmissoes t
WHERE NOT EXISTS (
    SELECT cod_tav
    FROM transmissoes_ao_vivo tav NATURAL JOIN jogos j NATURAL JOIN ligas l
    WHERE l.nomel = 'Brasileirão Série A'
    AND tav.cod_tran = t.cod_tran
);

-- nome e função dos árbitros que participaram de jogos no maracanã
SELECT nomea AS Arbitro, funcao, nomeest
FROM arbitros NATURAL JOIN jogos NATURAL JOIN estadios
WHERE cod_est IN (
    SELECT cod_est
    FROM estadios
    WHERE nomeest = 'Maracanã'
);

