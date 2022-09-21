import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/get_fuel_model.dart';
import 'package:rxdart/rxdart.dart';

class Getfuelbloc {
  final _getyfuel = PublishSubject<GetFuelModel>();
  final _repository = Repository();

  Stream<GetFuelModel> get getFuelstream => _getyfuel.stream;

  Future getFuelsink(String lang) async {
    final GetFuelModel Model = await _repository.ongetfuelApi(lang);
    _getyfuel.sink.add(Model);
  }

  void dispose() {
    _getyfuel.close();
  }
}

final getfuelbloc = Getfuelbloc();
