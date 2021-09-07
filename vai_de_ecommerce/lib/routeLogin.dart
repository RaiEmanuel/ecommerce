import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vai_de_ecommerce/wButton.dart';
import 'package:vai_de_ecommerce/wFormlogin.dart';
import 'wTextFormField.dart';

class routeLogin extends StatelessWidget {
  const routeLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "Ecommerce",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            wFormLogin()],
        ),
        
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [Colors.black,Colors.black]
            )
        ),
      ),
    );
  }
}
