import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'RouteProduct.dart';
import 'RouteLogin.dart';
import 'WTabPage.dart';
import 'PCartModel.dart';

void main() => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartModel(),
        )
      ],
      child: //Consumer<CartModel>(
        //builder: (context, cart, child){
          /*return*/ MaterialApp(
            initialRoute: '/login',
            routes: {
              '/': (BuildContext context) => TabPage(),
              '/product': (BuildContext context) => RouteProduct(),
              '/login': (BuildContext context) => RouteLogin()
            },
          )
       // },

      //),
    ));
