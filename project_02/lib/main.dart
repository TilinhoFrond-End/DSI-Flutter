// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//import 'package:english_words/english_words.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random(); 
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: RandomWords(),
      ),
    );
  }
}

//RandomWords()

class RandomWords extends StatefulWidget {
  const RandomWords({ Key? key }) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final isSelected = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ToggleButtons(
        isSelected: isSelected,
        children: <Widget>[
          Icon(Icons.apps),
          Icon(Icons.list),
        ],
        onPressed: (int newindex) {
          setState(() {
            for (int index = 0; index < isSelected.length; index++)
            {
              if (index == newindex) {
                isSelected[index] = true;
              } else {
                isSelected[index] = false;
              }
              if ((index == 0) && (isSelected[index] == true)) {
                children: <Widget> [
                  ListVertical(),
                ];
              } 
            }
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Gerador de Palavras English'),
        bottom: TabBar(
          tabs: <Widget> [
            Tab(text: 'Lista Vertical'),
            Tab(text: 'Lista Grid'),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget> [
          ListVertical(),
          Gridview(),
        ],
      ),
        //body: 
    );
  }
}

class ListVertical extends StatelessWidget {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
  }
}

class Gridview extends StatelessWidget {
  final _suggestions = <WordPair>[];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //padding: const EdgeInsets.all(12),
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: /*1*/ (context, i) {
        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        return Card(
          child: Text(
            _suggestions[index].asPascalCase
          ),
        );
      },
    );
  }
}

/*GridView
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: /*1*/ (context, i) {
          /*if (i.isOdd) return const Divider(); 2*/
          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return Card(
            child: Text(
              _suggestions[index].asPascalCase
            ),
          );
        },
      ),
    );*/



