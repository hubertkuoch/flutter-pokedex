/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
// Pub.dev packages
import 'package:provider/provider.dart';
// Internal modules
import 'package:pokedex_flutter/app/blocs/pokemon_bloc.dart';

class SearchBar extends StatefulWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final void Function(String) search;

  const SearchBar({Key key, this.search}) : super(key: key);

  // static widget creator to access bloc
  static Widget create(BuildContext context) {
    return Consumer<PokemonBloc>(
      builder: (_, bloc, __) => SearchBar(
        search: bloc.searchPokemons,
      ),
    );
  }

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  /* ------------------- State Variables ------------------ */
  final _textController = TextEditingController();

  /* ------------------ LifeCycle Methods ----------------- */
  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  /* ----------------------- Actions ---------------------- */
  void clearInput() {
    _textController.clear();
    widget.search("");
  }

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextField(
        controller: _textController,
        autocorrect: false,
        onChanged: widget.search,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 0.8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              width: 0.8,
              color: Theme.of(context).primaryColor,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            size: 30,
          ),
          hintText: "Search Pokemon",
          suffixIcon: IconButton(
            onPressed: clearInput,
            icon: Icon(Icons.clear),
          ),
        ),
      ),
    );
  }
}
