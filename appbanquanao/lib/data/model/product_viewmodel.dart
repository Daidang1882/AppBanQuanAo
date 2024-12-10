import 'package:flutter/widgets.dart';
import 'productmodel.dart';

class ProductsVM with ChangeNotifier {
  List<Product> lst = [];

  // Thêm sản phẩm vào giỏ hàng
  void add(Product product) {
    var existingProduct = lst.firstWhere(
      (p) => p.id == product.id,
      orElse: () =>
          Product(id: 0), // Trả về sản phẩm "trống" nếu không tìm thấy
    );

    if (existingProduct.id != 0) {
      // Nếu sản phẩm đã có trong giỏ, chỉ tăng số lượng
      existingProduct.quantity = (existingProduct.quantity ?? 0) + 1;
    } else {
      // Nếu sản phẩm chưa có, thêm mới vào danh sách
      lst.add(product);
    }
    notifyListeners();
  }

  // Xóa sản phẩm hoặc giảm số lượng
  void del(int index) {
    var product = lst[index];
    if (product.quantity! > 1) {
      // Nếu số lượng sản phẩm > 1, giảm số lượng
      product.quantity = product.quantity! - 1;
    } else {
      // Nếu số lượng còn 1, xóa sản phẩm khỏi giỏ
      lst.removeAt(index);
    }
    notifyListeners();
  }

//Xóa tất cả  del()
  clear() {
    lst.clear();
    notifyListeners();
  }
}
