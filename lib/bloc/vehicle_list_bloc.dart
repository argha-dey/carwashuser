import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:rxdart/rxdart.dart';

class VehicleListbloc {
  final _vehiclelist = PublishSubject<VehicleListModel>();
  final _repository = Repository();

  Stream<VehicleListModel> get vehicleliststream => _vehiclelist.stream;

  Future categorylistsink(String lang) async {
    final VehicleListModel Model = await _repository.ongetvehiclelistApi(lang);
    _vehiclelist.sink.add(Model);
  }

  void dispose() {
    _vehiclelist.close();
  }
}

final vehicleListbloc = VehicleListbloc();
