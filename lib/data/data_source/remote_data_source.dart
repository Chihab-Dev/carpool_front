import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:carpool/app/api_constance.dart';
import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/data/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

abstract class RemoteDataSource {
  //----------------------------------------------------- CLIENT -----------------------------------------------------
  Future<ClientModel> clientLogin(String phoneNumber, String password);
  Future<ClientModel> clientRegister(ClientModel client);
  Future<List<TravelModel>> getTravel(String placeOfDeparture, String placeOfArrival);
  Future<ClientModel> getClientById(String id);
  Future<void> requestToBook(String travelId);
  Future<void> clientSendFeedback(FeedbackModel feedback);
  Future<TravelModel> clientGetTravelById(String id);
  Future<List<TravelModel>> clientGetAllTravels();
  Future<void> deleteClientRequest(String id);
  Future<String> uploadImageAndGetUrl(File imageFile);

  //----------------------------------------------------- DRIVER -----------------------------------------------------
  Future<DriverModel> driverLogin(String phoneNumber, String password);
  Future<DriverModel> driverRegister(DriverModel driver);
  Future<DriverModel> getDriverById(String id);
  Future<void> createTravel(TravelModel travelModel);
  Future<void> driverSendFeedback(FeedbackModel feedback);
  Future<void> updateTravel(TravelModel travel);
  Future<List<TravelModel>> driverGetTravelById();
  Future<void> updateRequestState(String state, String requestId, String travelId);
  Future<void> driverDeleteTravel(String id);
  Future<void> changeTravelState(String state, String travelId);

  //----------------------------------------------------- ADMIN -----------------------------------------------------
  Future<AdminModel> adminLogin(String phoneNumber, String password);
  Future<List<DriverModel>> getAllDrivers();
  Future<List<TravelModel>> getAllTravels();
  Future<List<ClientModel>> getAllClients();

  Future<void> acceptDriver(String id);
  Future<void> rejectDriver(String id);
  Future<void> deleteDriver(String id);

