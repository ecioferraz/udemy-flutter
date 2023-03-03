void main() {
  List<String> list1 = [];

  list1.add('value'); // ['value']

  List<String>? list2; // null

  if (list2 != null) list2.add('value');

  List<String?>? list3;

  print(list3);

  if (list3 != null) list3.add(null); // [null]

  List<String?> list4 = [];

  list4.add(null);
}
