import 'package:famous_steam_user/const/global.dart';
import 'package:famous_steam_user/homePage.dart';
import 'package:famous_steam_user/model/SummeryModel.dart';
import 'package:famous_steam_user/model/package_index_model.dart';
import 'package:famous_steam_user/model/payment_method_model.dart';
import 'package:famous_steam_user/model/vehicle_list_model.dart';
import 'package:famous_steam_user/provider/VehicleYearlistbyModelApi.dart';
import 'package:famous_steam_user/provider/add_adress_provider.dart';
import 'package:famous_steam_user/provider/add_vehicle_provider.dart';
import 'package:famous_steam_user/provider/appointment_provider.dart';
import 'package:famous_steam_user/provider/booking_history_provider.dart';
import 'package:famous_steam_user/provider/category_list_provider.dart';
import 'package:famous_steam_user/provider/data_bycategory_provider.dart';
import 'package:famous_steam_user/provider/edit_address_provider.dart';
import 'package:famous_steam_user/provider/edit_billing_address_provider.dart';
import 'package:famous_steam_user/provider/get_otp_provider.dart';
import 'package:famous_steam_user/provider/get_fuel_provider.dart';
import 'package:famous_steam_user/provider/get_summary_data_provider.dart';
import 'package:famous_steam_user/provider/get_timeslot_provider.dart';
import 'package:famous_steam_user/provider/get_user_provider.dart';
import 'package:famous_steam_user/provider/get_address_provider.dart';
import 'package:famous_steam_user/provider/get_address_by_id_provider.dart';
import 'package:famous_steam_user/provider/get_billing_address_provider.dart';
import 'package:famous_steam_user/provider/get_package_provider.dart';
import 'package:famous_steam_user/provider/langauge_select_provider.dart';
import 'package:famous_steam_user/provider/notification_provider.dart';
import 'package:famous_steam_user/provider/order_details_provider.dart';
import 'package:famous_steam_user/provider/order_status_provider.dart';
import 'package:famous_steam_user/provider/package_index_provider.dart';
import 'package:famous_steam_user/provider/package_size_provider.dart';
import 'package:famous_steam_user/provider/paymets_status_provider.dart';
import 'package:famous_steam_user/provider/pick_your_package_provider.dart';
import 'package:famous_steam_user/provider/register_provider.dart';
import 'package:famous_steam_user/provider/search_result_provider.dart';
import 'package:famous_steam_user/provider/send_otp_provider.dart';
import 'package:famous_steam_user/provider/service_details_provider.dart';
import 'package:famous_steam_user/provider/service_list_provider.dart';
import 'package:famous_steam_user/provider/star_rating_feedback_provider.dart';
import 'package:famous_steam_user/provider/user_service_details_provider.dart';
import 'package:famous_steam_user/provider/vehicle_list_by_cetegory_provider.dart';
import 'package:famous_steam_user/provider/vehicle_list_provider.dart';
import 'package:geocoding/geocoding.dart';

import '../provider/delete_vehicle_provider.dart';
import '../provider/get_country_code_provider.dart';
import '../provider/model_list_by_brand_provider.dart';
import '../provider/payment_method_provider.dart';
import '../provider/size_list_by_model_provider.dart';

class Repository {



  /*
         'first_name' => 'required',
            'last_name' => 'required',
            'email' => 'required|email|unique:users',
            'country_code' => 'required',
            'mobile' => 'required|unique:users|numeric',
            'add_line1' => 'required',
            'add_line2' => 'required',
            'city' => 'required',
            'landmark' => 'required',
            'zipcode' => 'required',*/

  //=================== Register  ===================
  final RegisterApi register = RegisterApi();
  Future<dynamic> onRegister(
      String name,
      String lastname,
      String email,
      String countrycode,
      String mbl,
      String addline1,
      String addline2,
      String city,
      String landmark,
      String zipcode,
      String lat,
      String lng,
      Placemark lookup,
      ) =>
      register.onRegisterAPI(
        name,
        lastname,
        email,
        countrycode,
        mbl,
        addline1,
        addline2,
        city,
        landmark,
        zipcode,
        lat,
        lng,
          lookup,
      );

