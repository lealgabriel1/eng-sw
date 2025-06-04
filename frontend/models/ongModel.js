const axios = require('axios');
const API_URL = process.env.API_URL || 'http://localhost:8000';

exports.getOng = async (id) => {
  const res = await axios.get(`${API_URL}/ongs/${id}`);
  return res.data;
};
