import 'package:flutter/widgets.dart';
import 'productmodel.dart';

class ProductsVM with ChangeNotifier {
  List<Product> lst = [];

//Thêm sản phẩm
  add(Product mo) {
    lst.add(mo);
    notifyListeners();
  }

//Xóa sản phẩm
  del(int index) {
    lst.removeAt(index);
    notifyListeners();
  }

//Xóa tất cả
  clear() {
    lst.clear();
    notifyListeners();
  }
}
