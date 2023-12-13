import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final int age;
    final String location;
  final String gender;
  final List<dynamic> interests;
  Map<String, String?> levels = {};

  static const Map<String, String?> emptyLevels = {};

  User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.age,
    required this.location,
    required this.gender,
    required this.interests,
    Map<String, String?>? levels =
        emptyLevels, //emptyLevels as the default value
  }) : levels = levels ?? emptyLevels; //

  Map<String, dynamic> toMap() => {
        //converting user properties to an object
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "age": age,
        "location": location,
        "gender": gender,
        "interests": interests,
        "levels": levels,
      };

  //convert document snapshot and make a user model

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      age: snapshot['age'],
      location: snapshot['location'],
      gender: snapshot['gender'],
      interests: snapshot['interests'],
      levels: Map<String, String?>.from(
          snapshot['levels']), // Explicit cast to Map<String, String?>
    );
  }

  User copyWith({
    String? uid,
    String? username,
    String? email,
    String? photoUrl,
    int? age,
    String? location,
    String? gender,
    Map<String, String?>? levels, // Update the type to Map<String, String?>
    List<dynamic>? interests,
  }) {
    return User(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      age: age ?? this.age,
      location: location?? this.location,
      gender: gender ?? this.gender,
      levels: levels ?? this.levels,
      interests: interests ?? this.interests,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  // Factory constructor with default values
  factory User.defaultUser() {
    return User(
      email: '',
      uid: '',
      photoUrl: '',
      username: '',
      age: 0,
      location: '',
      gender: '',
      interests: [],
      levels: emptyLevels,
    );
  }
}
