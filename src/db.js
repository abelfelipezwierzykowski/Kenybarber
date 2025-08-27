const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('trabalho_oficial', 'postgres', '1234', {
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
