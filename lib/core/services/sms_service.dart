import 'package:http/http.dart' as http;

class SmsService {
  static const String username = 'YOUR_USERNAME';
  static const String apiKey = 'YOUR_API_KEY';
  static const String smsUrl = 'https://api.africastalking.com/version1/messaging';

  static Future<void> sendSms({
    required String to,
    required String message,
  }) async {
    final response = await http.post(
      Uri.parse(smsUrl),
      headers: {
        'apiKey': apiKey,
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'username': username,
        'to': to,
        'message': message,
      },
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to send SMS: ${response.body}');
    }
  }
}
