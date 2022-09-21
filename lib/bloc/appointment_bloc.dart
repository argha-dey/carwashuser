import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/model/SummeryModel.dart';
import 'package:famous_steam_user/model/appointment_model.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/payment_method_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:rxdart/rxdart.dart';

class Appointementbloc {
  final _appointmentslot = PublishSubject<AppointmentModel>();
  final _repository = Repository();

  Stream<AppointmentModel> get getappointmentstream => _appointmentslot.stream;

  Future getappointmentsink(
      PackageData selectedPackageData,
      List<ServiceListData> selectedExtraServiceData,
      VehicleDetails selectedvahicleDetails,
      String slotTime,
      String slotDate,
      String addressId,
       String  address,
      SummeryModel summeryData,
      Paymentmethod  selectPaymentMode,
      String paymentId
      ) async {
    final AppointmentModel Model = await _repository.onappointment(

        selectedPackageData,
        selectedExtraServiceData,
        selectedvahicleDetails,
        slotTime,
        slotDate,
        addressId,
        address,
        summeryData,
        selectPaymentMode,
        paymentId

    );
    _appointmentslot.sink.add(Model);
  }

  void dispose() {
    _appointmentslot.close();
  }
}

final appointementbloc = Appointementbloc();
