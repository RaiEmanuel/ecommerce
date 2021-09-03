import 'package:flutter/material.dart';
import 'wTextFormField.dart';
import 'wButton.dart';
import 'package:lottie/lottie.dart';
import 'package:line_icons/line_icons.dart';

class wFormLogin extends StatefulWidget {
  const wFormLogin({Key? key}) : super(key: key);

  @override
  _wFormLoginState createState() => _wFormLoginState();
}

class _wFormLoginState extends State<wFormLogin> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(//logo lottie
              padding: const EdgeInsets.only(left: 50),
              child: Container(
                  width: 250,
                  height: 250,
                  child: Lottie.network(
                      "https://assets6.lottiefiles.com/packages/lf20_kpDkDy/data.json",
                      width: 250,
                      height: 250)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: wTextFormField(hint: "Email", icon: Icons.email),
                width: 400,
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 20, right: 50),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: wTextFormField(hint: "Senha", icon: Icons.password, ),
                width: 400,
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50,top: 20, bottom: 20),
              child: Container(
                width: 300,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      shadowColor: Colors.red,
                      elevation: 0,
                      textStyle: TextStyle(
                        fontSize: 30
                      )
                    ),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        print("Valido");
                        bool valid = _formKey.currentState!.validate();
                        if(valid)
                          Navigator.pushNamed(context, '/');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                            "LOGAR",

                        ),
                        Icon(
                            Icons.login,
                          size: 40,
                        )
                      ],
                    )),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(left: 50, top: 10),
              child: wButton(
                width: 310,
                  height: 50,
                  text: "LOGAR",
                  icon: Icons.login,
                  //key: _formKey,
                  onTap: (){
                  print("=======> verifyyyyyyy");

                  }
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.facebook,
                        color: Colors.teal,
                        size: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          LineIcons.instagram,
                          color: Colors.teal,
                          size: 60,
                        )),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