  Future<void> deleteTravel(String id);
  Future<void> deleteClient(String id);
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
      print('🛑 clientLogin FAILURE 🛑');
      print(response.body);
      // Parse the JSON response body
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      // Extract the message field
      final String errorMessage = errorResponse['message'];
      // Throw the message field content
      throw errorMessage;
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
      print('🛑 Register FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
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
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
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
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
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
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> clientSendFeedback(FeedbackModel feedback) async {
    String token = _appPrefences.getToken();
    final url = Uri.parse("${ApiConstance.feedbackBaseUrl}client-rate-driver/${feedback.toUser}");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };
    final json = {
      "note": feedback.note,
      "comment": feedback.comment,
    };
    final Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    final statusCode = response.statusCode;
    print(statusCode);
    if (statusCode == 201) {
      print('✅ clientSendFeedback SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 clientSendFeedback FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<TravelModel> clientGetTravelById(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.travelsBaseUrl}/$id");
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
      print('✅ GET TRAVELS BY ID SUCCESS ✅');
      print("🔥🌟${response.body}");

      return TravelModel.fromJson(response.body);
    } else {
      print('🛑 GET TRAVELS BY ID  FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<List<TravelModel>> clientGetAllTravels() async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.travelsBaseUrl}/");
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
      print('✅ GET ALL TRAVELS  SUCCESS ✅');
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
      print('🛑 getAllTravels FAILURE 🛑');
      print(response.body);
      throw (response.body as Map<String, dynamic>)['message'];
    }
  }

  @override
  Future<void> deleteClientRequest(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.requestsBaseUrl}$id");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };

    final Response response = await delete(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    print(statusCode);
    if (statusCode == 200) {
      print('✅ deleteClientRequest SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 deleteClientRequest  FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
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
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
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
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
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
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
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
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> driverSendFeedback(FeedbackModel feedback) async {
    String token = _appPrefences.getToken();
    final url = Uri.parse("${ApiConstance.feedbackBaseUrl}driver-rate-client/${feedback.toUser}");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };
    final json = {
      "note": feedback.note,
      "comment": feedback.comment,
    };
    final Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    final statusCode = response.statusCode;
    print(statusCode);
    if (statusCode == 201) {
      print('✅ driverSendFeedback SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 driverSendFeedback FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> updateTravel(TravelModel travel) async {
    String token = _appPrefences.getToken();
    final url = Uri.parse("${ApiConstance.travelsBaseUrl}/${travel.travelId}");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };
    final json = travel.toJson();

    final Response response = await put(
      url,
      headers: headers,
      body: json,
    );

    final statusCode = response.statusCode;
    print(statusCode);
    if (statusCode == 200) {
      print('✅ updateTravel SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 updateTravel FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<List<TravelModel>> driverGetTravelById() async {
    String token = _appPrefences.getToken();
    final AppPrefences appPrefences = AppPrefences(getIt());
    var id = appPrefences.getId();

    final url = Uri.parse("${ApiConstance.travelsBaseUrl}/driver/$id");
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
      print('✅ GET Driver TRAVELS BY ID SUCCESS ✅');
      // print("🔥🌟${response.body}");
      log(response.body);

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
      print('🛑 GET Driver TRAVELS BY ID  FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> updateRequestState(String state, String requestId, String travelId) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.requestsBaseUrl}$requestId");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };
    final json = {
      "state": state,
      "travelId": travelId,
    };

    final Response response = await put(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ updateRequestState SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 updateRequestState  FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> driverDeleteTravel(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.travelsBaseUrl}/$id");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };

    final Response response = await delete(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ deleteTravel  SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 deleteTravel FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> changeTravelState(String state, String travelId) async {
    String token = _appPrefences.getToken();
    final url = Uri.parse("${ApiConstance.travelsBaseUrl}/$travelId");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };
    final json = {
      "state": state,
    };

    final Response response = await put(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    final statusCode = response.statusCode;
    print(statusCode);
    if (statusCode == 200) {
      print('✅ changeTravelState SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 changeTravelState FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
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
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<List<DriverModel>> getAllDrivers() async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.driverBaseUrl}admin/drivers");
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
      print('✅ getAllDrivers SUCCESS ✅');
      print("🔥🌟${response.body}");
      final decodedBody = convert.jsonDecode(response.body) as List<dynamic>;

      var x = List<DriverModel>.from(
        decodedBody.map(
          (driver) {
            return DriverModel.fromMap(driver);
          },
        ),
      );
      print("😎😎 $x");
      return x;
    } else {
      print('🛑 getAllDrivers FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<List<ClientModel>> getAllClients() async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.clientBaseUrl}admin/clients");
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
      print('✅ getAllClients SUCCESS ✅');
      print("🔥🌟${response.body}");
      final decodedBody = convert.jsonDecode(response.body) as List<dynamic>;
      var x = List<ClientModel>.from(
        decodedBody.map(
          (client) {
            return ClientModel.fromMap(client);
          },
        ),
      );
      print("😎😎 $x");
      return x;
    } else {
      print('🛑 getAllClients FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<List<TravelModel>> getAllTravels() async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.travelsBaseUrl}/admin/travels");
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
      print('✅ GET ALL TRAVELS  SUCCESS ✅');
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
      print('🛑 getAllTravels FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> acceptDriver(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.adminBaseUrl}admin/driver/$id/accept");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };

    final Response response = await put(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ acceptDriver  SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 acceptDriver FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> rejectDriver(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.adminBaseUrl}admin/driver/$id/reject");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };

    final Response response = await put(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ rejectDriver  SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 rejectDriver FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> deleteDriver(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.adminBaseUrl}admin/driver/$id");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };

    final Response response = await delete(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ deleteDriver  SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 deleteDriver FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> deleteClient(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.adminBaseUrl}admin/client/$id");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };

    final Response response = await delete(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ deleteClient  SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 deleteClient FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<void> deleteTravel(String id) async {
    String token = _appPrefences.getToken();

    final url = Uri.parse("${ApiConstance.adminBaseUrl}admin/travel/$id");
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "token": token,
    };

    final Response response = await delete(
      url,
      headers: headers,
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      print('✅ deleteTravel  SUCCESS ✅');
      print("🔥🌟${response.body}");
    } else {
      print('🛑 deleteTravel FAILURE 🛑');
      print(response.body);
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final String errorMessage = errorResponse['message'];
      throw errorMessage;
    }
  }

  @override
  Future<String> uploadImageAndGetUrl(File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
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