  //=================== Add ADDRESS API  ===================
  final AddAddressApi addAddressApi = AddAddressApi();
  Future<dynamic> onAddAddress(String addline, String lat, String lang,
      String landmark, String zip,   Placemark lookup,) =>
      addAddressApi.onAddAddressApi(addline, lat, lang, landmark, zip,lookup);

  //=================== OTP Verify  ===================
  final OtpVerifyApi otpVerify = OtpVerifyApi();
  Future<dynamic> onVerifyotpAPI(String mobile,String otp,String token_device_token) => otpVerify.onOtpVerifyApi(mobile,otp,token_device_token);



  //=================== Send OTP  ===================
  final SendOTPApi sendOTPApi = SendOTPApi();
  Future<dynamic> onSendOTP(String mobile) => sendOTPApi.onSendOTPApi(mobile);



  //=================== CATEGORY LIST API  ===================
  final CategorylistApi categorylist = CategorylistApi();
  Future<dynamic> oncategorylistApi(String lang) =>
      categorylist.oncategorylistApi(lang);

  //=================== GET FUEL API  ===================
  final GetfuelApi getfuelApi = GetfuelApi();
  Future<dynamic> ongetfuelApi(String lang) => getfuelApi.ongetfuelApi(lang);

  //=================== DATABY CATEGORY API  ===================
  final DatabycategoryApi databycategoryApi = DatabycategoryApi();
  Future<dynamic> ondatabycategoryApi(String categoryid, String lang) =>
      databycategoryApi.ondatabycategoryApi(categoryid, lang);





  //=================== GET USER API  ===================
  final GetuserApi getuserApi = GetuserApi();
  Future<dynamic> ongetuserApi() => getuserApi.ongetuserApi();

  //=================== GET TIMES API  ===================
  final GettimeslotApi gettimeslotApi = GettimeslotApi();
  Future<dynamic> ongettimeslotApi(String day, date) =>
      gettimeslotApi.ongettimeslotApi(day, date);

  //=================== ADD VEHICLE API  ===================
  final AddvehicleApi addvehicleApi = AddvehicleApi();

  Future<dynamic> onaddvehicleApi(
      String categoryid,
      String fuelid,
      String sizeid,
      String brandid,
      ScreenType screenType,
      String vehicleId,
      String modelId,
      String yearId
      ) =>
      addvehicleApi.onaddvehicleApi(
          categoryid, fuelid, sizeid, brandid, screenType, vehicleId,modelId,yearId);

  //=================== GET ADDRESS API ===================
  final GetaddressApi getaddressApi = GetaddressApi();
  Future<dynamic> ongetaddressApi() => getaddressApi.ongetaddressApi();

  //=================== EDIT BILLING ADDRESS API ===================
  final EditbillingaddressApi editbillingaddressApi = EditbillingaddressApi();
  Future<dynamic> ongetaddress() =>
      editbillingaddressApi.oneditbillingaddressApi();

  //=================== GET BILLING ADDRESS API ===================
  final GetbillingaddressApi getbillingaddressApi = GetbillingaddressApi();
  Future<dynamic> ongetbillingaddress() =>
      getbillingaddressApi.ongetbillingaddressApi();

  //=================== GET ADDRESS BY ID API ===================
  final GetaddressbyidApi getaddressbyidApi = GetaddressbyidApi();
  Future<dynamic> ongetaddressbyid() => getaddressbyidApi.ongetaddressbyidApi();

  //=================== APPOINTMENT API ===================
  final AppointmentApi appointmentApi = AppointmentApi();
  Future<dynamic> onappointment(

      PackageData selectedPackageData,
      List<ServiceListData> selectedExtraServiceData,
      VehicleDetails selectedvahicleDetails,
      String slotTime,
      String slotDate,
      String addressId,
      String address,
      SummeryModel summeryData,
      Paymentmethod  selectPaymentMode,
      String paymentId
      ) =>

