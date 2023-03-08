void main() {
  try {
    int roundedResult = 100 ~/ 2;
    print(roundedResult);

    double value1 = double.parse('50.2a');
    // throws exception
    print(value1);

    double? value2 = double.tryParse('50.2a');
    // no exception thrown, returns null
    print(value2);
  } on FormatException catch (e) {
    print('>> ${e.message}');
  } on UnsupportedError {
    print('>> UnsuportedError');
  } catch (e) {
    print(e);
  } finally {
    print('End');
  }
}
