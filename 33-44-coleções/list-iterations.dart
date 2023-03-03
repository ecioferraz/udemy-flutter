void main() {
  List<String> names = [
    'Écio',
    'Allef',
    'Lucas',
    'Wesiley',
    'Augusto',
    'Tone',
    'Henri'
  ];

  print(names);

  print('-' * 20);

  for (int i = 0; i <= names.length - 1; i++) {
    print(names[i].toUpperCase());
  }

  print('-' * 20);

  for (String name in names) print(name.toUpperCase());

  print('-' * 20);

  for (String name in names.sublist(2, 4)) print(name.toUpperCase());

  print('-' * 20);

  names.forEach((name) => print(name.toUpperCase()));

  print('-' * 20);

  List<String> randomList = List.filled(10, 'fill');

  print(randomList);

  List<int> anotherRandomList = List.generate(10, (i) => i * 10);

  print(anotherRandomList);
  print(anotherRandomList.isNotEmpty);

  anotherRandomList.removeAt(0);

  print(anotherRandomList.any((item) => item % 33 == 0)); // .some()
  print(anotherRandomList.firstWhere((item) => item % 40 == 0));
  print(anotherRandomList.lastWhere((item) => item % 40 == 0));
  print(anotherRandomList.where((item) => item % 20 == 0));

  print(anotherRandomList.map((item) => item * 2));
}
