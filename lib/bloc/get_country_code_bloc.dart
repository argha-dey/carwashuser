/*
import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/get_country_code_model.dart';
import 'package:rxdart/rxdart.dart';

class Getcountrycodebloc {
  final _getcountrycode = PublishSubject<GetcountrycodeModel>();
  final _repository = Repository();

  Stream<GetcountrycodeModel> get getcountrycodestream => _getcountrycode.stream;

  Future getcountrycodesink() async {
    final GetcountrycodeModel Model = await _repository.getcountrycode();
    _getcountrycode.sink.add(Model);
  }

  void dispose() {
    _getcountrycode.close();
  }
}

final getcountrycodebloc = Getcountrycodebloc();
*/
