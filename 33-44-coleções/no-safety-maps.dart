void main() {
  Map<int, String?>? ddds;

  ddds = {
    11: 'São Paulo',
    19: 'Campinas',
    41: 'Curitiba',
    76: null,
    80: null,
    81: 'Pernambuco',
  };

  if (ddds != null) ddds.remove(11);
}
