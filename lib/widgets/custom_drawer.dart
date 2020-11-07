import 'package:fazenapp/models/user_model.dart';
import 'package:fazenapp/screens/login_screen.dart';
import 'package:fazenapp/tiles/drawer_tiles.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class CustomDrawer extends StatelessWidget {
  final PageController pageController;
  CustomDrawer(this.pageController);
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 33.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 150.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text('FazenTech\nShop', style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold,),),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                      builder: (context, child, model){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Olá, ${!model.isLoggedIn() ? "" : model.userData['name']}",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //Configuração do Botão cadastre-se abaixo
                            GestureDetector(
                              child: Text(
                                !model.isLoggedIn() ?
                                "Entre ou Cadastre-se +" : "Sair",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              onTap: (){
                                if(!model.isLoggedIn())
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>LoginScreen())
                                );
                                else
                                  model.signOut();
                              },
                            ) //Fim do botão cadastre-se
                          ],
                        );
                      },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início",pageController,0),
              DrawerTile(Icons.list, "Produtos",pageController,1),
              DrawerTile(Icons.location_on, "Distribuidores",pageController,2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos",pageController,3),
            ],
          )
        ],
      ),
    );
  }
}
