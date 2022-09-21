import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/get_address_model.dart';
import 'package:rxdart/rxdart.dart';

class Getadderssbloc {
  final _geaddresslot = PublishSubject<GetaddressModel>();
  final _repository = Repository();

  Stream<GetaddressModel> get getaddresstream => _geaddresslot.stream;

  Future getaddresssink() async {
    final GetaddressModel model = await _repository.ongetaddressApi();
    _geaddresslot.sink.add(model);
  }

  void dispose() {
    _geaddresslot.close();
  }
}

final getadderssbloc = Getadderssbloc();
