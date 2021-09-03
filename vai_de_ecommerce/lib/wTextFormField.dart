import 'package:flutter/material.dart';

class wTextFormField extends StatelessWidget {
  String hint;
  IconData icon;
  double sizeIcon;
  //final String? Function(String?)? validator;
  //TextEditingController _controller = TextEditingController();
  TextEditingController _controller = TextEditingController();


  wTextFormField({Key ? key, this.hint = "Default hint", this.icon = Icons.broken_image_outlined, this.sizeIcon = 15}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      cursorColor: Colors.black,
      keyboardType: TextInputType.visiblePassword,
      decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 0, bottom: 11, top: 11, right: 15),
          hintText: hint,
          icon: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(icon),
          )),
          validator: (value){
            if(value!.isEmpty || value == null)
              return "Campo não pode ser vazio!";
          },
    );
  }
}
