const ongModel = require('../models/ongModel');

exports.perfil = async (req, res) => {
  try {
    const ong = await ongModel.getOng(req.params.id);
    res.render('ongs/perfil', { ong });
  } catch (error) {
    res.status(500).send("Erro ao carregar perfil da ONG: " + error.message);
  }
};
