import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../utils/constants/connection_strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProfileService {
  var client = http.Client();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) {
      return {"success": false, "message": "No access token found"};
    }

    try {
      var response = await client.get(
        Uri.parse('${TConnectionStrings.deployment}account/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (kDebugMode) {
          print('Successfully retrieved user information: $data');
        }
        return {"success": true, "data": data};
      } else {
        if (kDebugMode) {
          print('Failed to retrieve user information: ${response.body}');
        }
        return {
          "success": false,
          "message": 'Failed to retrieve user information',
        };
      }
    } catch (e) {
      return {
        "userInformation": false,
        "message": 'Error retrieving user information: $e'
      };
    }
  }

  Future<Map<String, Object>> updateUserProfilePicture(XFile image) async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) {
      return {"success": false, "message": "No access token found"};
    }

    var userProfile = await getUserProfile();
    if (userProfile["success"] != true) {
      return {"success": false, "message": "Failed to get user profile"};
    }

    String userId = userProfile["data"]["data"]["user_id"];

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${TConnectionStrings.deployment}account/image?id=$userId'),
      );
      request.headers['Authorization'] = 'Bearer $accessToken';

      var file = await http.MultipartFile.fromPath('profile_pic', image.path);
      request.files.add(file);

      var response = await request.send().timeout(const Duration(seconds: 10));
      final responseData = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Successfully updated profile picture');
        }
        return {
          "success": true,
          "message": "Profile picture updated successfully"
        };
      } else {
        if (response.statusCode == 500) {
          return {
            "success": false,
            "message":
                'Maximum upload size exceeded. Please try with a smaller image.'
          };
        } else {
          if (kDebugMode) {
            print('Failed to update profile picture: ${responseData.body}');
          }
          return {
            "success": false,
            "message": 'Failed to update profile picture',
          };
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating profile picture: $e');
      }
      return {
        "success": false,
        "message": 'Error updating profile picture: $e'
      };
    }
  }

  Future<Map<String, Object>> updateUserProfile(Map<String, dynamic> updatedFields) async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) {
      return {"success": false, "message": "No access token found"};
    }

    var userProfile = await getUserProfile();
    if (userProfile["success"] != true) {
      return {"success": false, "message": "Failed to get user profile"};
    }

    String userId = userProfile["data"]["data"]["user_id"];
    Map<String, dynamic> userData = userProfile["data"]["data"];

    userData.addAll(updatedFields);

    try {
      var response = await client.put(
        Uri.parse('${TConnectionStrings.deployment}account/profile?id=$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(userData),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Successfully updated user profile');
        }
        return {
          "success": true,
          "message": "User profile updated successfully"
        };
      } else {
        if (kDebugMode) {
          print('Failed to update user profile: ${response.body}');
        }
        return {
          "success": false,
          "message": 'Failed to update user profile',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user profile: $e');
      }
      return {
        "success": false,
        "message": 'Error updating user profile: $e'
      };
    }
  }
}
