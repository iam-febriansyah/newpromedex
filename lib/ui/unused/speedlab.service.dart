// import 'dart:convert';

// import 'package:galeri_teknologi_bersama/data/model/paymentrequest.dart';
// import 'package:galeri_teknologi_bersama/data/model/paymentresponse.dart';
// import 'package:galeri_teknologi_bersama/data/model/paymentstatus.dart';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static final String _baseUrl = 'https://production.speedpay.id/Transactions';
//   static final String _apiKey = "";

//   Future<PaymentResponse> progressOrder(
//     Transaction transactions,
//     List<ItemOrder> transactionDetails,
//   ) async {
//     Map data = {
//       "transactions": transactions,
//       "transaction_details": transactionDetails
//     };

//     var body = jsonEncode(data);

//     final response = await http.post(
//       Uri.parse(_baseUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization':
//             "\$2y\$10\$t522ktm1HC8bEgY9.5rSp.iPvG0MXVnJ/ur7VdMgNzZpLr4s6QV06",
//       },
//       body: body,
//     );

//     if (response.statusCode == 200) {
//       PaymentStatus paymentStatus =
//           PaymentStatus.fromJson(json.decode(response.body));
//       if (paymentStatus.statusJson == true) {
//         print("response 200 , succes");
//         return PaymentResponse.fromJson(json.decode(response.body));
//       } else {
//         print("response 200 , failed");
//         print(response.body);
//         throw Exception('Failed to post');
//       }
//     } else {
//       print('Failed to post');
//       throw Exception('Failed to post');
//     }
//   }
// }
