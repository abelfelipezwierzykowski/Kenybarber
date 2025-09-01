const express = require("express");
const router = express.Router();
const db = require("../db");

// CREATE
router.post("/usuarios", (req, res) => {
  const { nome, email } = req.body;
  db.query(
    "INSERT INTO usuarios (nome, email) VALUES (?, ?)",
    [nome, email],
    (err, result) => {
      if (err) return res.status(500).json({ erro: err });
      res.status(201).json({ id: result.insertId, nome, email });
    }
  );
});

// READ (todos)
router.get("/usuarios", (req, res) => {
  db.query("SELECT * FROM usuarios", (err, results) => {
    if (err) return res.status(500).json({ erro: err });
    res.json(results);
  });
});

// READ (um usuário)
router.get("/usuarios/:id", (req, res) => {
  const { id } = req.params;
  db.query("SELECT * FROM usuarios WHERE id = ?", [id], (err, result) => {
    if (err) return res.status(500).json({ erro: err });
    if (result.length === 0) return res.status(404).json({ mensagem: "Usuário não encontrado" });
    res.json(result[0]);
  });
});

// UPDATE
router.put("/usuarios/:id", (req, res) => {
  const { id } = req.params;
  const { nome, email } = req.body;
  db.query(
    "UPDATE usuarios SET nome = ?, email = ? WHERE id = ?",
    [nome, email, id],
    (err, result) => {
      if (err) return res.status(500).json({ erro: err });
      res.json({ mensagem: "Usuário atualizado com sucesso" });
    }
  );
});

// DELETE
router.delete("/usuarios/:id", (req, res) => {
  const { id } = req.params;
  db.query("DELETE FROM usuarios WHERE id = ?", [id], (err, result) => {
    if (err) return res.status(500).json({ erro: err });
    res.json({ mensagem: "Usuário deletado com sucesso" });
  });
});

module.exports = router;