import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/main.dart';
import 'package:quotes_app/utils/functions.dart';
import 'favouritesPage.dart';

// Structuring the Quote data
class Quote {
  late String name;
  late String description;

  Quote(
    this.name,
    this.description,
  );

  Quote.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  // the code to access the savedQuote.json file for writing in it;
  bool _fileExists = false;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/savedQuotes.json');
  }
  // the end of the code for writing to the file savedQuotes.json

  List _items = [];

  Future<void> readQuotesData(File file, List<Quote> list) async {
    String contents = await file.readAsString();
    if ((contents.isNotEmpty)) {
      var jsonResponse = jsonDecode(contents);

      for (var p in jsonResponse) {
        Quote player = Quote(p['name'], p['description']);
        list.add(player);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
      // to shuffle the list.
      _items.shuffle();
    });
  }

  // // Write content to a json file
  // Future<void> writeJson(dynamic response) async {
  //   final filename = 'local_user';
  //   final filepath = "${(await getApplicationDocumentsDirectory()).path}" +
  //       "/" +
  //       "${filename}.json";
  //   final file = File(filepath);
  //   file.writeAsString(json.encode(response));
  //   setState(() {});
  // }
  Map<String, dynamic> _json = {}; // done
  late String _jsonString;
  late File _filePath;

  void writeJson(String key, dynamic value) async {
    // Initialize the local _filePath
    //final _filePath = await _localFile;

    //1. Create _newJson<Map> from input<TextField>
    Map<String, dynamic> _newJson = {key: value};
    print('1.(writeJson) _newJson: $_newJson');

    //2. Update _json by adding _newJson<Map> -> _json<Map>
    _json.addAll(_newJson);
    // // // /// ////////////////////////////////////////////////////////////////////////////////// _json.remove(key);
    print('2.(writeJson) _json(updated): $_json');

    //3. Convert _json ->_jsonString
    _jsonString = jsonEncode(_json);
    print('3.(writeJson) _jsonString: $_jsonString\n - \n');

    //4. Write _jsonString to the _filePath
    _filePath.writeAsString(_jsonString);
  }

  // key of the GestureDetector (Used to copy to clipboard)
  final key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Card(
                            key: ValueKey(_items[index]),
                            margin: const EdgeInsets.all(10),
                            color: Colors.amber.shade100,
                            //for adding different color
                            // color: Colors.primaries[
                            //     _items.length % Colors.primaries.length],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    _items[index]["description"],
                                    style: GoogleFonts.pacifico(
                                      color: Colors.deepOrange,
                                      fontSize: 30,
                                    ),
                                  ),
                                  subtitle: Text(_items[index]["name"]),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      child: Icon(
                                        Icons.copy,
                                        color: Colors.blue,
                                      ),
                                      onTap: () {
                                        // to copy the content to clipboard
                                        Clipboard.setData(ClipboardData(
                                            text: _items[index]
                                                ['description']));

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
                                    TextButton(
                                      onPressed: () async {
                                        final File file = await _localFile;
                                        _fileExists = await file.exists();
                                        if (_fileExists) {
                                          try {
                                            var content1 =
                                                _items[index]['description'];
                                            var content2 =
                                                _items[index]['name'];

                                            Map<String, dynamic> toWriteMap =
                                                {};
                                            toWriteMap.addAll(
                                              {
                                                'description': content1,
                                                'name': content2
                                              },
                                            );

                                            List<Quote> savedQuotes = [];
                                            Quote newQuote =
                                                Quote(content2, content1);
                                            savedQuotes.add(newQuote);
                                            await readQuotesData(
                                                file, savedQuotes);
                                            savedQuotes
                                                .map(
                                                  (quote) => quote.toJson(),
                                                )
                                                .toList();

                                            file.writeAsString(
                                                jsonEncode(savedQuotes),
                                                mode: FileMode.writeOnly);

                                            print('written in the file');
                                          } catch (e) {
                                            print(
                                                'error quotesPage TextBUtton onpressed()');
                                            print('error => $e');
                                          }
                                        } else {
                                          print(
                                              "file error => _fileExists : $_fileExists");
                                        }
                                        // snackbar to acknowledge the content being copied
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                            'Added to Favourites',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          duration: Duration(milliseconds: 450),
                                          backgroundColor: Colors.brown,
                                        ));
                                      },
                                      child: Icon(Icons.link),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
