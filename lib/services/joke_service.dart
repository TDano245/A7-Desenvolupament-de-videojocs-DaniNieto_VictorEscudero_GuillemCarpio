import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/joke_model.dart';

class JokeService {
  final String url = "https://api.sampleapis.com/jokes/goodJokes";

  Future<Joke> getRandomJoke() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      // coger uno aleatorio
      data.shuffle();
      return Joke.fromMap(data.first);
    } else {
      throw Exception("Error al cargar chistes");
    }
  }
}