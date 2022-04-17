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
      home: DefaultTabController(
        length: 2,
        child: RandomWords(),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({ Key? key }) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = [];
  final isSelected = <bool>[true, false];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palavras em English'),
        bottom: TabBar(
          tabs: <Widget> [
            Tab(text: 'Lista Vertical'),
            Tab(text: 'Lista Grid'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {}
          ),
        ],
      ),
    body: TabBarView(
        children: <Widget> [
          _buildSuggestions(),
          _gridsuggestions(),
        ],
      ),
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
        return ListTile(
            title: Text(_suggestions[index].asPascalCase),
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
          );
      }
    );
  }

  Widget _gridsuggestions() {
    return new GridView.builder(
      itemCount: 10,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: /*1*/ (BuildContext _context, i) {
        final index = i;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return ListTile(
          title: Text(_suggestions[index].asPascalCase),
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
        );
      }
    );
  }
}
