const express = require('express');
const exphbs  = require('express-handlebars');
const path = require('path');
const oportunidadeController = require('./controllers/oportunidadeController');
const usuarioController = require('./controllers/usuarioController');
const inscricaoController = require('./controllers/inscricaoController');

const app = express();

// helper pra lidar com datas
const hbs = exphbs.create({
  extname: '.hbs',
  helpers: {
    formatDate: function (isoString) {
      if (!isoString) return '';
      const date = new Date(isoString);
      const dia = String(date.getDate()).padStart(2, '0');
      const mes = String(date.getMonth() + 1).padStart(2, '0');
      const ano = date.getFullYear();
      const hora = String(date.getHours()).padStart(2, '0');
      const min = String(date.getMinutes()).padStart(2, '0');
      return `${dia}/${mes}/${ano} às ${hora}:${min}`;
    },
    split: function (string) {
    if (!string) return [];
    return string.split(',').map(s => s.trim()).filter(Boolean);
    },
      capitalize: function (text) {
    if (!text) return '';
    return text.charAt(0).toUpperCase() + text.slice(1);
    }
  }
});

app.engine('hbs', hbs.engine);
app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, 'views'));

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => res.redirect('/oportunidades'));
app.get('/oportunidades', oportunidadeController.feed);
// rota para detalhes
app.get('/oportunidades/:id', oportunidadeController.detalhe);
// rotas de inscricao
app.get('/oportunidades/:id/inscrever', oportunidadeController.inscreverForm);
app.post('/oportunidades/:id/inscrever', oportunidadeController.inscrever);
//rotas de perfil
app.get('/perfil', usuarioController.perfil);
app.get('/inscricoes', inscricaoController.lista);
app.get('/perfil/editar', usuarioController.editarForm);
app.post('/perfil/editar', usuarioController.editar);

const PORT = 3001;
app.listen(PORT, () => {
  console.log(`Frontend rodando em http://localhost:${PORT}`);
});
