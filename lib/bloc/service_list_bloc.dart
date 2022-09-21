import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:rxdart/rxdart.dart';

import '../model/service_list_model.dart';

class ServiceListBloc {
  final _serviceList = PublishSubject<ServiceListModel>();
  final _repository = Repository();

  Stream<ServiceListModel> get serviceListStream => _serviceList.stream;

  Future serviceListSink(String categoryId,String sizeId,String packageId) async {
    final ServiceListModel Model = await _repository.onservicelist(categoryId,sizeId,packageId);
    _serviceList.sink.add(Model);
  }

  void dispose() {
    _serviceList.close();
  }
}

final serviceListBloc = ServiceListBloc();
