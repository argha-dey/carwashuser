import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/model/SummeryModel.dart';
import 'package:famous_steam_user/model/get_address_model.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:rxdart/rxdart.dart';

class Getsummarybloc {
  final _getSummary = PublishSubject<SummeryModel>();
  final _repository = Repository();

  Stream<SummeryModel> get getsummarytream => _getSummary.stream;

  Future getSummarySink(
      PackageData selectedPackageData,
      List<ServiceListData> selectedExtraServiceData,
      VehicleDetails selectedvahicleDetails,
      String slotTime,
      String slotDate,
      String addressId,
      ) async {
    final SummeryModel model = await _repository.onSummaryDetailsApi(
      selectedPackageData,
      selectedExtraServiceData,
      selectedvahicleDetails,
      slotTime,
      slotDate,
      addressId,
    );
    _getSummary.sink.add(model);
  }

  void dispose() {
    _getSummary.close();
  }
}

final getsummarybloc = Getsummarybloc();
