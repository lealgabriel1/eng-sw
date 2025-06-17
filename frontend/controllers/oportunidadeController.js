const oportunidadeModel = require('../models/oportunidadeModel');

exports.feed = async (req, res) => {
  try {
    const search = req.query.search || '';
    const oportunidades = await oportunidadeModel.getFeed(search);
    res.render('oportunidades', { oportunidades, search });
  } catch (error) {
    res.status(500).send("Erro ao carregar oportunidades: " + error.message);
  }
};

// detalhe da vaga
exports.detalhe = async (req, res) => {
  try {
    const id = req.params.id;
    const oportunidade = await oportunidadeModel.getById(id);
    res.render('detalhe', { oportunidade });
  } catch (error) {
    res.status(500).send("Erro ao carregar detalhe: " + error.message);
  }
};

// - - - processar inscrição
// GET form de inscricao
exports.inscreverForm = async (req, res) => {
  const id = req.params.id;
  // dados da oportunidade para mostrar no form
  const oportunidade = await oportunidadeModel.getById(id);
  res.render('inscrever', { oportunidade });
};

// POST inscricao
exports.inscrever = async (req, res) => {
  try {
    const user_id = 1; // <-- id logado
    const opp_id = req.params.id;
    const mensagem = req.body.mensagem || '';
    await oportunidadeModel.inscrever(user_id, opp_id, mensagem);
    // redirect ou mostra mensagem de sucesso
    res.render('inscricao_sucesso', { titulo: "Inscrição realizada!" });
  } catch (error) {
    // exibir mensagem de erro
    res.render('inscrever', { erro: error.response?.data?.detail || error.message });
  }
};