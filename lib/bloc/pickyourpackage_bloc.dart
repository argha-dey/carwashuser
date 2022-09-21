import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/pick_your_package_model.dart';
import 'package:rxdart/rxdart.dart';

class Pickyourpackagebloc {
  final _pickyourpackage = PublishSubject<PickyourpackageModel>();
  final _repository = Repository();

  Stream<PickyourpackageModel> get pickyourpackagestream => _pickyourpackage.stream;

  Future pickyourpackagesink(String lang, String categoryid) async {
    final PickyourpackageModel Model =
        await _repository.pickyourpackage(lang, categoryid);
    _pickyourpackage.sink.add(Model);
  }

  void dispose() {
    _pickyourpackage.close();
  }
}

final pickyourpackagebloc = Pickyourpackagebloc();
