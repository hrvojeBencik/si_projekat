class User {
  final String? id;
  final String firebaseId;
  final String firstName;
  final String lastName;
  final String email;
  final String? image;

  User({
    this.id,
    required this.firebaseId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      firebaseId: data['firebaseId'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      image: data['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firebaseId': firebaseId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
    };
  }
}
