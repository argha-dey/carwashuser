import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/model_list_by_brand.dart';
import 'package:famous_steam_user/model/size_list_by_model.dart';
import 'package:famous_steam_user/model/vehicle_list_by_cetegory_model.dart';
import 'package:rxdart/rxdart.dart';

class VehiclelSizelistbyModelbloc {
  final _sizelistbymodel = PublishSubject<VehiclelsizelistbybrandModel>();
  final _repository = Repository();

  Stream<VehiclelsizelistbybrandModel> get vehiclesizelistbymodelstream =>
      _sizelistbymodel.stream;

  Future vehiclelsizelistbymodelsink(String lang,category_id, brand_id, modelId) async {
    final VehiclelsizelistbybrandModel Model = await _repository.vehiclelSizelistbyModel(lang, category_id, brand_id, modelId);
    _sizelistbymodel.sink.add(Model);
  }

  void dispose() {
    _sizelistbymodel.close();
  }
}

final vehiclelsizelistbymodelbloc = VehiclelSizelistbyModelbloc();
