import 'package:badges/badges.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vai_de_ecommerce/pCartModel.dart';
import 'package:vai_de_ecommerce/wTextFormField.dart';
import 'Product.dart';
import 'wCardproduct.dart';
import 'wText.dart';
import 'wCreditCard.dart';
import 'wButton.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int selectedIndex = 0;
  int badge = 0;
  final padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  double gap = 10;

  PageController controller = PageController();

  List<Color> colors = [
    //Color(0xFFEEEEEE),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0),
    Color(0xFFE0E0E0)
  ];

  List<Product> products = [
    new Product(url: "assets/product1.png", title: "PLACA NVIDIA 5432X",
        desc: "Ideal para seus jogos", value: 5899.99, favorite: true),
    new Product(url:"assets/product2.png", title:"TÊNIS NIKE AIR PLUS", desc:"Mais conforto para seu esporte",
        value: 1359.99, favorite: false),
    new Product(url:"assets/product3.png", title:"XBOX MAX",
        desc: "Mais desempenho e qualidade", value: 12899.99, favorite: true),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Builder(
        builder: (context) => PageView.builder(
          onPageChanged: (page) {
            setState(() {
              selectedIndex = page;
              //badge = badge + 1;
            });
          },
          controller: controller,
          itemBuilder: (context, position) {
            return Container(
              color: colors[position],
              child: wBody(position, context),
            );
          },
          itemCount: 4,
        ),
      ),
      bottomNavigationBar: wBottomNavigationBar(),
    );
  }

  SafeArea wBottomNavigationBar() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 60,
              color: Colors.black.withOpacity(.4),
              offset: Offset(0, 25),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
          child: GNav(
            tabs: [
              buildGButton("Home", Icons.home),
              buildGButtonWithBadge("Carrinho", Icons.shopping_cart),
              buildGButton("Pagamento", Icons.attach_money),
              buildGButton("Perfil", Icons.person),
              /*
              GButton(
                gap: gap,
                iconActiveColor: Colors.teal,
                iconColor: Colors.teal,
                textColor: Colors.teal,
                backgroundColor: Colors.teal.withOpacity(.2),
                iconSize: 24,
                padding: padding,
                icon: LineIcons.user,
                leading: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(
                    'https://sooxt98.space/content/images/size/w100/2019/01/profile.png',
                  ),
                ),
                text: 'Sheldon',
              )
               */

            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
              controller.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }

  Widget wBody(int position, BuildContext context) {
    Widget body = Column(
      children: [Text(position.toString())],
    );
    switch (position) {
      case 0:
        return ListView(children: [
          Column(
            //coluna principal
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*Lottie.network(
                  "https://assets4.lottiefiles.com/private_files/lf30_x2lzmtdl.json",
                  width: 200,
                  height: 200
                ),*/
              Container(
                width: 300,
                height: 150,
                child: wText(text: "Ecommerce, tudo o que você procura", color: Colors.teal,topPadding: 20,bottomPadding: 20, leftPadding: 20, fontHeight: 22),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 20),
                child: wRowSearch(),
              ),
              wText(text: "Mais vendidos", color: Colors.teal, leftPadding: 20, fontHeight: 20),
              wCardProduct(products, context)
            ],
          ),
        ]);
      case 1:
        Faker faker = Faker();
        CartModel cart = Provider.of<CartModel>(context);
        return Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.teal,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        wText(text: "Total = ${cart.totalPrice}", color: Colors.white, fontHeight: 20),
                        wButton(
                            height: 50,
                            width: 220,
                            icon: Icons.shopping_cart,
                            colorIcon: Colors.teal,
                            sizeText: 18,
                            colorText: Colors.teal,
                            color: Colors.white,
                            text: "Finalizar compra",
                            onTap: () {
                              // Navigator.pushNamed(context, '/');
                              setState(() {
                                selectedIndex = 2;
                                //badge = badge + 1;
                              });
                              controller.jumpToPage(2);
                              cart.removeAll();
                            }
                        )
                        /*ElevatedButton(
                            onPressed: , child: Text("Finalizar compra"))*/
                      ],
                    ),
                  ),
                  Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: cart.getQuantity(),
                      itemBuilder: (context, index) => ListTile(
                        leading: Icon(Icons.airplay_rounded),
                        title: Text(cart.products[index].title),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle_outlined),
                          onPressed: () {
                            cart.remove(cart.products[index]);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )),
        );

      case 2:
      return wCreditCard();

      case 3:
      return Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                  width: double.infinity,
                  height: 200,
                  child: Text("s"),
                  decoration: BoxDecoration(
                    /* borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0)),*/
                    color: Colors.teal,
                  )),
              Positioned(
                bottom: -80,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://sooxt98.space/content/images/size/w100/2019/01/profile.png',
                  ),
                  radius: 80,
                ),
              )
            ],
          )
        ],
      );

    /*MultiProvider(
          providers: [ChangeNotifierProvider(create: (context) => CartModel())],
          child: Consumer<CartModel>(
            builder: (context, cart, child) {
              return Scaffold(
                body: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Container(
                      color: Colors.teal,
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Total = ${cart.totalPrice}"),
                          ElevatedButton(
                              onPressed: () {
                                cart.removeAll();
                              }, child: Text("Finalizar compra"))
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          var cart = context.read<CartModel>();
                          cart.add(Product(
                              "https://a-static.mlcdn.com.br/618x463/iphone-12-apple-64gb-azul-tela-61-12mp-ios/magazineluiza/231147600/9042be45286cf90a982db47daadfcaeb.jpg",
                              faker.internet.userName(),
                              faker.lorem.sentence(),
                              43,
                              true));
                        },
                        child: child),
                    Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: cart.getQuantity(),
                        itemBuilder: (context, index) => ListTile(
                          leading: Icon(Icons.airplay_rounded),
                          title: Text(cart.products[index].title!),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle_outlined),
                            onPressed: () {
                              cart.remove(cart.products[index]);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              );
            },
          ),
        );*/
      default:
        return body;
    }
  }

  Row wRowSearch() {
    return Row(
      //search bar
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: wTextFormField(
                hint: "O que deseja?", icon: Icons.search_rounded,sizeIcon: 30,),
            width: 250,
            height: 50,
          ),
        ),
        wButton(
          width: 50,
          height: 50,
          sizeIcon: 30,
          onTap: () async {
            var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
            var response = await http.get(url);
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
          },
        ),
      ],
    );
  }

  GButton buildGButtonWithBadge(String text, IconData icon) {
    CartModel cart = Provider.of<CartModel>(context);
    return GButton(
      gap: gap,
      iconActiveColor: Colors.teal,
      iconColor: Colors.teal,
      textColor: Colors.teal,
      backgroundColor: Colors.teal.withOpacity(.2),
      iconSize: 24,
      padding: padding,
      icon: icon,
      text: text,
      leading: Badge(
        elevation: 0,
        badgeColor: Colors.amber,
        position: BadgePosition.topEnd(top: -12, end: -12),
        badgeContent: Text(
          cart.getQuantity().toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: Icon(
          Icons.shopping_cart,
          color: Colors.teal,
        ),
      ),
      /*
      leading: selectedIndex == 1 || badge == 0
                        ? null
                        : Badge(
                            badgeColor: Colors.red.shade100,
                            elevation: 0,
                            position: BadgePosition.topEnd(top: -12, end: -12),
                            badgeContent: Text(
                              badge.toString(),
                              style: TextStyle(color: Colors.red.shade900),
                            ),
                            child: Icon(
                              LineIcons.heart,
                              color: selectedIndex == 1
                                  ? Colors.pink
                                  : Colors.black,
                            ),
                          ),
                    text: 'Likes',
                  ),


       */
    );
  }
  GButton buildGButton(String text, IconData icon) {
    return GButton(
      gap: gap,
      iconActiveColor: Colors.teal,
      iconColor: Colors.teal,
      textColor: Colors.teal,
      backgroundColor: Colors.teal.withOpacity(.2),
      iconSize: 24,
      padding: padding,
      icon: icon,
      text: text,

      /*
      leading: selectedIndex == 1 || badge == 0
                        ? null
                        : Badge(
                            badgeColor: Colors.red.shade100,
                            elevation: 0,
                            position: BadgePosition.topEnd(top: -12, end: -12),
                            badgeContent: Text(
                              badge.toString(),
                              style: TextStyle(color: Colors.red.shade900),
                            ),
                            child: Icon(
                              LineIcons.heart,
                              color: selectedIndex == 1
                                  ? Colors.pink
                                  : Colors.black,
                            ),
                          ),
                    text: 'Likes',
                  ),
       */
    );
  }
}