import 'dart:convert' as convert;
import 'dart:convert';

import 'package:carpool/app/api_constance.dart';
import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/data/models/models.dart';
import 'package:http/http.dart';

abstract class RemoteDataSource {
  //----------------------------------------------------- CLIENT -----------------------------------------------------
  Future<ClientModel> clientLogin(String phoneNumber, String password);
  Future<ClientModel> clientRegister(ClientModel client);
  Future<List<TravelModel>> getTravel(String placeOfDeparture, String placeOfArrival);
  Future<ClientModel> getClientById(String id);
  Future<void> requestToBook(String travelId);

  //----------------------------------------------------- DRIVER -----------------------------------------------------
  Future<DriverModel> driverLogin(String phoneNumber, String password);
  Future<DriverModel> driverRegister(DriverModel driver);
  Future<DriverModel> getDriverById(String id);
  Future<void> createTravel(TravelModel travelModel);

  //----------------------------------------------------- ADMIN -----------------------------------------------------
  Future<AdminModel> adminLogin(String phoneNumber, String password);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final AppPrefences _appPrefences = AppPrefences(getIt());

  //----------------------------------------------------- CLIENT -----------------------------------------------------

  @override
  Future<ClientModel> clientLogin(String phoneNumber, String password) async {
    final url = Uri.parse("${ApiConstance.clientBaseUrl}login");
    final headers = {
      "Content-Type": ApiConstance.contentType,
    };
    final json = {
      "phoneNumber": phoneNumber,
      "password": password,
    };
    final Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ LOGIN SUCCESS ✅');
      print("🔥🌟${response.body}");
      var x = ClientModel.fromJson(response.body);
      print("😎😎 $x");
      return x;
    } else {
      print('🛑 LOGIN FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }

  @override
  Future<ClientModel> clientRegister(ClientModel client) async {
    final url = Uri.parse('${ApiConstance.clientBaseUrl}register');
    final headers = {
      "Content-Type": ApiConstance.contentType,
    };
    final json = client.toJson();
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    final statusCode = response.statusCode;

    print(statusCode);

    if (statusCode == 201) {
      print('✅ REgister SUCCESS ✅');
      print("🔥🌟${response.body}");
      var x = ClientModel.fromJson(response.body);
      print("😎😎 $x");
      return x;
    } else {
      print('🛑 REgister FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }

  @override
  Future<List<TravelModel>> getTravel(String placeOfDeparture, String placeOfArrival) async {
    String token = _appPrefences.getToken();

    final url =
        Uri.parse("${ApiConstance.travelsBaseUrl}?placeOfDeparture=$placeOfDeparture&placeOfArrival=$placeOfArrival");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };

    final Response response = await get(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ GET TRAVELS  SUCCESS ✅');
      print("🔥🌟${response.body}");
      final decodedBody = convert.jsonDecode(response.body) as List<dynamic>;

      var x = List<TravelModel>.from(
        decodedBody.map(
          (travelData) {
            return TravelModel.fromMap(travelData);
          },
        ),
      );
      return x;
    } else {
      print('🛑 GET TRAVELS  FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }

  @override
  Future<ClientModel> getClientById(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse('${ApiConstance.clientBaseUrl}$id');
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };
    final Response response = await get(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    print(statusCode);

    if (statusCode == 200) {
      print('✅ getClientById SUCCESS ✅');
      print("🔥🌟${response.body}");
      var x = ClientModel.fromJson(response.body);
      print("😎😎 $x");
      return x;
    } else {
      print('🛑 getClientById FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }

  @override
  Future<void> requestToBook(String travelId) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.requestsBaseUrl}register");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };
    final json = {
      "travelId": travelId,
    };
    final Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    final statusCode = response.statusCode;
    print(statusCode);
    if (statusCode == 201) {
      print('✅ requestToBook SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 requestToBook FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }

  //----------------------------------------------------- DRIVER -----------------------------------------------------

  @override
  Future<DriverModel> driverLogin(String phoneNumber, String password) async {
    final url = Uri.parse("${ApiConstance.driverBaseUrl}login");
    final headers = {
      "Content-Type": ApiConstance.contentType,
    };
    final json = {
      "phoneNumber": phoneNumber,
      "password": password,
    };
    final Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ LOGIN SUCCESS ✅');
      print("🔥🌟${response.body}");
      var x = DriverModel.fromJson(response.body);
      print("😎😎 $x");
      return x;
    } else {
      print('🛑 LOGIN FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }

  @override
  Future<DriverModel> driverRegister(DriverModel driver) async {
    final url = Uri.parse('${ApiConstance.driverBaseUrl}register');
    final headers = {
      "Content-Type": ApiConstance.contentType,
    };
    final json = driver.toJson();
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    final statusCode = response.statusCode;

    print(statusCode);

    if (statusCode == 201) {
      print('✅ REgister SUCCESS ✅');
      print("🔥🌟${response.body}");
      var x = DriverModel.fromJson(response.body);
      print("😎😎 $x");
      return x;
    } else {
      print('🛑 REgister FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }

  @override
  Future<DriverModel> getDriverById(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse('${ApiConstance.driverBaseUrl}$id');
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };
    final Response response = await get(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    print(statusCode);

    if (statusCode == 200) {
      print('✅ getDriverById SUCCESS ✅');
      print("🔥🌟${response.body}");
      var x = DriverModel.fromJson(response.body);
      print("😎😎 $x");
      return x;
    } else {
      print('🛑 getDriverById FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }

  @override
  Future<void> createTravel(TravelModel travelModel) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.travelsBaseUrl}/create");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };
    final json = travelModel.toJson();

    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    final statusCode = response.statusCode;

    print(statusCode);

    if (statusCode == 201) {
      print('✅ createTravel SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 createTravel FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }

  //----------------------------------------------------- ADMIN -----------------------------------------------------

  @override
  Future<AdminModel> adminLogin(String phoneNumber, String password) async {
    final url = Uri.parse("${ApiConstance.adminBaseUrl}login");
    final headers = {
      "Content-Type": ApiConstance.contentType,
    };
    final json = {
      "phoneNumber": phoneNumber,
      "password": password,
    };
    final Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ adminLogin SUCCESS ✅');
      print("🔥🌟${response.body}");
      var x = AdminModel.fromJson(response.body);
      print("😎😎 $x");
      return x;
    } else {
      print('🛑 adminLogin FAILURE 🛑');
      print(response.body);
      throw response.body;
    }
  }
}

// bool validateTravelJson(Map<String, dynamic> map) {
//   final requiredProperties = [
//     'PlaceOfDeparture',
//     'TimeOfDeparture',
//     'PlaceOfArrival',
//     'TimeOfArrival',
//     'NumberOfPlaces',
//     'carname',
//     'carimage',
//     'placeprice',
//     'allowSmoking',
//     'allowPets',
//     'requestList',
//     'driverinf', // Ensure driver information is present
//   ];
//   for (var property in requiredProperties) {
//     if (!map.containsKey(property)) {
//       print('Error: Missing property: $property in travel JSON');
//       return false;
//     }
//   }
//   // Additional driver information check (optional)
//   final driverInfo = map['driverinf'] as Map<String, dynamic>;
//   // You can optionally validate specific driver properties here:
//   // if (!driverInfo.containsKey('driverId') || !driverInfo.containsKey('name')) {
//   //   throw Exception('Invalid travel JSON: Missing required driver properties');
//   // }
//   return true;
// }
