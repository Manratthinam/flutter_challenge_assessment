import 'package:flutter/material.dart';
import './language.dart';

class Home extends StatelessWidget {
  Map<String, String> lstLabels = {
    'page1lbl1': 'Please select your Language',
    'page1lbl2': 'you can change the language\n at any time',
    'page1lbl3': 'Next',
    'page2lbl1': 'Please enter your mobile number',
    'page2lbl2': 'you\'ll recieve a 4 digit code\n to verify next',
    'page2lbl3': 'continue',
    'page3lbl1': 'Verify Phone',
    'page3lbl2': 'Code is sent to',
    'page3lbl3': 'Didn\'t recieve the code?',
    'page3lbl4': 'Request Again',
    'page3lbl5': 'Submit',
    'page4lbl1': 'Please select your profile',
    'page4lbl2': 'Shipper',
    'page4lbl2sub': 'some example for the shipper given here',
    'page4lbl3': 'Transporter',
    'page4lbl3sub': 'some example for the transporter given here',
    'page4lbl4': 'Continue',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 240,
            ),
            width: 700,
            child: Language(lstLabels),
          ),
        ),
      ),
    );
  }
}
