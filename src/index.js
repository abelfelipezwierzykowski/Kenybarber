const express = require('express')
const path = require('path')
const app = express()
const port = 3000
const router = require('./routes')

app.use(express.static(path.join(__dirname, 'public')))
app.use(router)

app.listen(port, () => {
  console.log(`Servidor rodando em http://localhost:${port}`)
})
