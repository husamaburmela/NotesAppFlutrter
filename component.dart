import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Components Page
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII

//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Custom TextField1 1
class CustomTextField1 extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  const CustomTextField1(
      {super.key,
      required this.hint,
      required this.mycontroller,
      required this.valid});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: TextFormField(
            validator: valid,
            controller: mycontroller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              hintText: hint,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            )));
  }
}

//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII ElevatedButton Button_style_2
final ButtonStyle Button_style_2 = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    side: BorderSide(color: Colors.red, width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    textStyle: Font_style_1);
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII ElevatedButton Button_style_1
ElevatedButtonThemeData Button_style_1 = ElevatedButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        side: BorderSide(color: Colors.red, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: Font_style_1));
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Colors
Color colortest1 = Color.fromARGB(255, 201, 12, 144);
Color colortest2 = Color(0xFF3ACE26);
Color colortest3 = Color.fromRGBO(176, 7, 7, 1);
Color colortest4 = Color(0xfffffde);
FontWeight light = FontWeight.w500;

//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIFont style 1
TextStyle Font_style_1 = GoogleFonts.archivoNarrow(
  textStyle: TextStyle(
      color: Color.fromARGB(255, 255, 0, 153),
      letterSpacing: 5,
      fontFamily: "Poor_Story"),
);

//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Dark and Light Theme
class Themes {
  static ThemeData CustomDarkTheme =
      ThemeData.dark().copyWith(appBarTheme: AppBarTheme(color: Colors.red));
  static ThemeData CustomLightTheme =
      ThemeData.light().copyWith(appBarTheme: AppBarTheme(color: Colors.green));
}

//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII ElevatedButton style
// ElevatedButton(
//       child: Text('Button'),
//       onPressed: () {},
//       style: ElevatedButton.styleFrom({
//            Color primary, // set the background color
//            Color onPrimary,
//            Color onSurface,
//            Color shadowColor,
//            double elevation,
//            TextStyle textStyle,
//            EdgeInsetsGeometry padding,
//            Size minimumSize,
//            BorderSide side,
//            OutlinedBorder shape,
//            MouseCursor enabledMouseCursor,
//            MouseCursor disabledMouseCursor,
//            VisualDensity visualDensity,
//            MaterialTapTargetSize tapTargetSize,
//            Duration animationDuration,
//            bool enableFeedback
//      }),
// ),

//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII for validation for text form
validInput(String val, int min, int max) {
  if (val.length > max && !val.isEmpty) {
    return "$messageInputMax $max ";
  }

  if (val.length < min && !val.isEmpty) {
    return "$messageInputMin $min ";
  }
  if (val.isEmpty) {
    return "$messageInputEmpty";
  }
}

//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII masseges
const String messageInputEmpty = "لا يمكن ان يكون هذا الحقل فارغ";
const String messageInputMin = "لا يمكن ان يكون هذا الحقل اصغر من";
const String messageInputMax = "لا يمكن ان يكون هذا الحقل اكبر من";


       