import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/booking_history_model.dart';
import 'package:rxdart/rxdart.dart';

class Bookinghistorybloc {
  final _bookinghistory = PublishSubject<BookinghistoryModel>();
  final _repository = Repository();

  Stream<BookinghistoryModel> get bookinghistorystream =>
      _bookinghistory.stream;

  Future bookinghistorysink(String type,String startDate,String endDate) async {
    final BookinghistoryModel model = await _repository.bookinghistory(type,startDate,endDate);
    _bookinghistory.sink.add(model);
  }

  void dispose() {
    _bookinghistory.close();
  }
}

final bookinghistorybloc = Bookinghistorybloc();
