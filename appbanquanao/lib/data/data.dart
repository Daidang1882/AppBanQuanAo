import 'package:appbanquanao/data/model/productmodel.dart';
import 'model/productmodel.dart';

createDataList(int amount) {
  List<Product> lstProduct = [];
  for (int i = 1; i <= amount; i++) {
    lstProduct.add(Product(
        id: i,
        name: "$i",
        price: (i * 10000000),
        img: "img_$i.jpg",
        des: "Quần áo"));
  }
  return lstProduct;
}
