void main() {
  greet('Écio', client: 'Daniel', callback: (i) {
    for (int j = 0; j < i; j++) {
      print('Hello $j');
    }
  });

  testParams('a', null, d: 'd', e: null);

  String text = nullableFunction(12) ?? 'Uninformed';

  print(text.toUpperCase());
}

void greet(
  String name, {
  bool showNow = true,
  String? client,
  required Function(int) callback,
}) {
  print('Greetings from $name');

  callback(5);

  String c = client ?? 'Uninformed';

  print('Welcome, ${c.toUpperCase()}!');

  if (showNow) print('Now: ${now()}');
}

String now() {
  return DateTime.now().toString();
}

void testParams(
  String a,
  String? b, {
  String? c,
  required String d,
  required String? e,
  String f = 'f',
}) {
  print('a: $a, b: $b, c: $c, d: $d, e: $e, f: $f');
}

String? nullableFunction(int x) {
  return (x > 10) ? 'hello word' : null;
}
