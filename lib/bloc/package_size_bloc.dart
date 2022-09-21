import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/package_size_model.dart';
import 'package:rxdart/rxdart.dart';

class PackageSizebloc {
  final _packagesize = PublishSubject<PackageSizeModel>();
  final _repository = Repository();

  Stream<PackageSizeModel> get getpackagesizestream => _packagesize.stream;

  Future getPackageIndexsink(String category, String lang) async {
    final PackageSizeModel model =
        await _repository.onpackagesize(category, lang);
    _packagesize.sink.add(model);
  }

  void dispose() {
    _packagesize.close();
  }
}

final packageSizebloc = PackageSizebloc();
