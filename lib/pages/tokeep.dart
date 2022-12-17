import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
        }
      } catch (e) {
        print('an error occured while opening the file => $e');
      }
    } else {
      file.create();
      print("file error => _fileExists : $_fileExists");
    }
  }

  // code begins here
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // list favQUotes<Quote>;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayQuotesData();

    // readQuoteData();
  }

  Widget _buildItem(BuildContext context, int index) {
    // print("hello");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
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
                  TextButton(onPressed: () {}, child: Icon(Icons.share)),
                  TextButton(
                      onPressed: () {
                        // code to delete the item from the saved lists.
                      },
                      child: Icon(Icons.delete)),
                  TextButton(onPressed: () {}, child: Icon(Icons.copy)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              key: _listKey,
              itemCount: favQuotes.length,
              itemBuilder: _buildItem,
              // itemBuilder: (context, index, animation) {
              // print('hello i am here');
              //   setState(() {
              //     _buildItem(context, index, animation);
              //   });
              //   return _buildItem(context, index, animation);
              // },
            ),
          ),
        ],
      ),
    );
  }
}
