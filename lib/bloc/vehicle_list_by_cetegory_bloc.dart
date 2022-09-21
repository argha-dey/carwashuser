import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/vehicle_list_by_cetegory_model.dart';
import 'package:rxdart/rxdart.dart';

class Vehiclelbrandlistbycategorybloc {
  final _vehiclelistbycategory = PublishSubject<VehiclelbrandlistbycategoryModel>();
  final _repository = Repository();

  Stream<VehiclelbrandlistbycategoryModel> get vehiclelistbycategorystream =>
      _vehiclelistbycategory.stream;

  Future vehiclelbrandlistbycategorysink(String lang,String catid) async {
    final VehiclelbrandlistbycategoryModel Model = await _repository.vehiclelbrandlistbycategory(lang, catid);
    _vehiclelistbycategory.sink.add(Model);
  }

  void dispose() {
    _vehiclelistbycategory.close();
  }
}

final vehiclelbrandlistbycategorybloc = Vehiclelbrandlistbycategorybloc();
