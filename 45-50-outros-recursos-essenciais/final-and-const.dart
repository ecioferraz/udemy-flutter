void main() {
  const String name = 'Écio';
  const int age = 31;
  const List<String> list = ['Écio', 'Ferraz']; // can't add or remove items

  final String lastName; // can be assigned later

  if (name == 'Écio') {
    lastName = 'Ferraz';
  } else {
    lastName = 'Silva';
  }

  // lastName = 'Doe' // cannot be assigned
}
