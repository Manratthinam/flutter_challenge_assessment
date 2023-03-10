import 'package:flutter/material.dart';
import './phonenumber.dart';
import 'package:translator/translator.dart';
import '../model/translate.dart';

class Language extends StatefulWidget {
  Map<String, String> lstLabels;

  Language(this.lstLabels);
  @override
  State<Language> createState() => _LanguageState(this.lstLabels);
}

class _LanguageState extends State<Language> {
  Map<String, String> lstOfLabels;
  Map<String, String> outputDic = new Map();
  _LanguageState(this.lstOfLabels);
  String _elenentForNextPage = '';
  bool _enableSubmit = true;

  List<String> list = <String>['English-en', 'Tamil-ta', 'Hindi-hi'];
  String dropDownValue = '';

  Future<void> changeDropDown(String? selectedValue) async {
    setState(() {
      _enableSubmit = false;
    });
    List<String> translatedElement = [];
    for (var items in lstOfLabels.keys) {
      if (items.contains('page1')) {
        translatedElement.add(lstOfLabels[items]!);
      }
    }
    String element = translatedElement.join('|');
    Translate objToTranslate = new Translate();
    String translatedTxt =
        await objToTranslate.translate(element, selectedValue!);

    translatedElement = translatedTxt.split('|');

    setState(() {
      int count = 0;
      for (var items in lstOfLabels.keys) {
        if (items.contains('page1')) {
          lstOfLabels[items] = translatedElement[count];
          count += 1;
        }
      }

      dropDownValue = selectedValue as String;
      _enableSubmit = true;
    });
  }

  Future<void> nextPageElement(String? selectedValue) async {
    List<String> translatedElement = [];
    for (var items in lstOfLabels.keys) {
      if (items.contains('page2')) {
        translatedElement.add(lstOfLabels[items]!);
      }
    }
    String element = translatedElement.join('|');
    Translate objToTranslate = new Translate();
    String translatedTxt =
        await objToTranslate.translate(element, selectedValue!);

    setState(() {
      _elenentForNextPage = translatedTxt;
    });
  }

  String get txtLabel1 {
    return lstOfLabels['page1lbl1']!;
  }

  String get buttonLabel {
    return lstOfLabels['page1lbl3']!;
  }

  String get txtLabel2 {
    return lstOfLabels['page1lbl2']!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.area_chart_rounded,
          size: 60,
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          textAlign: TextAlign.center,
          txtLabel1,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Text(
            textAlign: TextAlign.center,
            txtLabel2,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 200,
          child: DropdownButtonFormField(
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem(
                child: Text(value.split('-')[0]),
                value: value.split('-')[1],
              );
            }).toList(),
            value: list.first.split('-')[1],
            onChanged: (value) async => await changeDropDown(value),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2),
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
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 102, 84, 143)),
            onPressed: _enableSubmit
                ? () async {
                    if (dropDownValue.isNotEmpty) {
                      await nextPageElement(dropDownValue);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneNumber(lstOfLabels,
                                _elenentForNextPage, dropDownValue)));
                  }
                : null,
            child: Text(buttonLabel),
          ),
        ),
      ],
    );
  }
}
