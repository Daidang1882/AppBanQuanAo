import 'package:appbanquanao/data/model/cartcounter.dart';
import 'package:appbanquanao/data/model/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:appbanquanao/data/model/categorymodel.dart';
import '../../data/provider/productprovider.dart';
import '../../data/model/productmodel.dart';
import 'productbody.dart';
import 'package:appbanquanao/page/product/productlist.dart';
import 'package:appbanquanao/page/product/productcart.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final Category objCat;

  const ProductWidget({super.key, required this.objCat});

  @override
  // ignore: library_private_types_in_public_api
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  List<Product> products = [];

  // Tải danh sách sản phẩm theo danh mục
  Future<void> loadProdList(int catId) async {
    products = await ReadData().loadDataByCat(catId);
    setState(() {}); // Cập nhật giao diện
  }

  @override
  void initState() {
    super.initState();
    loadProdList(widget.objCat.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              // chuyển về tab 2 - Product
              _onItemTapped(2);
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(Icons.shopping_bag, size: 30),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Consumer<ProductsVM>(
                      builder: (context, value, child) => CartCounter(
                        count: value.lst.length.toString(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        title: Text(
          'Sản phẩm: ${widget.objCat.name.toString().toUpperCase()}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: products.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return itemGridView(products[index]);
                },
              ),
      ),
    );
  }
}

int _selectedIndex = 0;
void _onItemTapped(int index) {}
