const axios = require('axios');
const API_URL = process.env.API_URL || 'http://localhost:8000';

exports.getPerfil = async (user_id = 1) => {
  // backend espera user_id como query param (mock: 1)
  const res = await axios.get(`${API_URL}/perfil?user_id=${user_id}`);
  return res.data;
};

exports.atualizarPerfil = async (user_id, payload) => {
  // PATCH /perfil?user_id=
  const API_URL = process.env.API_URL || 'http://localhost:8000';
  const res = await require('axios').patch(
    `${API_URL}/perfil?user_id=${user_id}`,
    payload
  );
  return res.data;
};