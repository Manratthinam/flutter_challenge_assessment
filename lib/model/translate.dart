import 'package:translator/translator.dart';

class Translate {
  Future<String> translate(String txt, String toTxt) async {
    final googleTranslator = GoogleTranslator();
    var translate = await googleTranslator.translate(
      txt,
      to: toTxt,
    );
    return translate.text;
  }
}
