const express = require("express");
const path = require("path");
const router = express.Router();

const carro = require("./carro.json");

// Rota inicial -> exibe login.html 
router.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "login.html"));
});

// Rota inicio -> exibe inicio.html 
router.get("/inicio", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "inicio.html"));
});

router.use((req, res) => {
  res.status(404).sendFile(path.join(__dirname, "public", "404.html"));
});


const { sequelize } = require('./models'); // ajuste o caminho se necessário

// Nova rota para pegar os dados da view
router.get('/api/view-dados', async (req, res) => {
  try {
    const [resultados] = await sequelize.query('SELECT * FROM nome_da_sua_view');
    res.json(resultados);
  } catch (erro) {
    console.error(erro);
    res.status(500).json({ erro: 'Não foi possível buscar os dados da view.' });
  }
});

module.exports = router;