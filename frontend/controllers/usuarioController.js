const usuarioModel = require('../models/usuarioModel');

exports.perfil = async (req, res) => {
  try {
    const user_id = 1; // em produção: tirar o mock
    const perfil = await usuarioModel.getPerfil(user_id);
    res.render('perfil', { perfil });
  } catch (error) {
    res.status(500).send('Erro ao carregar perfil: ' + error.message);
  }
};

// exibir o form
exports.editarForm = async (req, res) => {
  try {
    const user_id = 1; // depois, usuário logado
    const perfil = await usuarioModel.getPerfil(user_id);
    res.render('editar', { perfil });
  } catch (error) {
    res.status(500).send("Erro ao carregar perfil: " + error.message);
  }
};

// envio
exports.editar = async (req, res) => {
  try {
    const user_id = 1;
    const { nome, endereco, competencias } = req.body;
    const payload = { nome, endereco, competencias };
    await usuarioModel.atualizarPerfil(user_id, payload);
    res.render('editar', { perfil: { nome, endereco, competencias }, sucesso: true });
  } catch (error) {
    res.render('editar', { erro: error.response?.data?.detail || error.message });
  }
};