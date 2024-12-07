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
  var lstProStr = "";
  List<Product> itemList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Danh sách hàng hóa đã chọn",
            style: TextStyle(
              fontSize: 24,
              color: Colors.amber,
            )),
        Expanded(
          child: Consumer<ProductsVM>(
            builder: (context, value, child) => Scaffold(
              body: SafeArea(
                child: Scaffold(
                    body: ListView.builder(
                  itemCount: value.lst.length,
                  itemBuilder: (context, index) {
                    return itemListView(value.lst[index]);
                  },
                )),
              ),
            ),
          ),
        ),
        Consumer<ProductsVM>(
          builder: (context, value, child) => ElevatedButton.icon(
              icon: Icon(
                Icons.remove_shopping_cart,
                color: Colors.orange,
                size: 24,
              ),
              label: Text('Delete All'),
              onPressed: () {
                value.clear();
              },
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              )),
        )
      ],
    );
  }

  Widget itemListView(Product productModel) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            url_product_img + productModel.img!,
            height: 80,
            width: 80,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.image),
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productModel.name ?? '',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                NumberFormat('###,###.###').format(productModel.price),
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
              Text(
                productModel.des!,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
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
          )
        ],
      ),
    );
  }
}
