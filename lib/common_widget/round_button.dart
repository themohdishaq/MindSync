import 'package:flutter/material.dart';
import 'package:nayapakistan/common/color_extension.dart';

enum RoundButtonType { bgGradient, textGradient }

class RoundButton extends StatelessWidget {
  final RoundButtonType type;
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final double elevation;
  final VoidCallback onPressed;
  const RoundButton(
      {super.key,
      required this.title,
      this.type = RoundButtonType.textGradient,
      this.fontSize = 16,
      this.elevation = 1,
      this.fontWeight = FontWeight.w700,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: TColor.primaryG,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(25),
        boxShadow: type == RoundButtonType.bgGradient
            ? const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))
              ]
            : null,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textColor: TColor.primaryColor1,
        minWidth: double.maxFinite,
        elevation: type == RoundButtonType.bgGradient ? 0 : 1,
        color: type == RoundButtonType.bgGradient
            ? Colors.transparent
            : TColor.white,
        child: type == RoundButtonType.bgGradient
            ? Text(title,
                style: TextStyle(
                    color: TColor.white,
                    fontSize: fontSize,
                    fontWeight: fontWeight))
            : ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                          colors: TColor.primaryG,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)
                      .createShader(
                          Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                },
                child: Text(
                  title,
                  style: TextStyle(
                      color: TColor.primaryColor1,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
      ),
    );
  }
}

class UiHelper {
  static Widget customTextField({
    required TextEditingController controller,
    required String label,
    required IconData iconData,
    required bool toHide,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}

Future<void> customAlertBox(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        );
      });
}