      appointmentApi.onappointmentApi(
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

  //=================== GET PACKAGE API ===================
  final GetpakageApi getpakageApi = GetpakageApi();
  Future<dynamic> ongetpackage(String lang, String catId,String carSizeId) =>
      getpakageApi.ongetpakegeApi(lang, catId, carSizeId);

  //=================== VEHICLE LIST API  ===================
  final VehiclelistApi vehicleistApi = VehiclelistApi();
  Future<dynamic> ongetvehiclelistApi(String catId) =>
      vehicleistApi.onvehiclelistApi(catId);

  //=================== Edit ADDRESS API  ===================
  final EditAddressApi editAddressApi = EditAddressApi();
  Future<dynamic> onEditAddress(String addressid, String addline1,
      String addline2, String city, String landmark, String zip,String lat,String lng) =>
      editAddressApi.onEditAddressApi(
          addressid, addline1, addline2, city, landmark, zip,lat,lng);

  //=================== BOOKING HISTORY API  ===================
  final BookinghistoryApi bookinghistoryApi = BookinghistoryApi();
  Future<dynamic> bookinghistory(String type,String startDate,String endDate) => bookinghistoryApi.onbookinghistoryApi(type,startDate,endDate);
  //=================== Star Rating API  ===================
  final StarRatingFeedbackApi starRatingFeedbackApi = StarRatingFeedbackApi();
  Future<dynamic> onStarRating(
      String ratingstar, String orderid, String ratingreview,String modelId) =>
      starRatingFeedbackApi.onStarRatingFeedbackApi(
        ratingstar,
        orderid,
        ratingreview,
        modelId,
      );

  //=================== PICK YOUR PACKAGE API ===================
  final PickyourpackageApi pickyourpackageApi = PickyourpackageApi();
  Future<dynamic> pickyourpackage(String lang, String categoryid) =>
      pickyourpackageApi.onpickyourpackageApi(lang, categoryid);

  //=================== Order Status API  ===================
  Future<dynamic> onorderstatusApi(String lang, String orderid) =>
      orderStatusApi.onorderstatusApi(lang, orderid);

  //=================== Order Details API  ===================
  Future<dynamic> onorderdetailsApi(String lang, String orderid) =>
      orderDetailsApi.onorderdetailsApi(lang, orderid);

  //=================== Search Result API  ===================
  final SearchResultApi searchResultApi = SearchResultApi();
  Future<dynamic> onsearchResultApi(String keyword, String lang) =>
      searchResultApi.onsearchResultApi(keyword, lang);
  //=================== Package Index API  ===================
  final PackageIndexApi packageindex = PackageIndexApi();
  Future<dynamic> onPackageIndex(String lang,String catId,String carSizeId) =>
      packageindex.onPackageIndexApi(lang,catId,carSizeId);

  //=================== DELETE VEHICLE API  ===================
  final DeletevehicleApi deletevehicleApi = DeletevehicleApi();
  Future<dynamic> ondeletvehicle(String vehicleid) =>
      deletevehicleApi.ondeletevehicleApi(vehicleid);

  //=================== PAYMENT METHOD API  ===================
  final PaymentmethodApi paymentmethodApi = PaymentmethodApi();
  Future<dynamic> paymentmethod(String lang) =>
      paymentmethodApi.onpaymentmethodApi(lang);


/*

  //=================== Langauege Select API  ===================
  final LangauageSelectApi langauageSelectApi = LangauageSelectApi();
  Future<dynamic> languasemethod() => langauageSelectApi.onlangauageselectApi();

*/



/*

 //=================== GET COUNTRY CODE API  ===================
  final GetcountrycodeApi getcountrycodeApi = GetcountrycodeApi();
  Future<dynamic> getcountrycode() => getcountrycodeApi.ongetcountrycodeApi();


  */

  //=================== SERVICE DETAILS API  ===================
  final ServicedetailsApi servicedetailsApi = ServicedetailsApi();
  Future<dynamic> servicedetails(String lang, String id) =>
      servicedetailsApi.onservicedetailsApi(lang, id);

  //=================== USER SERVICE DETAILS API  ===================
  final UserservicedetailsApi userservicedetailsApi = UserservicedetailsApi();
  Future<dynamic> userservicedetails(String lang, String orderid) =>
      userservicedetailsApi.onuserservicedetailsApi(lang, orderid);

  //=================== VEHICLE LIST BY CAREGORY API  ===================
  final VehiclelbrandlistbycategoryApi vehiclelbrandlistbycategoryApi =
  VehiclelbrandlistbycategoryApi();
  Future<dynamic> vehiclelbrandlistbycategory(
      String lang,
      String catid,
      ) =>
      vehiclelbrandlistbycategoryApi.onvehiclebrandlistbycategoryApi(lang, catid);





  //=================== Model LIST BY Brand API  ===================
  final VehiclelModellistbyBrandApi vehiclelModellistbyBrandApi = VehiclelModellistbyBrandApi();
  Future<dynamic> vehiclelModellistbyBrand(
      String lang,
      String brandId,
      String catogaryId
      ) =>
      vehiclelModellistbyBrandApi.onvehicleModellistbyBrandApi(lang, catogaryId,brandId);



  //=================== size LIST BY Car Model API  ===================
  final VehiclelSizelistbyModelApi vehiclelSizelistbyModelApi = VehiclelSizelistbyModelApi();
  Future<dynamic> vehiclelSizelistbyModel(
      String lang,
      String category_id,
      String brand_id,
      String modelId,
      ) =>
      vehiclelSizelistbyModelApi.onvehicleSizelistbyModelApi(lang,  category_id, brand_id, modelId);


  //=================== year LIST BY size Model API  ===================
  final VehiclelYearlistbySizeApi vehiclelYearlistbySizeApi = VehiclelYearlistbySizeApi();
  Future<dynamic> vehiclelYearlistbySize(
      String lang,
      String category_id,
      String brand_id,
      String modelId,
      String sizeId,
      ) =>
      vehiclelYearlistbySizeApi.onvehicleYearlistbySizeApi(lang,  category_id, brand_id, modelId,sizeId);


  //=================== NOTIFICATION API  ===================
  final NotificationApi notificationApi = NotificationApi();
  Future<dynamic> notification() => notificationApi.onnotificationApi();

  //=================== Paymnetstatus API  ===================
  final Paymentstatusapi paymentstatusapi = Paymentstatusapi();
  Future<dynamic> paymentsstatus(String invoice_id, String id) =>
      paymentstatusapi.ongetpaymentstatusApi(invoice_id, id);

  //=================== PACKAGE SIZE API ===================
  final PackageSizeApi packageSizeApi = PackageSizeApi();
  Future<dynamic> onpackagesize(String category, String lang) =>
      packageSizeApi.onpackagesizeApi(category, lang);


  //===================SERVICE LIST API  ===================
  final ServiceListApi serviceListApi = ServiceListApi();
  Future<dynamic> onservicelist(String categoryId, String sizeId,String packageId) =>
      serviceListApi.onServicedListApi(categoryId,sizeId,packageId);



  //===========Summary Details Api =========//
  final GetSummaryApi getSummaryApi = GetSummaryApi();
  Future<dynamic> onSummaryDetailsApi(

      PackageData selectedPackageData,
      List<ServiceListData> selectedExtraServiceData,
      VehicleDetails selectedvahicleDetails,
      String slotTime,
      String slotDate,
      String addressId,
      ) =>
      getSummaryApi.onGetSummaryApi(selectedPackageData,selectedExtraServiceData, selectedvahicleDetails, slotTime,slotDate, addressId);
}


