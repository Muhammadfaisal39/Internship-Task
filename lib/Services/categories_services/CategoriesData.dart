import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internship_task/Services/categories_services/CaategoriesModel.dart';

Future<List<Category>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products/categories'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((category) => Category.fromJson(category)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}
