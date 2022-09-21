import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/get_billing_address_model.dart';
import 'package:rxdart/rxdart.dart';

class Getbillingaddressbloc {
  final _getbillingaddressslot = PublishSubject<GetbillingaddressModel>();
  final _repository = Repository();

  Stream<GetbillingaddressModel> get getbillingaddressstream =>
      _getbillingaddressslot.stream;

  Future getbillingaddresssink(String day) async {
    final GetbillingaddressModel Model =
        await _repository.ongetbillingaddress();
    _getbillingaddressslot.sink.add(Model);
  }

  void dispose() {
    _getbillingaddressslot.close();
  }
}

final getbillingaddressbloc = Getbillingaddressbloc();
