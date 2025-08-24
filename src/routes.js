const express = require("express")
const path = require("path")
const router = express.Router()

router.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login.html'))
})

router.get('/inicio', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'inicio.html'))
})

module.exports = router
