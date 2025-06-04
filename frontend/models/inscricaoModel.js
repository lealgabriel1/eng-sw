const axios = require('axios');
const API_URL = process.env.API_URL || 'http://localhost:8000';

exports.getMinhasInscricoes = async (user_id = 1) => {
  const res = await axios.get(`${API_URL}/inscricoes?user_id=${user_id}`);
  return res.data;
};
