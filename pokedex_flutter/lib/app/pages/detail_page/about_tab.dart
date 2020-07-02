/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app/common_widgets/type_label.dart';
// Pub.dev packages
import 'package:provider/provider.dart';
// Internal modules
import 'package:pokedex_flutter/app/blocs/pokemon_bloc.dart';
import 'package:pokedex_flutter/app/models/pokemon.dart';
import 'package:pokedex_flutter/app/utils/constants.dart';
import 'package:pokedex_flutter/app/utils/string_utils.dart';

class AboutTab extends StatelessWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final Pokemon pokemon;

  const AboutTab({Key key, this.pokemon}) : super(key: key);

  // static widget creator to access bloc
  static Widget create(BuildContext context) {
    return Consumer<PokemonBloc>(
      builder: (_, bloc, __) => AboutTab(
        pokemon: bloc.selectedPokemon,
      ),
    );
  }

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Generation ${pokemon.generation}', style: kTabViewTitle),
            SizedBox(height: 10.0),
            Text(pokemon.description, style: kTabViewText),
            SizedBox(height: 10.0),
            _buildInfo(),
            SizedBox(height: 15.0),
            Text('Abilities', style: kTabViewTitle),
            SizedBox(height: 10.0),
            _buildAbilities(),
            SizedBox(height: 15.0),
            Text('Breeding', style: kTabViewTitle),
            SizedBox(height: 10.0),
            _buildBreeeding(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String text) {
    return Column(
      children: <Widget>[
        Text(title, style: kTabViewSubTitle),
        SizedBox(height: 5.0),
        Text(text, style: kTabViewText),
      ],
    );
  }

  Widget _buildInfo() {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildInfoItem('Height', '${pokemon.height / 10} m'),
              _buildInfoItem('Weight', '${pokemon.weight / 10} kg'),
              _buildInfoItem('Habitat', '${pokemon.habitat ?? 'unknown'}'),
              _buildInfoItem('Capture Rate',
                  '${(pokemon.captureRate * 100).toStringAsFixed(1)}%'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreeeding() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Gender', style: kTabViewSubTitle),
            SizedBox(height: 10.0),
            Text('Egg Groups', style: kTabViewSubTitle),
            SizedBox(height: 20.0),
          ],
        ),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (pokemon.genderRate.male == -1 || pokemon.genderRate.female == -1)
                ? Text('${pokemon.name.capitalize()} has no gender')
                : Row(
                    children: <Widget>[
                      Text(
                          'Male: ${(pokemon.genderRate.male * 100).toStringAsFixed(1)}%',
                          style: kTabViewText),
                      SizedBox(width: 30.0),
                      Text(
                          'Female: ${(pokemon.genderRate.female * 100).toStringAsFixed(1)}%',
                          style: kTabViewText),
                    ],
                  ),
            SizedBox(height: 10.0),
            Row(children: <Widget>[
              for (var eggGroup in pokemon.eggGroups) ...[
                TypeLabel(text: '$eggGroup'),
                SizedBox(width: 10.0),
              ],
            ]),
            SizedBox(height: 20.0),
          ],
        ),
      ],
    );
  }

  Widget _buildAbilities() {
    return Row(
      children: <Widget>[
        for (var ability in pokemon.abilities) ...[
          TypeLabel(text: ability),
          SizedBox(width: 10.0),
        ]
      ],
    );
  }
}
