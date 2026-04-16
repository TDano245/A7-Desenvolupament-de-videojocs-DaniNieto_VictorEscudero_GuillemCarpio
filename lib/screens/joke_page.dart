import 'package:flutter/material.dart';
import '../services/joke_service.dart';
import '../model/joke_model.dart';

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  final JokeService _service = JokeService();
  Joke? _joke;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadJoke();
  }

  Future<void> _loadJoke() async {
    setState(() => _isLoading = true);

    try {
      final joke = await _service.getRandomJoke();
      setState(() => _joke = joke);
    } catch (e) {
      print(e);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jokes 😂"),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _joke == null
                ? const Text("Pulsa el botón")
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _joke!.setup,
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _joke!.punchline,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadJoke,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}