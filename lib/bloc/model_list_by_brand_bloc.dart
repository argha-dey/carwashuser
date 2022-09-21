import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/model_list_by_brand.dart';
import 'package:famous_steam_user/model/vehicle_list_by_cetegory_model.dart';
import 'package:rxdart/rxdart.dart';

class VehiclelModellistbyBrandbloc {
  final _modellistbybrand = PublishSubject<VehiclelmodellistbybrandModel>();
  final _repository = Repository();

  Stream<VehiclelmodellistbybrandModel> get vehiclemodellistbybrandstream =>
      _modellistbybrand.stream;

  Future vehiclelmodellistbybrandsink(String lang,String catogaryId,String brandId) async {
    final VehiclelmodellistbybrandModel Model = await _repository.vehiclelModellistbyBrand(lang,catogaryId,brandId);
    _modellistbybrand.sink.add(Model);
  }

  void dispose() {
    _modellistbybrand.close();
  }
}

final vehiclelmodellistbybrandbloc = VehiclelModellistbyBrandbloc();
