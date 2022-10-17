import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:english_words/english_words.dart';
import 'dart:async';

void main() {
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Welcome to Flutter',
      home: AuthItem(),
    );
  }
}

class AuthItem extends StatefulWidget {
  const AuthItem({super.key});

  @override
  State<AuthItem> createState() => _AuthItemState();
}

class _AuthItemState extends State<AuthItem> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Startup Name Generator'), actions: [
        IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Saved Suggestions',
            onPressed: _pushSaved)
      ]),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();

            final index = i ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            final alreadySaved = _saved.contains(_suggestions[index]);
            return AuthItemTile(
              secret: _suggestions[index].asUpperCase,
            );
          }),
    );
  }
}

class AuthItemTile extends StatefulWidget {
  final String secret;

  const AuthItemTile({Key? key, required this.secret}) : super(key: key);

  @override
  State<AuthItemTile> createState() => _AuthItemTileState();
}

class _AuthItemTileState extends State<AuthItemTile> {
  int _time = DateTime.now().millisecondsSinceEpoch;

  late Timer _everySecond;

  @override
  void initState() {
    super.initState();

    _everySecond = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState(() {
        _time = DateTime.now().millisecondsSinceEpoch;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(OTP.generateTOTPCodeString(widget.secret, _time)),
      subtitle: Text(OTP.remainingSeconds().toString()),
    );
  }
}
