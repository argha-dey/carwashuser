import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/notification_model.dart';
import 'package:rxdart/rxdart.dart';

class Notificationbloc {
  final _notification = PublishSubject<NotificationModel>();
  final _repository = Repository();

  Stream<NotificationModel> get notificationstream => _notification.stream;

  Future notificationsink() async {
    final NotificationModel Model = await _repository.notification();
    _notification.sink.add(Model);
  }

  void dispose() {
    _notification.close();
  }
}

final notificationbloc = Notificationbloc();
