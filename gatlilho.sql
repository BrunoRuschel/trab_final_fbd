-- Gatilho para a remoção de um árbitro.
-- Garante que nenhuma equipe de arbitragem exista sem arbitro principal.
-- Garante que os jogos continuam existindo, mesmo sem o árbitro principal.

-- Nos dá controle sobre a coesão dos dados e manutenção dos jogos, mesmo sem referência ao árbitro.

-- Projetado para uso no SQLite

DROP TRIGGER IF EXISTS RemocaoArbitro;
CREATE TRIGGER RemocaoArbitro
BEFORE DELETE ON arbitros
FOR EACH ROW
BEGIN
    DELETE FROM equipes_de_abitragem WHERE cod_arb = OLD.cod_arb;
    UPDATE jogos j SET j.cod_arb = NULL WHERE j.cod_arb = OLD.cod_arb;
END; 