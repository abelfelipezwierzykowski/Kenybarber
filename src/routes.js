const express = require("express")

const router = express.Router()

router.get('/', (req, res) => {
  res.send('Hello World!')
})

router.get('/inicio', (req, res) => {
  res.send('esse é o inicio')
})


module.exports = router 

