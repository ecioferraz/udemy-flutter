import 'PeopleRemoteRepository.dart';

void main() {
  PeopleRemoteRepository remoteRepository = PeopleRemoteRepository();

  remoteRepository.add('name');
  remoteRepository.read(1);
  remoteRepository.delete(1);
  remoteRepository.deleteAll();
}
