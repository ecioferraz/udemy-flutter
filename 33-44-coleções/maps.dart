void main() {
  Map<int, String> ddds = {
    11: 'São Paulo',
    19: 'Campinas',
    41: 'Curitiba',
    81: 'Pernambuco',
  };

  print(ddds[0]); // null
  print(ddds[81]);

  ddds[61] = 'Brasília';

  print(ddds);

  ddds[61] = 'replaceable';

  print(ddds[61]);

  ddds.remove(61);

  print(ddds.keys);

  print(ddds.containsKey(81));
  print(ddds.containsValue('Pernambuco'));

  ddds.forEach((key, value) {
    print('Key: $key, Value: $value');
  });

  ddds.addAll({79: 'Sergipe', 83: 'Paraíba'});

  print(ddds);

  ddds.removeWhere((key, value) => key > 81);

  print(ddds);

  String city = ddds[13] ?? 'Not found';

  print(city.toUpperCase());
}
