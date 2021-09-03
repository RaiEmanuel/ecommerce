import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:vai_de_ecommerce/wButton.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class wCreditCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return wCreditCardState();
  }
}

class wCreditCardState extends State<wCreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Colors.purple,
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Número',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Data expiração',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome do titular',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                        child: wButton(
                          text: "COMPRAR",
                          height: 50,
                          width: double.infinity,
                          icon: Icons.shopping_cart,
                          onTap: () async{
                            //http.Response d = fetchAlbum() as http.Response;
                              http.Response res = await fetchAlbum();
                              //print(res.body);
                              Produto p1 = Produto.fromJson(jsonDecode(res.body));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text("s")));
                          },
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://fakestoreapi.com/products/1'));
}

class Produto{
  int id = 1;
  String titulo = "default", categoria = "default";
  double preco = 0.0;

  Produto(this.id, this.titulo, this.categoria, this.preco);

  Produto.fromJson(Map<String, dynamic> json): id = json['id'], titulo = json['title'], categoria = json['category'], preco = json['price'];
}