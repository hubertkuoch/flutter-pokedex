/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'dart:async';
import 'package:flutter/foundation.dart';
// Internal modules
import 'bloc.dart';
import 'package:pokedex_flutter/app/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/app/models/pokemon.dart';

class PokemonBloc implements Bloc {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final PokemonRepository pokemonRepository;
  PokemonBloc({@required this.pokemonRepository});

  // state
  List<Pokemon> pokemons;
  List<Pokemon> searchedPokemons;
  Pokemon selectedPokemon;
  List<EvolutionChain> evolutions;

  // stream controllers
  final _isLoadingController = StreamController<bool>();
  final _searchedPokemonsController = StreamController<List<Pokemon>>();

  // stream getters/listeners
  Stream<bool> get isLoadingStream => _isLoadingController.stream;
  Stream<List<Pokemon>> get searchedPokemonsStream =>
      _searchedPokemonsController.stream;

  /* --------------------- Stream Sink -------------------- */
  // sink isLoading into stream
  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  void _setSearchedPokemons(List<Pokemon> searchedPokemons) =>
      _searchedPokemonsController.add(searchedPokemons);

  /* ----------------------- Actions ---------------------- */
  // close controller when disposing bloc
  @override
  void dispose() {
    _isLoadingController.close();
    _searchedPokemonsController.close();
  }

  // fetch all pokemons in memory/app state
  Future<void> getAllPokemons() async {
    pokemons = await pokemonRepository.getAll();
    searchedPokemons = pokemons;
    _setIsLoading(false);
  }

  // filter pokemons on search
  void searchPokemons(String textInput) {
    switch (textInput) {
      case "":
        searchedPokemons = pokemons;
        break;
      default:
        searchedPokemons = pokemons
            .where((pokemon) => pokemon.name.contains(textInput.toLowerCase()))
            .toList();
        break;
    }
    _setSearchedPokemons(searchedPokemons);
  }

  // set selectedPokemon state variable
  void selectPokemon(String name) {
    selectedPokemon =
        pokemons.where((pokemon) => pokemon.name == name).toList()[0];
    evolutions = selectedPokemon.evolutionChain
        .map(
          (evolution) => EvolutionChain(
            from: pokemons
                .where((pokemon) => pokemon.name == evolution.from)
                .toList()[0],
            to: pokemons
                .where((pokemon) => pokemon.name == evolution.to)
                .toList()[0],
            level: evolution.level,
            item: evolution.item,
          ),
        )
        .toList();
  }
}
