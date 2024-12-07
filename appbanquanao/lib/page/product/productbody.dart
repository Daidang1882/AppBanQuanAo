import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/model/productmodel.dart';
import '../../config/const.dart';
import 'package:provider/provider.dart';
import '../../data/model/product_viewmodel.dart';

Widget itemGridView(Product productModel) {
  return Container(
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
          child: productModel.img != null && productModel.img!.isNotEmpty
              ? Image.asset(
                  url_product_img + productModel.img!,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 100), // Biểu tượng lỗi
                )
              : const Icon(Icons.image,
                  size: 100), // Biểu tượng nếu không có ảnh
        ),
        // Hiển thị tên sản phẩm
        Text(
          productModel.name ?? 'No Name',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        // Hiển thị giá sản phẩm
        Text(
          productModel.price != null
              ? NumberFormat('###,###.###').format(productModel.price)
              : '0',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),

        //Thêm sản phẩm
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Căn giữa hai nút trong hàng.
          children: [
            Consumer<ProductsVM>(
              builder: (context, value, child) => ElevatedButton.icon(
                icon: Icon(
                  Icons.add,
                  color: Colors.orange,
                  size: 10,
                ),
                label: Text('Add'),
                onPressed: () {
                  value.add(productModel); // Thêm sản phẩm vào danh sách.
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16), // Khoảng cách giữa hai nút.
            Consumer<ProductsVM>(
              builder: (context, value, child) => ElevatedButton.icon(
                icon: Icon(
                  Icons.remove,
                  color: Colors.orange,
                  size: 10,
                ),
                label: Text('Delete'),
                onPressed: () {
                  value.del(0); // Xóa sản phẩm tại vị trí 0.
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
  );
}
