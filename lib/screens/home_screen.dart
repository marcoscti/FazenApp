import 'package:fazenapp/tabs/home_tab.dart';
import 'package:fazenapp/tabs/products_tab.dart';
import 'package:fazenapp/widgets/cart_button.dart';
import 'package:fazenapp/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController ,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer:CustomDrawer(_pageController),
          floatingActionButton: Cartbutton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Categorias"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: Cartbutton(),
        ),
      ],
    );
  }
}
