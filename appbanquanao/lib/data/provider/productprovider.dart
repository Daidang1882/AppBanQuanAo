import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/productmodel.dart';

class ReadData {
  // Đọc tất cả sản phẩm từ JSON
  Future<List<Product>> loadData() async {
    var data = await rootBundle.loadString("assets/files/productlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List).map((e) => Product.fromJson(e)).toList();
  }

  // Lọc sản phẩm theo danh mục
  Future<List<Product>> loadDataByCat(int catId) async {
    List<Product> allProducts = await loadData();
    return allProducts.where((product) => product.catId == catId).toList();
  }
}
