import 'package:flutter/material.dart';
import './otpvalidate.dart';
import 'package:flag/flag.dart';
import '../model/translate.dart';

class PhoneNumber extends StatefulWidget {
  final txtPhoneController = TextEditingController();
  final txtTranslatedLabel;
  final converttxtTo;
  Map<String, String> lstOfLabels;

  PhoneNumber(this.lstOfLabels, this.txtTranslatedLabel, this.converttxtTo);
  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final _phoneFieldController = TextEditingController();
  bool _isValid = false;
  String? txtLbl1;
  String? txtLbl2;
  String? txtLbl3;
  void txtLabels(String values, Map<String, String> dicOfLabels) {
    var items = values.split('|');
    setState(() {
      txtLbl1 = values.isEmpty ? dicOfLabels['page2lbl1'] : items[0];
      txtLbl2 = values.isEmpty ? dicOfLabels['page2lbl2'] : items[1];
      txtLbl3 = values.isEmpty ? dicOfLabels['page2lbl3'] : items[2];
    });
  }

  Future<void> _validatePhoneNumber() async {
    final number = _phoneFieldController.text;

    if (number.isEmpty || number.length < 10) {
      setState(() {
        _isValid = true;
      });
      return;
    } else {
      String lblForNxt = widget.converttxtTo.toString().isNotEmpty
          ? await nextPageElement(widget.converttxtTo, widget.lstOfLabels)
          : '';
      setState(() {
        _isValid = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpValidate(
              number, lblForNxt, widget.lstOfLabels, widget.converttxtTo),
        ),
      );
    }
  }

  Future<String> nextPageElement(
      String? selectedValue, Map<String, String> lstOfLabels) async {
    List<String> translatedElement = [];
    for (var items in lstOfLabels.keys) {
      if (items.contains('page3')) {
        translatedElement.add(lstOfLabels[items]!);
      }
    }
    String element = translatedElement.join('|');
    Translate objToTranslate = new Translate();
    String translatedTxt =
        await objToTranslate.translate(element, selectedValue!);

    return translatedTxt as String;
  }

  @override
  Widget build(BuildContext context) {
    txtLabels(widget.txtTranslatedLabel, widget.lstOfLabels);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 300),
              child: Column(
                children: [
                  Text(
                    txtLbl1!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    txtLbl2!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _phoneFieldController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: TextStyle(
                        letterSpacing: 2,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Flag.fromCode(
                            FlagsCode.IN,
                            width: 20,
                            height: 20,
                            fit: BoxFit.fill,
                          ),
                        ),
                        errorBorder: _isValid == true
                            ? OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red))
                            : null,
                        prefixText: '+91',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: _isValid == true ? Colors.red : Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: _isValid == true ? Colors.red : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () async {
                          await _validatePhoneNumber();
                        },
                        child: Text(
                          txtLbl3!,
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromARGB(255, 102, 84, 143))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
