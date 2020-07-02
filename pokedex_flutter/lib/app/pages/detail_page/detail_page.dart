/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
// Pub.dev packages
import 'package:provider/provider.dart';
// Internal modules
import 'package:pokedex_flutter/app/utils/palette.dart';
import 'package:pokedex_flutter/app/utils/string_utils.dart';
import 'package:pokedex_flutter/app/common_widgets/type_label.dart';
import 'package:pokedex_flutter/app/blocs/pokemon_bloc.dart';
import 'package:pokedex_flutter/app/common_widgets/custom_cached_network_image.dart';
import 'package:pokedex_flutter/app/pages/detail_page/about_tab.dart';
import 'package:pokedex_flutter/app/pages/detail_page/stats_tab.dart';
import 'package:pokedex_flutter/app/pages/detail_page/evolution_tab.dart';
import 'package:pokedex_flutter/app/pages/detail_page/location_tab.dart';

class DetailPage extends StatefulWidget {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final PokemonBloc bloc;

  const DetailPage({Key key, this.bloc}) : super(key: key);

  // static widget creator to access bloc
  static Widget create(BuildContext context) {
    return Consumer<PokemonBloc>(
      builder: (_, bloc, __) => DetailPage(
        bloc: bloc,
      ),
    );
  }

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  /* ------------------- State Variables ------------------ */
  final tabs = [
    for (var tab in ['About', 'Stats', 'Evolution', 'Location']) ...[
      Tab(
        child: Column(
          children: <Widget>[
            (tab == 'About')
                ? Icon(Icons.info)
                : (tab == 'Stats')
                    ? Icon(Icons.equalizer)
                    : (tab == 'Evolution')
                        ? Icon(Icons.trending_up)
                        : Icon(Icons.location_searching),
            Text(tab),
          ],
        ),
      )
    ]
  ];

  TabController _tabController;

  /* ------------------ LifeCycle Methods ----------------- */
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: tabs.length,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /* ------------------------ Build ----------------------- */
  @override
  Widget build(BuildContext context) {
    final pokemon = widget.bloc.selectedPokemon;

    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                palette[pokemon.types[0]][Tone.regular],
                palette[pokemon.types[0]][Tone.dark],
                palette[pokemon.types[0]][Tone.light],
                palette[pokemon.types[0]][Tone.dark],
                palette[pokemon.types[0]][Tone.regular]
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 10.0),
                child: Column(
                  children: <Widget>[
                    _buildTopIcons(context),
                    SizedBox(height: 20.0),
                    _buildPageHeader(
                      pokemon.name,
                      pokemon.number,
                    ),
                    SizedBox(height: 5.0),
                    _buildTypes(pokemon.types),
                    SizedBox(height: 20.0),
                    _buildHero(pokemon.imageURL),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
              _buildTabBar(),
            ],
          ),
        ),
        _buildTabViews(),
      ],
    ));
  }

  Widget _buildTopIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 30,
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildPageHeader(String name, int number) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            name.capitalize(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '#$number',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypes(List<String> types) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        for (var type in types) ...[
          TypeLabel(type: type, text: type),
          SizedBox(width: 10.0)
        ],
      ],
    );
  }

  Widget _buildHero(String imageURL) {
    return Container(
      height: 250.0,
      child: Hero(
        tag: imageURL,
        child: CustomCachedNetworkImage(imageURL: imageURL),
      ),
    );
  }

  _buildTabBar() {
    final labelColor = palette[widget.bloc.selectedPokemon.types[0]][Tone.dark];
    final unselectedLabelColor =
        palette[widget.bloc.selectedPokemon.types[0]][Tone.light];
    final indicatorColor =
        palette[widget.bloc.selectedPokemon.types[0]][Tone.regular];

    return Container(
      padding: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: TabBar(
        tabs: tabs,
        controller: _tabController,
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        indicatorColor: indicatorColor,
      ),
    );
  }

  _buildTabViews() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: <Widget>[
          AboutTab.create(context),
          StatsTab.create(context),
          EvolutionTab.create(context),
          LocationTab.create(context),
        ],
      ),
    );
  }
}
