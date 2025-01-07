import 'dart:convert';
import 'package:http/http.dart' as http;
import '../user_model/model.dart';


class UserService {
  Future<List<User>> fetchUsers() async {
    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      // Log the error and stack trace
      print('Error occurred: $error');
      print('Stack trace: $stackTrace');
      // Optionally, rethrow the error if needed
      rethrow;
    }
  }
}
