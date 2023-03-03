void main() {
  List<String> names = ['Écio', 'Ferraz'];
  List userData = [...names, 31, true];

  print(userData);

  List<int> ages = [15, 32, 56, 78];

  ages
    ..add(4)
    ..add(466);

  ages.addAll([567, 25, 4634]);
  ages.insert(2, -2); // adds by index

  print(ages.contains(56));
  print(ages.indexOf(4));

  print(ages.remove(4)); // bool
  print(ages.removeAt(3)); // returns number removed

  print(ages);

  ages.shuffle(); // randomizes the list

  print(ages);

  ages.clear();

  print(ages);
}
