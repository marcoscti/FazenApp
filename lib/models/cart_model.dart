import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazenapp/datas/cart_product.dart';
import 'package:fazenapp/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
class CartModel extends Model{
  UserModel user;

  List<CartProduct> products = [];
  bool isLoading = false;
  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItem();
  }

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct){
  products.add(cartProduct);
  Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").add(cartProduct.toMap()).then((doc){
    cartProduct.cid = doc.documentID;
  });
  notifyListeners();
  }
  void removeCartItem(CartProduct cartProduct){
  Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).delete();
   products.remove(cartProduct);
   notifyListeners();
  }

  void decProduct(CartProduct cartProduct){
    cartProduct.quantity--;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());
    notifyListeners();
  }
  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());
    notifyListeners();
  }
  void _loadCartItem() async{
    QuerySnapshot query= await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
        .getDocuments();
    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }
  void updatePrices(){
    notifyListeners();
  }
  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct c in products){
      if(c.productData != null)
        price += c.quantity * c.productData.price;
    }
    return price;
  }
  Future<String> finishOrder() async{
    if(products.length == 0) return null;
    isLoading = true;
    notifyListeners();
    double productsPrice = getProductsPrice();
    DocumentReference refOrder = await Firestore.instance.collection("order").add(
      {
        "clientId": user.firebaseUser.uid,
        "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
        "productsPrice": productsPrice,
        "status": 1
      }
    );
    await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders").document(refOrder.documentID).setData(
      {
        "orderId": refOrder.documentID
      }
    );
    
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).
    collection("cart").getDocuments();
    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }
    products.clear();
    isLoading = false;
    notifyListeners();
    return refOrder.documentID;
  }
}