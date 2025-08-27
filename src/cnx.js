const pg = require('pg')
const { prototype } = require('pg/lib/type-overrides')

const client = new pg.Client({
    user:'postgres',
    host:'localhost',
    database:'aula_andrea',
    password:'1234',
    port:5432

})
module.exports=client