CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- Tipos Enumerados
CREATE TYPE status_agendamento AS ENUM ('pendente', 'confirmado', 'em_atendimento', 'concluido', 'cancelado', 'nao_compareceu');
CREATE TYPE status_pagamento AS ENUM ('pendente', 'autorizado', 'pago', 'estornado', 'falhou');
CREATE TYPE tipo_conversa AS ENUM ('privada', 'suporte', 'grupo');
CREATE TYPE tipo_mensagem AS ENUM ('texto', 'imagem', 'arquivo', 'sistema');


-- Usuários
CREATE TABLE usuarios (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
nome_completo TEXT NOT NULL,
email TEXT UNIQUE NOT NULL,
telefone TEXT,
senha_hash TEXT NOT NULL,
criado_em TIMESTAMPTZ DEFAULT now()
);


-- Colaboradores (cliente, barbeiro, administrador)
CREATE TABLE colaboradores (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
codigo TEXT UNIQUE NOT NULL
);


CREATE TABLE usuarios_colaboradores (
usuario_id UUID REFERENCES usuarios(id) ON DELETE CASCADE,
colaborador_id UUID REFERENCES colaboradores(id) ON DELETE CASCADE,
PRIMARY KEY (usuario_id, colaborador_id)
);


-- Barbearias
CREATE TABLE barbearias (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
nome_fantasia TEXT NOT NULL,
telefone TEXT,
email TEXT,
criado_em TIMESTAMPTZ DEFAULT now()
);


-- Barbeiros
CREATE TABLE barbeiros (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
usuario_id UUID REFERENCES usuarios(id) ON DELETE CASCADE,
barbearia_id UUID REFERENCES barbearias(id) ON DELETE CASCADE,
nome_exibicao TEXT
);


-- Serviços
CREATE TABLE servicos (
id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
barbearia_id UUID REFERENCES barbearias(id) ON DELETE CASCADE,
nome TEXT NOT NULL,
duracao_minutos INTEGER NOT NULL,
preco_centavos INTEGER NOT NULL
);


-- Serviços por Barbeiro
CREATE TABLE barbeiro_servicos (
barbeiro_id UUID REFERENCES barbeiros(id) ON DELETE CASCADE,
servico_id UUID REFERENCES servicos(id) ON DELETE CASCADE,
PRIMARY KEY (barbeiro_id, servico_id)
);

