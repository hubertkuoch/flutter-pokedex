/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
// Pub.dev packages
import 'package:provider/provider.dart';
// Internal modules
import 'package:pokedex_flutter/app/utils/constants.dart';
import 'package:pokedex_flutter/app/blocs/pokemon_bloc.dart';
import 'package:pokedex_flutter/app/common_widgets/custom_card.dart';
import 'package:pokedex_flutter/app/pages/home_page/search_bar.dart';
import 'package:pokedex_flutter/app/models/pokemon.dart';

class HomePage extends StatefulWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final PokemonBloc bloc;

  const HomePage({Key key, @required this.bloc}) : super(key: key);

  // static widget creator to access bloc
  static Widget create(BuildContext context) {
    return Consumer<PokemonBloc>(
      builder: (_, bloc, __) => HomePage(
        bloc: bloc,
      ),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* ------------------- State Variables ------------------ */
  final _scrollController = ScrollController();

  /* ------------------ LifeCycle Methods ----------------- */
  @override
  void initState() {
    super.initState();
    widget.bloc.getAllPokemons();
  }

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Flutter PokéDex', style: kAppBarTitle),
            expandedHeight: 120,
            flexibleSpace: ListView(
              children: <Widget>[
                SizedBox(height: 60.0),
                SearchBar.create(context),
              ],
            ),
          ),
          StreamBuilder(
            stream: widget.bloc.isLoadingStream,
            initialData: true,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case false:
                  return _buildContent();
                default:
                  return _buildSpinner();
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0.0,
            duration: Duration(seconds: 2),
            curve: Curves.elasticOut,
          );
        },
        child: Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSpinner() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 250.0),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildContent() {
    return StreamBuilder<List<Pokemon>>(
        stream: widget.bloc.searchedPokemonsStream,
        initialData: widget.bloc.pokemons,
        builder: (context, snapshot) {
          return SliverPadding(
            padding: const EdgeInsets.all(5.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final pokemons = snapshot.data;
                  final pokemon = pokemons[index];
                  final name = pokemon.name;
                  final types = pokemon.types;
                  final color = types[0];
                  final imageURL = pokemon.imageURL;

                  return GestureDetector(
                    onTap: () {
                      widget.bloc.selectPokemon(name);
                      Navigator.of(context).pushNamed('/detail-page');
                    },
                    child: CustomCard(
                      color: color,
                      name: name,
                      types: types,
                      imageURL: imageURL,
                    ),
                  );
                },
                childCount: widget.bloc.searchedPokemons.length,
              ),
            ),
          );
        });
  }
}
