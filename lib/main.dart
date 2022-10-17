import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:english_words/english_words.dart';

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
            return ListTile(
                title: Text(
                    OTP.generateTOTPCodeString(_suggestions[index].asUpperCase,
                        DateTime.now().millisecondsSinceEpoch),
                    style: _biggerFont),
                subtitle: Text(OTP.remainingSeconds().toString()),
                trailing: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
                ),
                onTap: () {
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(_suggestions[index]);
                    } else {
                      _saved.add(_suggestions[index]);
                    }
                  });
                });
          }),
    );
  }
}
