import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shoe.dart';

class ShoeService {
  static Future<List<Shoe>> fetchShoes() async {
    final response = await http.get(Uri.parse('https://shoes-api-liard.vercel.app/shoes'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Shoe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shoes');
    }
  }
}
