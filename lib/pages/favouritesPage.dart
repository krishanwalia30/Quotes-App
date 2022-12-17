import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/pages/example.dart';
import 'package:quotes_app/pages/favouritesPage.dart';

import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/pages/quotesPage.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  // Code1 = to fill the favQuotes List.....
  List<Quote> favQuotes = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/savedQuotes.json');
  }

  bool _fileExists = false;
  bool _contentPresent = false;

  Future<void> displayQuotesData() async {
    final File file = await _localFile;
    _fileExists = await file.exists();
    if (_fileExists) {
      try {
        final String contents = await file.readAsString();
        if ((contents.isNotEmpty)) {
          var jsonResponse = jsonDecode(contents);
          print('file opened');
          setState(() {});
          for (var p in jsonResponse) {
            Quote player = Quote(p['name'], p['description']);
            favQuotes.add(player);
          }
          print(favQuotes.length);
          if (favQuotes.length != 0) {
            _contentPresent = true;
          }
        }
      } catch (e) {
        print('an error occured while opening the file => $e');
      }
    } else {
      file.create();
      print("file error => _fileExists : $_fileExists");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayQuotesData();
    // _buildItem();
  }
  // Code1 ends here

  Widget _buildItem() {
    // print("hello");
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: favQuotes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.amber.shade100,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                favQuotes[index].description,
                                style: GoogleFonts.pacifico(
                                  color: Colors.deepOrange,
                                  fontSize: 30,
                                ),
                              ),
                              subtitle: Text(favQuotes[index].name),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      // code to delete the item from the saved lists.
                                      // setState(() {
                                      //   touchedScreen = true;
                                      // });
                                    },
                                    child: Icon(Icons.delete)),
                                TextButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   touchedScreen = true;
                                      // });
                                    },
                                    child: Icon(Icons.copy)),
                              ],
                            ),
                          ],
                        ),
                      );
                    }))
          ]),
    );
  }

  // everything about animated lists......
  final _items = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  // void _addItem() {
  //   .insert(0, "Item ${_items.length + 1}");
  //   _key.currentState!.insertItem(0, duration: Duration(seconds: 1));
  // }

  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          child: SizedBox(
            height: 100,
            // child: Text(
            //   'Deleted',
            //   style: TextStyle(fontSize: 3),
            // ),
          ),
        ),
      );
    }, duration: Duration(milliseconds: 700));
    favQuotes.removeAt(index);
  }

  Widget _buildWhenNoContent() {
    return Scaffold(
      body: Center(
        child: Text(
          "Nothing to Show",
          style: GoogleFonts.pacifico(
              color: Colors.deepOrangeAccent,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // this is used to check if the screen is touched or not.
  // bool touchedScreen = false;

  @override
  Widget build(BuildContext context) {
    return !_contentPresent
        ? _buildWhenNoContent()
        // : !touchedScreen
        //     ? _buildItem()
        : Column(
            children: [
              Expanded(
                child: AnimatedList(
                  key: _key,
                  initialItemCount: favQuotes.length,
                  itemBuilder: (context, index, animation) {
                    return SizeTransition(
                      key: UniqueKey(),
                      sizeFactor: animation,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        color: Colors.amber.shade100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Text(
                                favQuotes[index].description,
                                style: GoogleFonts.pacifico(
                                    fontSize: 30, color: Colors.deepOrange),
                              ),
                              subtitle: Text(favQuotes[index].name),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      // code to delete the item from the saved lists.
                                      // print(favQuotes.length);

                                      _removeItem(index);
                                      final File file = await _localFile;
                                      file.writeAsString(jsonEncode(favQuotes),
                                          mode: FileMode.writeOnly);
                                      if (favQuotes.length == 0) {
                                        setState(() {
                                          _contentPresent = false;
                                        });
                                      }

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                          'Quote Deleted From Favourites',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 450),
                                        backgroundColor: Colors.brown,
                                      ));
                                    },
                                    child: Icon(Icons.delete)),
                                GestureDetector(
                                  child: const Icon(
                                    Icons.copy,
                                    color: Colors.blue,
                                  ),
                                  onTap: () {
                                    // to copy the content to clipboard
                                    Clipboard.setData(ClipboardData(
                                        text: favQuotes[index].description));

                                    // snackbar to acknowledge the content being copied
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        'Copied to clipboard',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 450),
                                      backgroundColor: Colors.cyan,
                                    ));
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
