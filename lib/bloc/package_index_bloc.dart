import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:rxdart/rxdart.dart';

class PackageIndexbloc {
  final _packageIndex = PublishSubject<PackageIndexModel>();
  final _repository = Repository();

  Stream<PackageIndexModel> get getPackageIndexstream => _packageIndex.stream;

  Future getPackageIndexsink(String lang,String catId,String carSizeId) async {
    final PackageIndexModel model = await _repository.onPackageIndex(lang,catId,carSizeId);
    _packageIndex.sink.add(model);
  }

  void dispose() {
    _packageIndex.close();
  }
}

final packageindexbloc = PackageIndexbloc();
