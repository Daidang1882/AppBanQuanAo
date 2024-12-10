import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/model/productmodel.dart';
import '../../data/model/product_viewmodel.dart';
import '../../config/const.dart';

Widget itemGridView(Product productModel) {
  return Consumer<FavoriteProvider>(
    builder: (context, favoriteProvider, child) {
      bool isFavorite = favoriteProvider.isFavorite(productModel.id ?? -1);

      return Stack(
        children: [
          // Nội dung chính của sản phẩm
          Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: Colors.lightBlue,
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Hiển thị ảnh sản phẩm
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child:
                      productModel.img != null && productModel.img!.isNotEmpty
                          ? Image.asset(
                              url_product_img + productModel.img!,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 100),
                            )
                          : const Icon(Icons.image, size: 100),
                ),
                // Hiển thị tên sản phẩm
                Text(
                  productModel.name ?? 'No Name',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                // Hiển thị giá sản phẩm
                Text(
                  "Giá: ${NumberFormat.currency(locale: 'vi_VN', symbol: 'VND').format(productModel.price)}",
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                ),
                // Thêm và xóa sản phẩm
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<ProductsVM>(
                      builder: (context, value, child) => ElevatedButton.icon(
                        icon: const Icon(Icons.add,
                            color: Colors.orange, size: 18),
                        label: const Text('Add'),
                        onPressed: () {
                          value.add(productModel); // Thêm sản phẩm vào giỏ hàng
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Khoảng cách giữa các nút
                    Consumer<ProductsVM>(
                      builder: (context, value, child) => ElevatedButton.icon(
                        icon: const Icon(Icons.remove,
                            color: Colors.orange, size: 18),
                        label: const Text('Delete'),
                        onPressed: () {
                          value.del(productModel.id ??
                              -1); // Xóa sản phẩm khỏi giỏ hàng
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Biểu tượng trái tim yêu thích
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                if (isFavorite) {
                  favoriteProvider.removeFavorite(productModel.id ?? -1);
                  showSnackBar("Đã bỏ yêu thích", context);
                } else {
                  favoriteProvider.addFavorite(productModel.id ?? -1);
                  showSnackBar("Đã thêm yêu thích", context);
                }
              },
            ),
          ),
        ],
      );
    },
  );
}

// Hàm hiển thị thông báo SnackBar
void showSnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

// Provider để quản lý trạng thái yêu thích
class FavoriteProvider with ChangeNotifier {
  final List<int> _favoriteProducts = [];

  List<int> get favoriteProducts => _favoriteProducts;

  bool isFavorite(int id) => _favoriteProducts.contains(id);

  void addFavorite(int id) {
    if (!_favoriteProducts.contains(id)) {
      _favoriteProducts.add(id);
      notifyListeners();
    }
  }

  void removeFavorite(int id) {
    _favoriteProducts.remove(id);
    notifyListeners();
  }
}
