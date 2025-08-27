-- ============================================
-- BANCO DE DADOS BARBEARIA
-- ============================================

-- Criar tabela de usuários
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome_completo VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(200) NOT NULL,
    telefone VARCHAR(20),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criar tabela de colaboradores (papéis: cliente, barbeiro, admin)
CREATE TABLE colaboradores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Relacionamento usuários x colaboradores (1 usuário pode ser barbeiro e cliente, por exemplo)
CREATE TABLE usuarios_colaboradores (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    colaborador_id INT REFERENCES colaboradores(id) ON DELETE CASCADE
);

-- Criar tabela de serviços
CREATE TABLE servicos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    duracao_minutos INT NOT NULL
);

-- Criar tabela de agendamentos
CREATE TABLE agendamentos (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    barbeiro_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    inicio_agendado TIMESTAMP NOT NULL,
    fim_agendado TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Pendente',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Relacionamento agendamento x serviços (um agendamento pode ter vários serviços)
CREATE TABLE agendamento_servicos (
    id SERIAL PRIMARY KEY,
    agendamento_id INT REFERENCES agendamentos(id) ON DELETE CASCADE,
    servico_id INT REFERENCES servicos(id) ON DELETE CASCADE
);

-- Pagamentos
CREATE TABLE pagamentos (
    id SERIAL PRIMARY KEY,
    agendamento_id INT REFERENCES agendamentos(id) ON DELETE CASCADE,
    valor DECIMAL(10,2) NOT NULL,
    metodo_pagamento VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pendente',
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Mensagens (chat)
CREATE TABLE mensagens (
    id SERIAL PRIMARY KEY,
    remetente_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    destinatario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    conteudo TEXT NOT NULL,
    enviado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- VIEWS ÚTEIS
-- ============================================

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
