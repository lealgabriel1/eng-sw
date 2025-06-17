const axios = require('axios');
const API_URL = process.env.API_URL || 'http://localhost:8000';

exports.getFeed = async (search = '') => {
  let url = `${API_URL}/oportunidades`;
  if (search) {
    url += `?search=${encodeURIComponent(search)}`;
  }
  const res = await axios.get(url);
  return res.data;
};

// pegar oportunidade pelo id
exports.getById = async (id) => {
  const res = await axios.get(`${API_URL}/oportunidades/${id}`);
  return res.data;
};

// incricao na vaga
exports.inscrever = async (user_id, opp_id, mensagem) => {
  const payload = { user_id, opp_id, mensagem };
  const res = await axios.post(`${API_URL}/inscricoes`, payload);
  return res.data;
};