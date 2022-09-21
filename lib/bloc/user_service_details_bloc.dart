import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/user_service_details_model.dart';
import 'package:rxdart/rxdart.dart';

class Userservicedetailsbloc {
  final _userservicedetails = PublishSubject<UserservicedetailsModel>();
  final _repository = Repository();

  Stream<UserservicedetailsModel> get userservicedetailsstream =>
      _userservicedetails.stream;

  Future userservicedetailssink(String lang, String oderid) async {
    final UserservicedetailsModel Model =
        await _repository.userservicedetails(lang, oderid);
    _userservicedetails.sink.add(Model);
  }

  void dispose() {
    _userservicedetails.close();
  }
}

final userservicedetailsbloc = Userservicedetailsbloc();
