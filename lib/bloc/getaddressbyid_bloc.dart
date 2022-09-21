import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/get_address_by_id_model.dart';
import 'package:rxdart/rxdart.dart';

class Getadderssbyidbloc {
  final _getaddressbyidslot = PublishSubject<GetaddressbyidModel>();
  final _repository = Repository();

  Stream<GetaddressbyidModel> get getaddresbyidstream =>
      _getaddressbyidslot.stream;

  Future getaddressbyidsink(String day) async {
    final GetaddressbyidModel Model = await _repository.ongetaddressbyid();
    _getaddressbyidslot.sink.add(Model);
  }

  void dispose() {
    _getaddressbyidslot.close();
  }
}

final getadderssbyidbloc = Getadderssbyidbloc();
