/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Pub.dev packages
import 'package:provider/provider.dart';
// Internal modules - state management
import 'package:pokedex_flutter/app/blocs/pokemon_bloc.dart';
import 'package:pokedex_flutter/app/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/app/services/api_services.dart';
import 'app/services/api.dart';
// Internal modules - routes/pages
import 'app/pages/home_page/home_page.dart';
import 'package:pokedex_flutter/app/pages/detail_page/detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // set portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    // provide bloc state and actions
    return Provider<PokemonBloc>(
      create: (_) => PokemonBloc(
        pokemonRepository: PokemonRepository(
          apiServices: APIServices(
            api: API(),
          ),
        ),
      ),
      dispose: (_, bloc) => bloc.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter PokéDex',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage.create(context),
          '/detail-page': (context) => DetailPage.create(context),
        },
      ),
    );
  }
}
