import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:frontend/models/ms_skill.dart';

class ApiService {
  static const String baseUrl = 'https://backend.pakar.diawan.id/api';
  static const String webUrl = 'http://localhost:8000';
  // static const String webUrl = 'https://backend.pakar.diawan.id';

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

  Future<void> updateUserIdentity(int userId, String idNum, String bnkNum, String taxNum, File? image) async {
    try {
      final res = await http.put(
        Uri.parse('$webUrl/users/$userId?type=personal'),
        headers: {
          'x-api-key': 'test',
          'ktp': idNum,
          'bank': bnkNum,
          'npwp': taxNum,
        }
      );

      if (res.statusCode == 200) {
        print('Identity Record updated. User $userId');
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
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': 'test',
          'email': email!,
        },
        // body: jsonEncode(<String, dynamic> {
          
        // }
        // ),
      );
      await Future.delayed(const Duration(seconds: 1));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        final check = {
          'exists': data['exists'] ?? false,
          'unique_id': data['unique_id'] ?? '',
          'status': data['status'] ?? '0',
        };

        return check;
      } else {
        return {
          'exists': false,
          'unique_id': '',
          'status': '0',
        };
      }
    } catch (e) {
      return {
          'exists': false,
          'unique_id': '',
          'status': '0',
        };
    }
  }

  Future<int> getUserId (String unique) async {
    try {
      final res = await http.get(
        Uri.parse('$webUrl/users?getId'),
        headers: <String, String> {
          'Content-Type': 'application/json;',
          'x-api-key': 'test',
          'uuid': unique,
        },
        // body: jsonEncode(<String, dynamic> {
          
        // }
        // ),
      );
      await Future.delayed(const Duration(seconds: 1));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['id'];
      } else {
        final data = jsonDecode(res.body);
        return data['id'];
      }
    } catch (e) {
      return 0;
    }
  }

  Future<bool> checkUserAgreements(int currentUser) async {
    try {
      final res = await http.get(
        Uri.parse('$webUrl/users?getAgreements'),
        headers: <String, String> {
          'Content-Type': 'application/json;',
          'x-api-key': 'test',
          'id': '$currentUser',
        },
        // body: jsonEncode(<String, dynamic> {
          
        // }
        // ),
      );
      await Future.delayed(const Duration(seconds: 1));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['tos'] == '1' && data['pp'] == '1';
      } else {
        final data = jsonDecode(res.body);
        return data['tos'] == '1' && data['pp'] == '1';
      }
    } catch (e) {
      return false;
    }
  }
}