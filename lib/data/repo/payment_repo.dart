import '../api/api_client.dart';

class PaymentRepo {
  final ApiClient apiClient;

  PaymentRepo({required this.apiClient});

  // Future<Response> mBankInitialize(String id, String phone, String comment, String type) async {
  //   return await apiClient.postData(AppConstants.mBankInitializeUrl,
  //       {
  //         "order_id": id,
  //         "phone": phone,
  //         "type": type,
  //       });
  // }

  // Future<Response> megaPayCheck(String id, String phone, String type) async {

  //   return await apiClient.postData( AppConstants.megaPayCheckUrl,
  //       {
  //         "order_id": id,
  //         "user": phone,
  //         "type": type,
  //       });
  // }

  // Future<Response> megaPay(String id, String phone, String pin, String type) async {
  //   return await apiClient.postData(AppConstants.megaPayUrl,
  //       {
  //         "order_id": id,
  //         "user": phone,
  //         "pinCode": pin,
  //         "type": type,
  //       });
  // }

  // Future<Response> confirmMbank(String id, String qId, String otp, String type) async {

  //   return await apiClient.postData(AppConstants.mBankConfirmUrl,
  //       {
  //         "order_id": id,
  //         "quid": qId,
  //         "otp": otp,
  //         "type": type,
  //       });
  // }

  // Future<Response> initializeFiniPay({required String orderId, required String type}) async {
  //   return await apiClient.postData(AppConstants.finipayInitialize,
  //       {
  //         "order_id":  orderId,
  //         "type": type
  //       },);
  // }
}
