import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/ms_skill.dart';

class ApiService {
    static const String apiUrl = 'http://localhost:8000/api/skills';

    Future<List<Skill>> fetchSkills() async {
        final res = await http.get(
          Uri.parse(apiUrl),
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
}