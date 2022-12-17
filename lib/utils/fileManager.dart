import 'dart:convert';
import 'dart:io';


List<Quote> quoteList = [];

class Quote {
  late String name;
  late String description;

  Quote(
    this.name,
    this.description,
  );

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['name'] = this.name;
    data['description'] = this.description;

    return data;
  }
}

Future<void> readQuoteData(File file) async {
  String contents = await file.readAsString();
  var jsonResponse = jsonDecode(contents);

  for (var p in jsonResponse) {
    Quote quote = Quote(p['name'], p['description']);
    quoteList.add(quote);
  }
}

void main() async {
  print("hello world");
  final File file =
      File('C:\Users\HP\quotes_app\assets\favourite.json'); //load the json file
  await readQuoteData(file); //read data from json file

  Quote newPlayer = Quote(
    //add a new item to data list
    'Samy Brook',
    '31',
  );

  quoteList.add(newPlayer);

  print(quoteList.length);

  quoteList //convert list data  to json
      .map(
        (player) => player.toJson(),
      )
      .toList();

  file.writeAsStringSync(json.encode(quoteList));
}
