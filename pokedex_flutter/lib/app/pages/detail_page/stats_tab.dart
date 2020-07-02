/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
// Pub.dev packages
import 'package:provider/provider.dart';
// Internal modules
import 'package:pokedex_flutter/app/utils/palette.dart';
import 'package:pokedex_flutter/app/utils/constants.dart';
import 'package:pokedex_flutter/app/utils/string_utils.dart';
import 'package:pokedex_flutter/app/models/pokemon.dart';
import 'package:pokedex_flutter/app/blocs/pokemon_bloc.dart';
import 'package:pokedex_flutter/app/common_widgets/bar.dart';

class StatsTab extends StatelessWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final Pokemon pokemon;

  const StatsTab({Key key, this.pokemon}) : super(key: key);

  // static widget creator to access bloc
  static Widget create(BuildContext context) {
    return Consumer<PokemonBloc>(
      builder: (_, bloc, __) => StatsTab(
        pokemon: bloc.selectedPokemon,
      ),
    );
  }

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    final barColor = palette[pokemon.types[0]][Tone.regular];
    final attack = pokemon.stats.attack;
    final defense = pokemon.stats.defense;
    final hp = pokemon.stats.hp;
    final speed = pokemon.stats.speed;
    final specialAttack = pokemon.stats.specialAttack;
    final specialDefense = pokemon.stats.specialDefense;
    final totalStat =
        ((attack + defense + hp + speed + specialAttack + specialDefense) / 6)
            .round();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${pokemon.name.capitalize()} Stats', style: kTabViewTitle),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Bar(
                      label: "Attack",
                      stat: attack,
                      color: barColor,
                    ),
                    Bar(
                      label: "Defense",
                      stat: defense,
                      color: barColor,
                    ),
                    Bar(
                      label: "HP",
                      stat: hp,
                      color: barColor,
                    ),
                    Bar(
                      label: "Speed",
                      stat: speed,
                      color: barColor,
                    ),
                    Bar(
                      label: "Special Attack",
                      stat: specialAttack,
                      color: barColor,
                    ),
                    Bar(
                      label: "Special Defense",
                      stat: specialDefense,
                      color: barColor,
                    ),
                    Bar(
                      label: "Total",
                      stat: totalStat,
                      color: barColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
