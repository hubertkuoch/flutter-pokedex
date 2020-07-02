// enumerate all endpoints
enum Endpoint { pokemons }

class API {
  static final String _host = 'localhost';
  static final int _port = 3000;
  static final String _basePath = 'api/v1';
  static Map<Endpoint, String> _paths = {
    Endpoint.pokemons: 'pokemons',
  };

  Uri endpointUri(Endpoint endpoint) {
    return Uri(
      scheme: 'http',
      host: _host,
      port: _port,
      path: '$_basePath/${_paths[endpoint]}',
    );
  }
}
