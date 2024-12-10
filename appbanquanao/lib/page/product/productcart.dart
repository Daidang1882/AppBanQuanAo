import 'package:appbanquanao/config/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/const.dart';
import 'package:appbanquanao/data/model/productmodel.dart';
import 'package:provider/provider.dart';
import 'package:appbanquanao/data/model/product_viewmodel.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({Key? key}) : super(key: key);

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  void initState() {
    super.initState();
  }

  // Tính tổng giá trị giỏ hàng
  double getTotalPrice(List<Product> products) {
    double total = 0;
    for (var product in products) {
      total += (product.price ?? 0) *
          (product.quantity ?? 0); // Default to 0 if null
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Danh sách hàng hóa đã chọn",
          style: TextStyle(
            fontSize: 24,
            color: Colors.amber,
          ),
        ),
        // Hiển thị số lượng giỏ hàng ở góc trái
        Consumer<ProductsVM>(
          builder: (context, value, child) {
            int totalItems =
                value.lst.fold(0, (sum, item) => sum + (item.quantity ?? 0));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Số sản phẩm trong giỏ hàng: $totalItems",
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            );
          },
        ),
        Expanded(
          child: Consumer<ProductsVM>(
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.lst.length,
                itemBuilder: (context, index) {
                  return itemListView(value.lst[index], index);
                },
              );
            },
          ),
        ),
        // Hiển thị tổng tiền và nút thanh toán
        Consumer<ProductsVM>(
          builder: (context, value, child) {
            double totalPrice = getTotalPrice(value.lst); // Tổng tiền
            return Column(
              children: [
                Text(
                  "Tổng tiền: ${NumberFormat('###,###.###').format(totalPrice)} VND",
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.payment,
                    color: Colors.white,
                    size: 24,
                  ),
                  label: const Text('Thanh toán'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Thông báo"),
                          content: const Text("Thanh toán thành công!"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                value
                                    .clear(); // Xóa giỏ hàng sau khi thanh toán thành công
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        // Nút xóa tất cả sản phẩm
        Consumer<ProductsVM>(
          builder: (context, value, child) => ElevatedButton.icon(
            icon: const Icon(
              Icons.remove_shopping_cart,
              color: Colors.orange,
              size: 24,
            ),
            label: const Text('Delete All'),
            onPressed: () {
              value.clear(); // Xóa tất cả sản phẩm
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Hàm hiển thị sản phẩm
  Widget itemListView(Product productModel, int index) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            url_product_img + productModel.img!,
            height: 80,
            width: 80,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image),
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productModel.name ?? '',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                NumberFormat('###,###.###').format(productModel.price),
                style: const TextStyle(fontSize: 15, color: Colors.red),
              ),
              Text(
                productModel.des!,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<ProductsVM>(
                    builder: (context, value, child) => ElevatedButton.icon(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.orange,
                        size: 10,
                      ),
                      label: const Text('Add'),
                      onPressed: () {
                        value.add(productModel); // Thêm sản phẩm vào danh sách
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Khoảng cách giữa hai nút
                  Consumer<ProductsVM>(
                    builder: (context, value, child) => ElevatedButton.icon(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.orange,
                        size: 10,
                      ),
                      label: const Text('Delete'),
                      onPressed: () {
                        value.del(index); // Xóa sản phẩm tại vị trí index
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
              // Hiển thị số lượng sản phẩm trong giỏ hàng
              Text(
                "Số lượng: ${productModel.quantity}",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
