import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/payment_method_model.dart';
import 'package:rxdart/rxdart.dart';

class Paymentmethodbloc {
  final _paymentmethod = PublishSubject<PaymentmethodModel>();
  final _repository = Repository();

  Stream<PaymentmethodModel> get paymentmethodstream => _paymentmethod.stream;

  Future paymentmethodsink(String lang) async {
    final PaymentmethodModel Model = await _repository.paymentmethod(lang);
    _paymentmethod.sink.add(Model);
  }

  void dispose() {
    _paymentmethod.close();
  }
}

final paymentmethodbloc = Paymentmethodbloc();
