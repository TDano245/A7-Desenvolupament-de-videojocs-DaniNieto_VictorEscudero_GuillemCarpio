class Joke {
  final int id;
  final String setup;
  final String punchline;

  Joke({
    required this.id,
    required this.setup,
    required this.punchline,
  });

  factory Joke.fromMap(Map<String, dynamic> json) {
    return Joke(
      id: json["id"],
      setup: json["setup"],
      punchline: json["punchline"],
    );
  }
}