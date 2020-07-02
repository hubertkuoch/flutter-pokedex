# Flutter PokéDex

There are plenty of examples and tutorials out there showing how to couple [`Flutter`](https://flutter.dev) with `BaaS` (mostly [`Firebase`](https://firebase.google.com/)) or making calls to existing `APIs`

This PokéDex calls endpoints from a [`Node`](https://nodejs.org/en/)/[`Express`](https://expressjs.com/) server coded from scratch. Except doing something different from the canonical [`Flutter`](https://flutter.dev)/`BaaS` approach, another reason behind it was to avoid making too many http requests to the well known [`PokéAPI`](https://pokeapi.co/) API to get the data I wanted to display

Main Flutter-related features:

-   Given the huge number of pokemons (e.g. 807 in total in this app), network images are cached (see [cached_network_image](https://pub.dev/packages/cached_network_image) package)
-   `BLoC` (see [Business Logic Component](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#bloc--rx)) approach to separate main pokemon-related state data from the UI via the combo of `Provider<T>`, `Consumer<T>` (see [provider](https://pub.dev/packages/provider) package) and `StreamBuilder<T>` (see [Dart](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html) doc)
    -   Note [redux](https://redux.js.org/) can also be used for app state management but I do not find it as user-friendly as it is when working with [React](https://fr.reactjs.org/)

## Demo

-   Screen 1: SliverGrid with elastic back-to-top animation triggered by FloatingActionButton
-   Screen 2: Hero tag for image animation and custom TabBar
-   Screen 3: Seach bar within CustomScrollView's SliverAppBar and custom route to navigate to other family chain member detail page

<img src="./step1.gif" width="250"/> |<img src="./step2.gif" width="250"/>|<img src="./step3.gif" width="250"/>
