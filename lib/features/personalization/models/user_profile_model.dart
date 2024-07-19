class UserProfileModel {
  final String email;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? gender;
  final String? dob;
  final String phone;
  final String roleName;
  final String userId;
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final String oauthProvider;

  UserProfileModel({
    required this.email,
    required this.address,
    this.latitude,
    this.longitude,
    this.gender,
    this.dob,
    required this.phone,
    required this.roleName,
    required this.userId,
    this.firstName,
    this.lastName,
    this.profilePicture,
    required this.oauthProvider,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      email: json['email'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      gender: json['gender'],
      dob: json['dob'],
      phone: json['phone'],
      roleName: json['roleName'],
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePicture: json['profile_picture'],
      oauthProvider: json['oauth_provider'],
    );
  }
}
