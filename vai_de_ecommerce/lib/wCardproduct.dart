import 'package:flutter/material.dart';
import 'package:vai_de_ecommerce/wButton.dart';
import 'Product.dart';
import 'wText.dart';

Widget wCardProduct(List<Product> products, BuildContext context) {
  return Container(
    height: 350,
    width: 500,
    child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal, children: [
      wCard(products[0], context),
      wCard(products[1], context),
      wCard(products[2], context),
    ]
    ),
  );
}

Card wCard(Product p, BuildContext context) {
   IconData favorite;
  if(p.favorite){
    favorite = Icons.favorite;
  }else{
    favorite = Icons.favorite_border;
  }
  return Card(
    color: Colors.white70,
    shadowColor: Colors.black26,
    child: Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Positioned(
          right: 5,
          top: 10,
          child: TextButton(
            child: Icon(
              favorite,
              color: Colors.purple,
            ),
            onPressed: () {
              p.favorite = true;
            },
          ),
        ),
        Column(//coluna geral
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 150,
                height: 150,
                child: Image.asset(
                  p.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(//coluna interna
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: wText(text: p.title, color: Colors.blueGrey, fontHeight: 20)
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: wText(text: p.desc, color: Colors.blueGrey, fontHeight: 16)),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: wText(text: "R\$ ${p.value}", color: Colors.blueGrey, fontHeight: 20)),
                wButton(width: 200,text: "Ver Mais", p: p, onTap: (){
                  Navigator.pushNamed(context, '/product', arguments: p);
                }, color: Colors.teal,),

                /*ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, "/product", arguments: p);
                    },
                    child: Text("Ver mais")
                )*/
              ],
            ),
          ],
        ),
      ],
    ),
  );

}
