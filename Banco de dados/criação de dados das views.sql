-- ============================================
-- INSERÇÃO DE DADOS - BANCO DE DADOS BARBEARIA
-- ============================================

-- Limpando as tabelas para evitar duplicatas ao re-executar o script
-- CUIDADO: Isso apaga todos os dados existentes nas tabelas.
TRUNCATE TABLE usuarios, colaboradores, usuarios_colaboradores, servicos, agendamentos, agendamento_servicos, pagamentos, mensagens RESTART IDENTITY CASCADE;

-- 1. Inserir dados na tabela 'colaboradores' (Papéis)
INSERT INTO colaboradores (nome) VALUES
('cliente'),
('barbeiro'),
('admin');

-- 2. Inserir dados na tabela 'servicos'
INSERT INTO servicos (nome, descricao, preco, duracao_minutos) VALUES
('Corte de Cabelo', 'Corte masculino tradicional ou moderno.', 40.00, 30),
('Barba Terapia', 'Modelagem de barba com toalha quente e massagem.', 35.00, 25),
('Corte e Barba', 'Pacote completo com corte de cabelo e barba.', 70.00, 55),
('Pezinho', 'Acabamento do corte, nuca e costeletas.', 15.00, 10),
('Hidratação Capilar', 'Tratamento para fortalecer e dar brilho aos fios.', 50.00, 20);

-- 3. Inserir dados na tabela 'usuarios'
-- Senha de exemplo para todos: 'senha123' (em um sistema real, use hash)
INSERT INTO usuarios (nome_completo, email, senha, telefone) VALUES
-- Clientes (IDs 1 a 5)
('Carlos Silva', 'carlos.silva@email.com', 'senha123', '(42) 99999-0001'),
('João Pereira', 'joao.pereira@email.com', 'senha123', '(42) 99999-0002'),
('Marcos Almeida', 'marcos.almeida@email.com', 'senha123', '(42) 99999-0003'),
('Lucas Souza', 'lucas.souza@email.com', 'senha123', '(42) 99999-0004'),
('Fernando Costa', 'fernando.costa@email.com', 'senha123', '(42) 99999-0005'),
-- Barbeiros (IDs 6 a 8)
('Ricardo Mendes', 'ricardo.mendes@barbearia.com', 'senha123', '(42) 98888-0001'),
('André Santos', 'andre.santos@barbearia.com', 'senha123', '(42) 98888-0002'),
('Bruno Rocha', 'bruno.rocha@barbearia.com', 'senha123', '(42) 98888-0003'),
-- Admin (ID 9)
('Admin Geral', 'admin@barbearia.com', 'senha123', '(42) 97777-0001');

-- 4. Relacionar usuários e colaboradores
-- IDs dos colaboradores: 1=cliente, 2=barbeiro, 3=admin
INSERT INTO usuarios_colaboradores (usuario_id, colaborador_id) VALUES
-- Clientes
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
-- Barbeiros
(6, 2), (7, 2), (8, 2),
-- Barbeiro que também é cliente
(6, 1),
-- Admin
(9, 3);

-- 5. Inserir dados na tabela 'agendamentos'
INSERT INTO agendamentos (cliente_id, barbeiro_id, inicio_agendado, fim_agendado, status) VALUES
(1, 6, '2025-08-20 09:00:00', '2025-08-20 09:30:00', 'Concluído'),
(2, 7, '2025-08-20 10:00:00', '2025-08-20 10:55:00', 'Concluído'),
(3, 8, '2025-08-21 14:00:00', '2025-08-21 14:25:00', 'Confirmado'),
(4, 6, '2025-08-21 15:00:00', NULL, 'Pendente'),
(5, 7, '2025-08-22 11:00:00', '2025-08-22 11:30:00', 'Cancelado');

-- 6. Relacionar agendamentos e serviços
-- IDs dos serviços: 1=Corte, 2=Barba, 3=Corte e Barba, 4=Pezinho, 5=Hidratação
INSERT INTO agendamento_servicos (agendamento_id, servico_id) VALUES
(1, 1), -- Agendamento 1: Apenas Corte
(2, 3), -- Agendamento 2: Corte e Barba
(3, 2), -- Agendamento 3: Barba Terapia
(4, 1), -- Agendamento 4: Corte de Cabelo
(4, 5), -- Agendamento 4: ... e Hidratação
(5, 1); -- Agendamento 5: Corte (que foi cancelado)

-- 7. Inserir dados na tabela 'pagamentos'
INSERT INTO pagamentos (agendamento_id, valor, metodo_pagamento, status) VALUES
-- Pagamento para o agendamento 1 (Corte)
(1, 40.00, 'Cartão de Débito', 'Pago'),
-- Pagamento para o agendamento 2 (Corte e Barba)
(2, 70.00, 'PIX', 'Pago'),
-- Pagamento para o agendamento 3 (Barba) - ainda não pago
(3, 35.00, 'Dinheiro', 'Pendente');
-- Agendamento 4 está pendente, sem pagamento
-- Agendamento 5 foi cancelado, sem pagamento

-- 8. Inserir dados na tabela 'mensagens' (chat)
INSERT INTO mensagens (remetente_id, destinatario_id, conteudo) VALUES
-- Cliente 1 conversa com Barbeiro 6
(1, 6, 'Olá Ricardo, tudo bem? Confirmando meu horário amanhã às 9h.'),
(6, 1, 'Olá Carlos! Tudo certo. Confirmado! Até amanhã.'),
-- Cliente 4 conversa com Barbeiro 6
(4, 6, 'Boa tarde, gostaria de saber se além do corte posso fazer hidratação.'),
(6, 4, 'Boa tarde, Lucas! Com certeza, podemos fazer sim. Já ajustei aqui.'),
-- Cliente 2 envia mensagem para Barbeiro 7
(2, 7, 'Obrigado pelo atendimento, ficou excelente!');


-- Verificação final (opcional)
-- Após executar o script, você pode consultar as views para ver o resultado
SELECT * FROM vw_agendamentos_detalhados;
SELECT * FROM vw_pagamentos_detalhados;
SELECT * FROM vw_mensagens_chat;