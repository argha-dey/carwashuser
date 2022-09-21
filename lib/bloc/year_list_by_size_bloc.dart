import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/model_list_by_brand.dart';
import 'package:famous_steam_user/model/size_list_by_model.dart';
import 'package:famous_steam_user/model/vehicle_list_by_cetegory_model.dart';
import 'package:famous_steam_user/model/year_list_data_model.dart';
import 'package:rxdart/rxdart.dart';

class VehiclelYearlistbySizebloc {
  final _listbymodel = PublishSubject<YearListDataModel>();
  final _repository = Repository();

  Stream<YearListDataModel> get vehiclesizelistbymodelstream =>
      _listbymodel.stream;

  Future vehiclelYearlistbySizesink(String lang,category_id, brand_id, modelId,sizeId) async {
    final YearListDataModel Model = await _repository.vehiclelYearlistbySize(lang, category_id, brand_id, modelId,sizeId);
    _listbymodel.sink.add(Model);
  }

  void dispose() {
    _listbymodel.close();
  }
}

final vehiclelyearlistbysizebloc = VehiclelYearlistbySizebloc();
