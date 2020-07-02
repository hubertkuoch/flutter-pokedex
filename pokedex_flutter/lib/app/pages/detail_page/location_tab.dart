/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
// Pub.dev packages
import 'package:provider/provider.dart';
// Internal modules
import 'package:pokedex_flutter/app/utils/constants.dart';
import 'package:pokedex_flutter/app/utils/string_utils.dart';
import 'package:pokedex_flutter/app/blocs/pokemon_bloc.dart';

class LocationTab extends StatelessWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final List<String> locations;

  const LocationTab({Key key, this.locations}) : super(key: key);

  // static widget creator to access bloc
  static Widget create(BuildContext context) {
    return Consumer<PokemonBloc>(
      builder: (_, bloc, __) => LocationTab(
        locations: bloc.selectedPokemon.locations,
      ),
    );
  }

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Capture Locations', style: kTabViewTitle),
          (locations.isEmpty)
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text('This pokemon cannot be captured'),
                        Text('See "Evolution"'),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 5.0),
                    itemCount: locations.length,
                    itemBuilder: (_, index) => Container(
                      height: 25.0,
                      decoration: BoxDecoration(),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.subdirectory_arrow_right),
                          Text(
                            locations[index].capitalize(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
