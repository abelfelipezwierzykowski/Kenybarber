const express = require("express");
const path = require("path");
const router = express.Router();

const carro = require("./carro.json");

// Rota inicial -> exibe login.html (Incoming Change)
router.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "login.html"));
});

// Rota inicio -> exibe inicio.html (Incoming Change)
router.get("/inicio", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "inicio.html"));
});

// Exemplo adicional -> API retorna JSON de carro (seu HEAD)
router.get("/carro", (req, res) => {
  res.json(carro);
});

// Middleware 404 -> serve página personalizada (seu HEAD)
router.use((req, res) => {
  res.status(404).sendFile("./view/404.html", { root: __dirname });
});

module.exports = router;