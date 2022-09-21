import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/order_details_model.dart';
import 'package:famous_steam_user/model/order_status_model.dart';
import 'package:rxdart/rxdart.dart';

class OrderDetailsbloc {
  final _orderDetails = PublishSubject<OrderDetailsModel>();
  final _repository = Repository();

  Stream<OrderDetailsModel> get oderstatustream => _orderDetails.stream;

  Future oderdetailssink(String lang, String orderid) async {
    final OrderDetailsModel model =
        await _repository.onorderdetailsApi(lang, orderid);
    _orderDetails.sink.add(model);
  }

  void dispose() {
    _orderDetails.close();
  }
}

final orderDetailsbloc = OrderDetailsbloc();
