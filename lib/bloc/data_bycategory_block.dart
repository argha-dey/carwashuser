import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/data_bycategory_model.dart';
import 'package:rxdart/rxdart.dart';

class Databycategorybloc {
  final _databycategory = PublishSubject<DatabycategoryModel>();
  final _repository = Repository();

  Stream<DatabycategoryModel> get databycategorystream => _databycategory.stream;

  Future databycategorystreamsink(String categoryid, String lang) async {
    final DatabycategoryModel Model =
        await _repository.ondatabycategoryApi(categoryid, lang);
    _databycategory.sink.add(Model);
  }

  void dispose() {
    _databycategory.close();
  }
}

final databycategorybloc = Databycategorybloc();
