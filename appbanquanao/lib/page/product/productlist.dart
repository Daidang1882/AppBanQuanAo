import 'package:flutter/material.dart';
import '../../data/model/productmodel.dart';
import '../../data/data/productdata.dart';
import 'productbody.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> lstProduct = [];

  Future<String> loadProdList() async {
    lstProduct = await ReadData().loadData();
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadProdList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: loadProdList(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return GridView.builder(
                  itemCount: lstProduct.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return itemGridView(lstProduct[index]);
                  });
            }),
      ),
    );
  }
}
