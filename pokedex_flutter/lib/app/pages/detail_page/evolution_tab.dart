/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
// Pub.dev packages
import 'package:provider/provider.dart';
// Internal modules
import 'package:pokedex_flutter/app/utils/constants.dart';
import 'package:pokedex_flutter/app/utils/string_utils.dart';
import 'package:pokedex_flutter/app/models/pokemon.dart';
import 'package:pokedex_flutter/app/blocs/pokemon_bloc.dart';

class EvolutionTab extends StatelessWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final PokemonBloc bloc;

  const EvolutionTab({Key key, @required this.bloc}) : super(key: key);

  // static widget creator to access bloc
  static Widget create(BuildContext context) {
    return Consumer<PokemonBloc>(
      builder: (_, bloc, __) => EvolutionTab(
        bloc: bloc,
      ),
    );
  }

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Family Evolution Chain', style: kTabViewTitle),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: (bloc.evolutions.isEmpty)
                  ? Text(
                      '${bloc.selectedPokemon.name.capitalize()} has no evolution')
                  : Column(
                      children: <Widget>[
                        for (var evolution in bloc.evolutions) ...[
                          _buildChain(context, evolution),
                          SizedBox(height: 50.0),
                        ]
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChain(BuildContext context, EvolutionChain evolution) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            bloc.selectPokemon(evolution.from.name);
            Navigator.of(context).popAndPushNamed('/detail-page');
          },
          child: Container(
            height: 100.0,
            child: Image.network(evolution.from.imageURL),
          ),
        ),
        _buildChainText(evolution),
        GestureDetector(
          onTap: () {
            bloc.selectPokemon(evolution.to.name);
            Navigator.of(context).popAndPushNamed('/detail-page');
          },
          child: Container(
            height: 100.0,
            child: Image.network(evolution.to.imageURL),
          ),
        ),
      ],
    );
  }

  Widget _buildChainText(EvolutionChain evolution) {
    return (evolution.item != null)
        ? Column(
            children: <Widget>[
              Text(
                'Item',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(evolution.item),
            ],
          )
        : (evolution.level != null)
            ? Column(
                children: <Widget>[
                  Text(
                    'Level',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${evolution.level}'),
                ],
              )
            : Text(
                '???',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              );
  }
}
