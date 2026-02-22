part of 'constants.dart';

class ButtonCollections {
  static final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(color: ColorCollections.primaryColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    padding: PaddingCollections.buttonPadding,
    textStyle: const TextStyle(color: Colors.white),
  );
  
  static Widget primaryButton(String text) {
    return Container(
      decoration: BoxDecoration(
        color: ColorCollections.primaryColor,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: ColorCollections.primaryColor),
      ),
      padding: PaddingCollections.buttonPadding,
      child: Text(text, style: const TextStyle(color: Color(0xFFFFFFFF))),
    );
  }

  //login 
    static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF00B0FF), // Warna latar belakang
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0), // Sudut membulat
    ),
    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0), // Padding
  );
  
}