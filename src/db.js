const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('nome_do_banco', 'usuario', 'senha', {
  host: 'localhost',
  dialect: 'postgres',
  logging: false
});

async function testConnection() {
  try {
    await sequelize.authenticate();
    console.log('✅ Connected to PostgreSQL!');
  } catch (error) {
    console.error('❌ Connection failed:', error);
  }
}

testConnection();

module.exports = sequelize;
