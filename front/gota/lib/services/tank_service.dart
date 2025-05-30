import 'dart:convert';
import 'package:gota/models/calculate.dart';
import 'package:gota/models/tank.dart';
import 'package:gota/utils/constants.dart';
import 'package:http/http.dart' as http;

class TankService {
  final String baseurl = '${Constants.baseUrl}tank';

  Future<Calculate?> calculate(
    String id,
    String valuePerLiter
  ) async {
    final url = Uri.parse('$baseurl/calculate');
    final body = {
      'id': id,
      'valueByLiter': valuePerLiter
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Calculate.fromJson(responseData);
    } else {
      return null;
    }
  }

  Future<List<Tank>> loadModels() async {
    final url = Uri.parse('$baseurl');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      return responseData.map((json) => Tank.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar modelos: ${response.statusCode}');
    }
  }

}
