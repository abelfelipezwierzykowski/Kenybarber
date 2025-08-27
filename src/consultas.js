const db = require('./cnx')

async function listarCursos() {
    await db.connect()
    let resultado = await db.query('select * from cursos')
    console.log(resultado.rows)
}

listarCursos()