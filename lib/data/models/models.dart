// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_String: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClientModel {
  String id;
  String name;
  String familyname;
  String address;
  String dateofbirth;
  String phoneNumber;
  String password;
  String image;
  List<FeedbackModel> feedbackes;
  String? token;
  String email = 'chihab@gmail.com';
  ClientModel({
    required this.id,
    required this.name,
    required this.familyname,
    required this.address,
    required this.dateofbirth,
    required this.password,
    required this.phoneNumber,
    required this.image,
    required this.feedbackes,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'familyname': familyname,
      'address': address,
      'birthday': dateofbirth,
      'phoneNumber': phoneNumber,
      'password': password,
      'image': image,
      'email': email,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['_id'] as String,
      familyname: map['familyname'] as String,
      name: map['name'] as String,
      dateofbirth: map['birthday'] as String,
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as String,
      password: '',
      image: map['image'] as String,
      token: map['token'] as String?,
      feedbackes: List<FeedbackModel>.from(
        (map['feedback'] as List<dynamic>).map<FeedbackModel>(
          (x) => FeedbackModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) => ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DriverModel {
  String id;
  String name;
  String familyname;
  String address;
  String birthday;
  String phoneNumber;
  String image;
  String password;
  List<FeedbackModel> feedbackes;
  bool isAccepted;
  String? token;
  DriverModel({
    required this.id,
    required this.name,
    required this.familyname,
    required this.address,
    required this.birthday,
    required this.phoneNumber,
    required this.image,
    required this.password,
    required this.feedbackes,
    required this.isAccepted,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'familyname': familyname,
      'address': address,
      'birthday': birthday,
      'phoneNumber': phoneNumber,
      'image': image,
      'password': password,
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      familyname: map['familyname'] as String,
      address: map['address'] as String,
      birthday: map['birthday'] as String,
      phoneNumber: map['phoneNumber'] as String,
      image: map['image'] as String,
      password: '',
      feedbackes: List<FeedbackModel>.from(
        (map['feedback'] as List<dynamic>).map<FeedbackModel>(
          (x) => FeedbackModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      isAccepted: map['isAccepted'] as bool,
      token: map['token'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) => DriverModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AdminModel {
  String id;
  String familyName;
  String name;
  String email;
  String image;
  String phoneNumber;
  String? password;
  String? token;
  AdminModel({
    required this.id,
    required this.familyName,
    required this.name,
    required this.email,
    required this.image,
    required this.phoneNumber,
    this.password,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'familyname': familyName,
      'name': name,
      'email': email,
      'image': image,
      'phoneNumber': phoneNumber,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map['_id'] as String,
      familyName: map['familyname'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      phoneNumber: map['phoneNumber'] as String,
      token: map['token'] != null ? map['token'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) => AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FeedbackModel {
  double note;
  String comment;
  String userId;

  FeedbackModel({
    required this.note,
    required this.comment,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'note': note,
      'comment': comment,
      'userId': userId,
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      note: map['note'] as double,
      comment: map['comment'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) => FeedbackModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TravelModel {
  String travelId;
  String placeOfDeparture;
  String timeOfDeparture;
  String placeOfArrival;
  String timeOfArrival;
  int numberOfPlaces;
  String carName;
  String carImage;
  int placePrice;
  bool allowSmoking;
  bool allowPets;
  List<RequestModel> requests;
  DriverModel driver;
  String baggage;
  String dateOfDeparture;
  TravelModel({
    required this.travelId,
    required this.placeOfDeparture,
    required this.timeOfDeparture,
    required this.placeOfArrival,
    required this.timeOfArrival,
    required this.numberOfPlaces,
    required this.carName,
    required this.carImage,
    required this.placePrice,
    required this.allowSmoking,
    required this.allowPets,
    required this.requests,
    required this.driver,
    required this.baggage,
    required this.dateOfDeparture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PlaceOfDeparture': placeOfDeparture,
      'TimeOfDeparture': timeOfDeparture,
      'PlaceOfArrival': placeOfArrival,
      'TimeOfArrival': timeOfArrival,
      'NumberOfPlaces': numberOfPlaces,
      'carname': carName,
      'carImage': carImage,
      'placeprice': placePrice,
      'allowSmoking': allowSmoking,
      'allowPets': allowPets,
      'Baggage': baggage,
      'dateOfDeparture': dateOfDeparture,
      'AcceptAutoClients': false,
    };
  }

  factory TravelModel.fromMap(Map<String, dynamic> map) {
    return TravelModel(
      travelId: map['_id'] as String,
      placeOfDeparture: map['PlaceOfDeparture'] as String,
      placeOfArrival: map['PlaceOfArrival'] as String,
      timeOfDeparture: map['TimeOfDeparture'] as String,
      timeOfArrival: map['TimeOfArrival'] as String,
      numberOfPlaces: map['NumberOfPlaces'] as int,
      carName: map['carname'] as String,
      carImage: map['carimage'] as String,
      placePrice: map['placeprice'] as int,
      allowSmoking: map['allowSmoking'] as bool,
      allowPets: map['allowPets'] as bool,
      requests: List<RequestModel>.from(
        (map['requestList'] as List).map<RequestModel>(
          (x) => RequestModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      driver: DriverModel.fromMap(map['driverinf'] as Map<String, dynamic>),
      baggage: map['Baggage'] as String,
      dateOfDeparture: map['dateOfDeparture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelModel.fromJson(String source) => TravelModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class RequestModel {
  String clientId;
  String driverId;
  bool isAccepted;
  RequestModel({
    required this.clientId,
    required this.driverId,
    required this.isAccepted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientId': clientId,
      'driverId': driverId,
      'isAccepted': isAccepted,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      clientId: map['clientId'] as String,
      driverId: map['driverId'] as String,
      isAccepted: map['isAccepted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) => RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
