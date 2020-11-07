import 'package:fazenapp/models/cart_model.dart';
import 'package:fazenapp/models/user_model.dart';
import 'package:fazenapp/screens/home_screen.dart';
import 'package:fazenapp/screens/login_screen.dart';
import 'package:fazenapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child:ScopedModelDescendant<UserModel>(
          builder: (context, child, model){

            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'FazenTech-SHOP',
                  theme: ThemeData(
                      primarySwatch: Colors.brown,
                      primaryColor: Color.fromARGB(255, 139, 69, 19)
                  ),
                  home: HomeScreen()
              ),
            );
          }
        ),
    );
  }
}
