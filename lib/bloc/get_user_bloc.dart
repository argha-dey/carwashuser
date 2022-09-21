import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/get_user_model.dart';
import 'package:rxdart/rxdart.dart';

class Getuserbloc {
  final _getuser = PublishSubject<GetuserModel>();
  final _repository = Repository();

  Stream<GetuserModel> get getuserstream => _getuser.stream;

  Future getusersink() async {
    final GetuserModel Model = await _repository.ongetuserApi();
    _getuser.sink.add(Model);
  }

  void dispose() {
    _getuser.close();
  }
}

final getuserbloc = Getuserbloc();
  