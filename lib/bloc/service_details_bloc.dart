import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/service_details_model.dart';
import 'package:rxdart/rxdart.dart';

class Servicedetailsbloc {
  final _servicedetails = PublishSubject<ServicedetailsModel>();
  final _repository = Repository();

  Stream<ServicedetailsModel> get servicedetailsstream =>
      _servicedetails.stream;

  Future servicedetailssink(String lang, String id) async {
    final ServicedetailsModel Model =
        await _repository.servicedetails(lang, id);
    _servicedetails.sink.add(Model);
  }

  void dispose() {
    _servicedetails.close();
  }
}

final servicedetailsbloc = Servicedetailsbloc();
