-- View de agendamentos detalhados
CREATE OR REPLACE VIEW vw_agendamentos_detalhados AS
SELECT 
    a.id AS id_agendamento,
    cliente.nome_completo AS cliente,
    barbeiro.nome_completo AS barbeiro,
    s.nome AS servico,
    a.inicio_agendado,
    a.fim_agendado,
    a.status
FROM agendamentos a
JOIN usuarios cliente ON cliente.id = a.cliente_id
JOIN usuarios barbeiro ON barbeiro.id = a.barbeiro_id
JOIN agendamento_servicos ags ON ags.agendamento_id = a.id
JOIN servicos s ON s.id = ags.servico_id;

-- View de pagamentos detalhados
CREATE OR REPLACE VIEW vw_pagamentos_detalhados AS
SELECT 
    p.id AS id_pagamento,
    u.nome_completo AS cliente,
    p.valor,
    p.metodo_pagamento,
    p.status,
    p.data_pagamento
FROM pagamentos p
JOIN agendamentos a ON a.id = p.agendamento_id
JOIN usuarios u ON u.id = a.cliente_id;

-- View de mensagens (histórico de chat)
CREATE OR REPLACE VIEW vw_mensagens_chat AS
SELECT 
    m.id,
    remetente.nome_completo AS remetente,
    destinatario.nome_completo AS destinatario,
    m.conteudo,
    m.enviado_em
FROM mensagens m
JOIN usuarios remetente ON remetente.id = m.remetente_id
JOIN usuarios destinatario ON destinatario.id = m.destinatario_id;
