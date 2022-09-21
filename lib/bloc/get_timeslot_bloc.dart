import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/get_timeslot_model.dart';
import 'package:rxdart/rxdart.dart';

class Gettimeslotbloc {
  final _gettimeslot = PublishSubject<GettimeslotModel>();
  final _repository = Repository();

  Stream<GettimeslotModel> get getuserstream => _gettimeslot.stream;

  Future gettimeslotsink(String day,date) async {
    final GettimeslotModel Model = await _repository.ongettimeslotApi(day,date);
    _gettimeslot.sink.add(Model);
  }

  void dispose() {
    _gettimeslot.close();
  }
}

final gettimeslotbloc = Gettimeslotbloc();
