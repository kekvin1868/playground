import 'package:http/http.dart' as http;

class EmailService {
  static const String baseUrl = 'https://backend.pakar.diawan.id/api'; // Replace with your backend URL

  static Future<void> sendEmail(String uuid, String? email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/send-email'),
        headers: {
          'uuid': uuid,
          'email': email!,
        },
      );

      if (response.statusCode == 200) {
        print('Email sent.');
      } else {
        print('Failed to send email. Status code: ${response.statusCode}');
        throw Exception('Failed to send email');
      }
    } catch (e) {
      print('Error sending email: $e');
      throw Exception('Failed to send email: $e');
    }
  }
}