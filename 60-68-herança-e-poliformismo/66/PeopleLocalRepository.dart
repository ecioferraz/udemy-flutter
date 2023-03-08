import 'PeopleRepository.dart';

class PeopleLocalRepository implements PeopleRepository {
  @override
  String read(int i) {
    return 'Daniel';
  }

  @override
  void add(String name) {}

  @override
  void delete(int i) {}

  @override
  void deleteAll() {}
}
