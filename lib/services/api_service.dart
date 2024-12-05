import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shoe.dart';

class ApiService {
  static const _baseUrl = 'https://shoes-api-liard.vercel.app/shoes';

  static Future<List<Shoe>> fetchShoes() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((shoe) => Shoe.fromJson(shoe)).toList();
    } else {
      throw Exception('Failed to load shoes');
    }
  }
}
