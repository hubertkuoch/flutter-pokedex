/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/foundation.dart';
// Internal modules - API
import 'package:pokedex_flutter/app/services/api_services.dart';
import 'package:pokedex_flutter/app/services/api.dart';
import 'package:pokedex_flutter/app/repositories/repository.dart';
// Internal modules - model
import 'package:pokedex_flutter/app/models/pokemon.dart';

class PokemonRepository implements Repository {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final APIServices apiServices;

  PokemonRepository({@required this.apiServices});

  // fetch data
  @override
  Future<List<Pokemon>> getAll() async {
    final body = await apiServices.getEndpointData(
      endpoint: Endpoint.pokemons,
    );
    final List<dynamic> data = body['data'];

    final List<Pokemon> pokemons =
        data.map((element) => Pokemon.fromMap(element)).toList();
    return pokemons;
  }
}
