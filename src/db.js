const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('kennybarber', 'postgres', '9375', {
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
