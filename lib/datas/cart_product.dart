import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazenapp/datas/product_data.dart';

class CartProduct{
  String cid;
  String category;
  String pid;
  int quantity;
  ProductData productData;
CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    category = document.data['category'];
    pid = document.data['pid'];
    quantity = document.data['quantity'];

  }

  Map<String, dynamic> toMap(){
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      //"product": productData.toResumedMap()
    };
  }
}