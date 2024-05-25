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
      id: map['_id'] as String? ?? '',
      familyname: map['familyname'] as String? ?? '',
      name: map['name'] as String? ?? '',
      dateofbirth: map['birthday'] as String? ?? '',
      address: map['address'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      password: '',
      image: map['image'] as String? ?? '',
      token: map['token'] as String?,
      feedbackes:
          (map['feedback'] as List<dynamic>?)?.map((x) => FeedbackModel.fromMap(x as Map<String, dynamic>)).toList() ??
              [],
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
    this.token,
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
      id: map['_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      familyname: map['familyname'] as String? ?? '',
      address: map['address'] as String? ?? '',
      birthday: map['birthday'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      image: map['image'] as String? ?? '',
      password: '',
      feedbackes:
          (map['feedback'] as List<dynamic>?)?.map((x) => FeedbackModel.fromMap(x as Map<String, dynamic>)).toList() ??
              [],
      isAccepted: map['isAccepted'] as bool? ?? false,
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
      id: map['_id'] as String? ?? '',
      familyName: map['familyname'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      image: map['image'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      token: map['token'] as String?,
      password: map['password'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) => AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FeedbackModel {
  String? feedbackId;
  String? fromUser;
  String toUser;
  String? name;
  String? image;
  String? phoneNumber;
  String comment;
  int note;

  FeedbackModel({
    this.feedbackId,
    this.fromUser,
    required this.toUser,
    this.name,
    this.image,
    this.phoneNumber,
    required this.comment,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'toUser': toUser,
      'comment': comment,
      'note': note,
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      feedbackId: map['feedbackId'] as String?,
      fromUser: map['fromUser'] as String?,
      toUser: map['toUser'] as String? ?? '',
      name: map['name'] as String?,
      image: map['image'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      comment: map['comment'] as String? ?? '',
      note: map['note'] as int? ?? 0,
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
  bool autoAcceptRequests;
  String state;

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
    required this.autoAcceptRequests,
    required this.state,
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
      'AcceptAutoClients': autoAcceptRequests,
    };
  }

  factory TravelModel.fromMap(Map<String, dynamic> map) {
    return TravelModel(
      travelId: map['_id'] as String? ?? '',
      placeOfDeparture: map['PlaceOfDeparture'] as String? ?? '',
      placeOfArrival: map['PlaceOfArrival'] as String? ?? '',
      timeOfDeparture: map['TimeOfDeparture'] as String? ?? '',
      timeOfArrival: map['TimeOfArrival'] as String? ?? '',
      numberOfPlaces: map['NumberOfPlaces'] as int? ?? 0,
      carName: map['carname'] as String? ?? '',
      carImage: map['carImage'] as String? ?? '',
      placePrice: map['placeprice'] as int? ?? 0,
      allowSmoking: map['allowSmoking'] as bool? ?? false,
      allowPets: map['allowPets'] as bool? ?? false,
      requests: (map['requestList'] as List<dynamic>?)
              ?.map((x) => RequestModel.fromMap(x as Map<String, dynamic>))
              .toList() ??
          [],
      driver: DriverModel.fromMap(map['driverinf'] as Map<String, dynamic>? ?? {}),
      baggage: map['Baggage'] as String? ?? '',
      dateOfDeparture: map['dateOfDeparture'] as String? ?? '',
      autoAcceptRequests: map['AcceptAutoClients'] as bool? ?? false,
      state: map['state'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelModel.fromJson(String source) => TravelModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class RequestModel {
  String requestId;
  String clientId;
  String name;
  String image;
  String phoneNumber;
  String state;

  RequestModel({
    required this.requestId,
    required this.clientId,
    required this.name,
    required this.image,
    required this.phoneNumber,
    required this.state,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'client_id': clientId,
      'name': name,
      'image': image,
      'phoneNumber': phoneNumber,
      'state': state,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      requestId: map['_id'] as String? ?? '',
      clientId: map['client_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      image: map['image'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      state: map['state'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) => RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
