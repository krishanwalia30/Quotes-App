import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List _items = [];

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'QUOTES APP',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // This Button was used to call the function readJson
            // and now that pupose is served by overriding void init function
            // ElevatedButton(
            //   onPressed: readJson,
            //   child: const Text('Show Quotes'),
            // ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          key: ValueKey(_items[index]["id"]),
                          margin: const EdgeInsets.all(10),
                          color: Colors.amber.shade100,
                          child: ListTile(
                            // leading: Text(_items[index]["id"]),
                            title: Text(
                              _items[index]["description"],
                              style: GoogleFonts.pacifico(
                                color: Colors.deepOrange,
                                fontSize: 30,
                              ),
                            ),
                            subtitle: Text(_items[index]["name"]),
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
