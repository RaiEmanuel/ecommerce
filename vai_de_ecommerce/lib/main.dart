import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routeProduct.dart';
import 'routeLogin.dart';
import 'wTabPage.dart';
import 'pCartModel.dart';

void main() => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=>CartModel(),
        )
      ],
      child: //Consumer<CartModel>(
        //builder: (context, cart, child){
          /*return*/ MaterialApp(
            initialRoute: '/login',
            routes: {
              '/': (BuildContext context) => TabPage(),
              '/product': (BuildContext context) => routeProduct(),
              '/login': (BuildContext context) => routeLogin()
            },
          )
       // },

      //),
    ));
