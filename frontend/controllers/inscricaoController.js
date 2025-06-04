const inscricaoModel = require('../models/inscricaoModel');

exports.lista = async (req, res) => {
  try {
    const user_id = 1; // depois: trocar para usuário logado
    const inscricoes = await inscricaoModel.getMinhasInscricoes(user_id);
    res.render('inscricoes/index', { inscricoes });
  } catch (error) {
    res.status(500).send("Erro ao carregar inscrições: " + error.message);
  }
};
