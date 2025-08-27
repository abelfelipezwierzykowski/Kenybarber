const express = require("express");
const path = require("path");
const router = express.Router();


const carro = require("./carro.json");

router.get("/", (req, res) => {
  res.send("Hello World!");
});

router.get("/inicio", (req, res) => {
  res.send("esse é o inicio");
});

router.get("/carro", (req, res) => {
  res.json(carro);
});

router.use((req, res) => {
  
    res.status(404).sendFile('./view/404.html', {root:__dirname});
});

module.exports = router;