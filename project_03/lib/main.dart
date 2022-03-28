// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// create a global saved set
Set<WordPair> savedGlobal = new Set<WordPair>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primeiro App',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({ Key? key }) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  var _suggestions = [];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palavras em English'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage()
              ),
            );
          }),
        ],
      ),
    body: _buildSuggestions()
    );
  }

  Widget _buildSuggestions(){
          return new ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: /*1*/ (BuildContext _context, i) {
              if (i.isOdd) return const Divider();
              final index = i ~/ 2;
              if (index >= _suggestions.length) {
                _suggestions.addAll(generateWordPairs().take(10));
              }
              return Card(
                child: ListTile(
                  title: _buildRow(_suggestions[index]),
                  trailing:
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          ),
                          onTap: (){
                            setState(() {
                              _suggestions.removeAt(index);
                            });
                          },
                        ),
                      ];
                    },
                  ),
                ),
              );
            }
          );
        }

  /*void edit(int index) => showDialog(
      context: context,
      builder: (context) {
        final palavra = _suggestions[index];

        return AlertDialog(
          content: TextFormField(
            initialValue: palavra,
            onChanged: (name) => setState(() {
              palavra = name;
            }),
          ),
        );
      });*/

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = savedGlobal.contains(pair);

    return new ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            savedGlobal.remove(pair);
          } else {
            savedGlobal.add(pair);
          }
        });
      },
    );
  }
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  //bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    Iterable<ListTile> tiles = savedGlobal.map((WordPair pair) {
      return new ListTile(
        onLongPress: () {
          setState(() {
            savedGlobal.remove(pair);
            Navigator.of(context).pop();
          });
        },
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      );
    });

    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: new ListView(children: divided),
    );
  }
}
