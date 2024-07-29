import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:frontend/models/ms_skill.dart';

class ApiService {
  static const String baseUrl = 'https://backend.pakar.diawan.id/api';
  // static const String baseUrl = 'http://localhost:8000/api';

  static const String webUrl = 'https://backend.pakar.diawan.id';
  // static const String webUrl = 'http://localhost:8000';

  Future<List<Skill>> fetchSkills() async {
    final res = await http.get(
      Uri.parse('$baseUrl/skills'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'test',
      },
    );

    if (res.statusCode == 200) {
        List jsonResponse = json.decode(res.body);
        return jsonResponse.map((data) => Skill.fromJson(data)).toList();
    } else {
        throw Exception ('Failed to load skills.');
    }
  }

  Future<bool> validateUuid(String uuid) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/activation'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'uuid': uuid,
        },
      );

      await Future.delayed(const Duration(seconds: 1));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final bool status = data['activated'];

        return status;
      } else {
        print(res.statusCode);
        print(res.body);
        throw Exception ('Failed to validate account activation.');
      }
    } catch (e) {
      final message = e.toString();
      print(message);

      return false;
    }
  }

  Future<void> updateUserActivation(int id, String uuid) async {
    try {
      final res = await http.put(
        Uri.parse('$webUrl/users/$id?type=activation'),
        headers: {
          'x-api-key': 'test',
        }
      );

      if (res.statusCode == 200) {
        print('User Updated');
      } else {
        print('User update failed.');
        print(res.statusCode);
      }
    } catch (e) {
      final message = e.toString();
      print(message);
    }
  }

  Future<void> updateAgreementUser(int id, String uuid) async {
    try {
      final res = await http.put(
        Uri.parse('$webUrl/users/$id?type=agreement'),
        headers: {
          'x-api-key': 'test',
        }
      );

      if (res.statusCode == 200) {
        print('User agreement status updated');
      } else {
        print('User agreement status update failed.');
        print(res.statusCode);
      }
    } catch (e) {
      final message = e.toString();
      print(message);
    }
  }

  void updateUserIdentity(int userId, String idNum, String bnkNum, String taxNum, File? image, File? ktpImage) async {
    File imagePhotoFile = File(image!.path);
    Uint8List photoBytes = await imagePhotoFile.readAsBytes();
    String base64StringPhoto = base64.encode(photoBytes);
    final photoExtension = p.extension(image.path);

    File imageKtpFile = File(ktpImage!.path);
    Uint8List ktpPhotoBytes = await imageKtpFile.readAsBytes();
    String base64StringKtpPhoto = base64.encode(ktpPhotoBytes);
    final ktpPhotoExtension = p.extension(ktpImage.path);
    
    try {
      final uri = Uri.parse('$webUrl/users/$userId?type=personal');

      final res = await http.put(uri,
        headers: {
          'x-api-key': 'test',
        },
        body: {
          "ktp": idNum,
          "bank": bnkNum,
          "npwp": taxNum,
          "image": base64StringPhoto,
          "imageExt": photoExtension.toString(),
          "ktpImage": base64StringKtpPhoto,
          "ktpExt": ktpPhotoExtension.toString()
        }
      );

      if (res.statusCode == 200) {
        print('Identity Record updated. User $userId');
        print(res);
      } else {
        print('Identity Record for user update failed. User $userId');
        print(res.statusCode);
      }
    } catch (e) {
      final message = e.toString();
      print(message);
    }
  }

  Future<Map<String, dynamic>> checkUser(String? email) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/check-email'),
        headers: {
          'x-api-key': 'test',
        },
        body: {
          'email': email,
        }
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        final check = {
          'exists': data['exists'] ?? false,
          'unique_id': data['user_info']['unique_id'] ?? '',
          'status': data['user_info']['user_status'] ?? '0',
          'id': data['user_info']['id_user'],
        };

        return check;
      } else {
        return {
          'exists': false,
          'unique_id': '',
          'status': '0',
          'id': null,
        };
      }
    } catch (e) {
      return {
        'exists': false,
        'unique_id': '',
        'status': '0',
        'id': null,
      };
    }
  }

  Future<Object> checkUserAgreements(int currentUser) async {
    try {
      final res = await http.post(
        Uri.parse('$webUrl/users?type=getAgreements'),
        headers: {
          'x-api-key': 'test',
        },
        body: {
          'id': '$currentUser',
        }
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return {
          'tos': data['tos'],
          'pp': data['pp'],
        };
      } else {
        final data = jsonDecode(res.body);
        return {
          'tos': data['tos'],
          'pp': data['pp'],
        };
      }
    } catch (e) {
      return {
          'tos': 0,
          'pp': 0,
        };
    }
  }
}