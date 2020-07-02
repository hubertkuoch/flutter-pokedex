/* ------------------------------------------------------ */
/*                         Import                         */
/* ------------------------------------------------------ */
/* ---------------------- internal ---------------------- */
const CRUDFactory = require('../middlewares/CRUDFactory');
const PokemonModel = require('../models/Pokemon');

/* ------------------------------------------------------ */
/*                       Controller                       */
/* ------------------------------------------------------ */
const getPokemons = CRUDFactory.getAll(PokemonModel, {});
const getPokemon = CRUDFactory.getOne(PokemonModel);

/* ------------------------------------------------------ */
/*                         Export                         */
/* ------------------------------------------------------ */
module.exports = { getPokemons, getPokemon };
