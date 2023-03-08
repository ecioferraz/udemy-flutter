void main() {
  try {
    function(-10);
  } on InvalidParamException catch (e) {
    print(e);
  } catch (e) {
    print(e);
  }
}

void function(int x) {
  if (x <= 0) throw InvalidParamException();
  print(x);
}

class InvalidParamException implements Exception {
  String toString() {
    return 'Value cannot be negative';
  }
}
