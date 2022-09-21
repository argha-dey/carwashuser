import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/get_package_model.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:rxdart/rxdart.dart';

class Getpackagebloc {
  final _getpackageslot = PublishSubject<PackageIndexModel>();
  final _repository = Repository();

  Stream<PackageIndexModel> get getpackagestream => _getpackageslot.stream;

  Future getpackagesink(String lang, String categoryid,String carSizeId) async {
    final PackageIndexModel Model =
        await _repository.ongetpackage(lang, categoryid,carSizeId);
    _getpackageslot.sink.add(Model);
  }

  void dispose() {
    _getpackageslot.close();
  }
}

final getpackagebloc = Getpackagebloc();
