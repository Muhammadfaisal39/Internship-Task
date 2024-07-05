import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:internship_task/Services/Product_Services/ProductsModel.dart';

class ProductListData{

  Future<ProductsModel> getProductsData()async{
   final response = await http.get(Uri.parse("https://dummyjson.com/products?limit=100"));
   var data = jsonDecode(response.body.toString());
   if(response.statusCode == 200){
     return ProductsModel.fromJson(data);
   }else{
     throw Exception("data not loading");
   }
}

}