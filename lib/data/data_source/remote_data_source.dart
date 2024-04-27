import 'dart:convert';

import 'package:carpool/app/api_constance.dart';
import 'package:carpool/data/models/models.dart';
import 'package:http/http.dart';

abstract class RemoteDataSource {
  Future<ClientModel> clientLogin(String phoneNumber, String password);
  Future<ClientModel> clientRegister(ClientModel client);

  Future<DriverModel> driverLogin(String phoneNumber, String password);
  Future<DriverModel> driverRegister(DriverModel driver);
}

class RemoteDataSourceImpl extends RemoteDataSource {
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
}
