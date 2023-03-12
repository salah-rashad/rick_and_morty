// ignore_for_file: unused_field

class Url {
  final String url;
  const Url(this.url);

  @override
  String toString() => url;
}

class ApiUrls {
  ApiUrls._();

  static Uri HOST_URI = Uri.https("rickandmortyapi.com");
  static const String HOST_URL = "https://rickandmortyapi.com";

  // ~~~~~~~~~~~~~~~~~ CHARACTERS ~~~~~~~~~~~~~~~~~ //

  static const _characters = "$HOST_URL/api/character";

  static Url CHARACTERS = const Url(_characters);

  // ~~~~~~~~~~~~~~~~~ LOCATIONS ~~~~~~~~~~~~~~~~~ //

  static const _locations = "$HOST_URL/api/location";

  // ~~~~~~~~~~~~~~~~~ EPISODES ~~~~~~~~~~~~~~~~~ //

  static const _episodes = "$HOST_URL/api/episode";
}
