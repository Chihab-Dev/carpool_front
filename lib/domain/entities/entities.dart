// import 'dart:convert';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class Clientt {
//   String id;
//   String name;
//   String familyname;
//   String address;
//   String dateofbirth;
//   String birthplace;
//   String phoneNumber;
//   String password;
//   String image;
//   String email;
//   List<Feedback> feedbacks;
//   Clientt({
//     required this.id,
//     required this.name,
//     required this.familyname,
//     required this.address,
//     required this.dateofbirth,
//     required this.birthplace,
//     required this.phoneNumber,
//     required this.password,
//     required this.image,
//     required this.email,
//     required this.feedbacks,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'familyname': familyname,
//       'address': address,
//       'dateofbirth': dateofbirth,
//       'birthplace': birthplace,
//       'phoneNumber': phoneNumber,
//       'password': password,
//       'image': image,
//       'email': email,
//       'feedbacks': feedbacks.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory Clientt.fromMap(Map<String, dynamic> map) {
//     return Clientt(
//       id: map['id'] as String,
//       name: map['name'] as String,
//       familyname: map['familyname'] as String,
//       address: map['address'] as String,
//       dateofbirth: map['dateofbirth'] as String,
//       birthplace: map['birthplace'] as String,
//       phoneNumber: map['phoneNumber'] as String,
//       password: map['password'] as String,
//       image: map['image'] as String,
//       email: map['email'] as String,
//       feedbacks: List<Feedback>.from(
//         (map['feedbacks'] as List<int>).map<Feedback>(
//           (x) => Feedback.fromMap(x as Map<String, dynamic>),
//         ),
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Clientt.fromJson(String source) => Clientt.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// class Feedback {
//   double note;
//   String comment;
//   String userId;
//   Feedback({
//     required this.note,
//     required this.comment,
//     required this.userId,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'note': note,
//       'comment': comment,
//       'userId': userId,
//     };
//   }

//   factory Feedback.fromMap(Map<String, dynamic> map) {
//     return Feedback(
//       note: map['note'] as double,
//       comment: map['comment'] as String,
//       userId: map['userId'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Feedback.fromJson(String source) => Feedback.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// class Driver {
//   String id;
//   String name;
//   String address;
//   String birthday;
//   String phoneNumber;
//   String image;
//   List<Feedback> feedbackes;
//   bool isAccepted;
//   Driver({
//     required this.id,
//     required this.name,
//     required this.address,
//     required this.birthday,
//     required this.phoneNumber,
//     required this.image,
//     required this.feedbackes,
//     required this.isAccepted,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'address': address,
//       'birthday': birthday,
//       'phoneNumber': phoneNumber,
//       'image': image,
//       'feedbackes': feedbackes.map((x) => x.toMap()).toList(),
//       'isAccepted': isAccepted,
//     };
//   }

//   factory Driver.fromMap(Map<String, dynamic> map) {
//     return Driver(
//       id: map['id'] as String,
//       name: map['name'] as String,
//       address: map['address'] as String,
//       birthday: map['birthday'] as String,
//       phoneNumber: map['phoneNumber'] as String,
//       image: map['image'] as String,
//       feedbackes: List<Feedback>.from(
//         (map['feedbackes'] as List<int>).map<Feedback>(
//           (x) => Feedback.fromMap(x as Map<String, dynamic>),
//         ),
//       ),
//       isAccepted: map['isAccepted'] as bool,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Driver.fromJson(String source) => Driver.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// class Admin {
//   String id;
//   String name;
//   String phoneNumber;
//   Admin({
//     required this.id,
//     required this.name,
//     required this.phoneNumber,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'phoneNumber': phoneNumber,
//     };
//   }

//   factory Admin.fromMap(Map<String, dynamic> map) {
//     return Admin(
//       id: map['id'] as String,
//       name: map['name'] as String,
//       phoneNumber: map['phoneNumber'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Admin.fromJson(String source) => Admin.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// class Travel {
//   String driverId;
//   String placeOfDeparture;
//   String timeOfDeparture;
//   String placeOfArrival;
//   String timeOfArrival;
//   int numberOfPlaces;
//   String carName;
//   String carImage;
//   int priceOfPlace;
//   bool allowSloking;
//   bool allowAnimals;
//   List<Request> requests;
//   Travel({
//     required this.driverId,
//     required this.placeOfDeparture,
//     required this.timeOfDeparture,
//     required this.placeOfArrival,
//     required this.timeOfArrival,
//     required this.numberOfPlaces,
//     required this.carName,
//     required this.carImage,
//     required this.priceOfPlace,
//     required this.allowSloking,
//     required this.allowAnimals,
//     required this.requests,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'driverId': driverId,
//       'placeOfDeparture': placeOfDeparture,
//       'timeOfDeparture': timeOfDeparture,
//       'placeOfArrival': placeOfArrival,
//       'timeOfArrival': timeOfArrival,
//       'numberOfPlaces': numberOfPlaces,
//       'carName': carName,
//       'carImage': carImage,
//       'priceOfPlace': priceOfPlace,
//       'allowSloking': allowSloking,
//       'allowAnimals': allowAnimals,
//       'requests': requests.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory Travel.fromMap(Map<String, dynamic> map) {
//     return Travel(
//       driverId: map['driverId'] as String,
//       placeOfDeparture: map['placeOfDeparture'] as String,
//       timeOfDeparture: map['timeOfDeparture'] as String,
//       placeOfArrival: map['placeOfArrival'] as String,
//       timeOfArrival: map['timeOfArrival'] as String,
//       numberOfPlaces: map['numberOfPlaces'] as int,
//       carName: map['carName'] as String,
//       carImage: map['carImage'] as String,
//       priceOfPlace: map['priceOfPlace'] as int,
//       allowSloking: map['allowSloking'] as bool,
//       allowAnimals: map['allowAnimals'] as bool,
//       requests: List<Request>.from(
//         (map['requests'] as List<int>).map<Request>(
//           (x) => Request.fromMap(x as Map<String, dynamic>),
//         ),
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Travel.fromJson(String source) => Travel.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// class Request {
//   String clientId;
//   String driverId;
//   bool isAccepted;
//   Request({
//     required this.clientId,
//     required this.driverId,
//     required this.isAccepted,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'clientId': clientId,
//       'driverId': driverId,
//       'isAccepted': isAccepted,
//     };
//   }

//   factory Request.fromMap(Map<String, dynamic> map) {
//     return Request(
//       clientId: map['clientId'] as String,
//       driverId: map['driverId'] as String,
//       isAccepted: map['isAccepted'] as bool,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Request.fromJson(String source) => Request.fromMap(json.decode(source) as Map<String, dynamic>);
// }
