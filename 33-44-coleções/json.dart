import 'dart:convert';

void main() {
  Map<String, dynamic> data = json.decode(userData());

  print(data['address']['number']);
  print(data['courses'][0]['name']);
}

String userData() {
  return """
  {
    "nome": "Écio",
    "lastName": "Ferraz",
    "age": 31,
    "married": false,
    "height": 1.72,
    "courses": [
      {
        "name": "Dart",
        "difficulty": 1
      },
      {
        "name": "Flutter",
        "difficulty": 2
      }
    ],
    "address": {
      "city": "Recife",
      "country": "Brazil",
      "number": 121
    }
  }""";
}
