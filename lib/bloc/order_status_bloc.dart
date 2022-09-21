import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/order_status_model.dart';
import 'package:rxdart/rxdart.dart';

class OrderStatusbloc {
  final _orderStatus = PublishSubject<OrderStatusModel>();
  final _repository = Repository();

  Stream<OrderStatusModel> get oderstatustream => _orderStatus.stream;

  Future oderstatussink(String lang, String orderid) async {
    final OrderStatusModel model =
        await _repository.onorderstatusApi(lang, orderid);
    _orderStatus.sink.add(model);
  }

  void dispose() {
    _orderStatus.close();
  }
}

final orderStatusbloc = OrderStatusbloc();
