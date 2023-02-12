import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './radio.dart';
import '../model/translate.dart';

class OtpValidate extends StatefulWidget {
  final phoneNumber;
  final lblText;
  final dicLabel;
  final convertTo;

  OtpValidate(this.phoneNumber, this.lblText, this.dicLabel, this.convertTo);

  @override
  State<OtpValidate> createState() => _OtpValidateState();
}

class _OtpValidateState extends State<OtpValidate> {
  String _status = '';
  var _verificationId = '';
  int? _resendtoken;
  final _auth = FirebaseAuth.instance;
  bool _enableSubmit = false;

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${phoneNo}',
      verificationCompleted: (credentials) {},
      verificationFailed: (ex) {
        if (ex.code == 'invalid-phone-number') {
        } else if (ex.code == 'too-many-requests') {
          setState(() {
            this._status =
                'Too many Attempts this phone number\n has been blocked try again later';
          });
        }
      },
      codeSent: (verificationId, resendToken) {
        this._verificationId = verificationId;
        this._resendtoken = resendToken;
        setState(() {
          _enableSubmit = true;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this._verificationId = verificationId;
      },
      forceResendingToken: _resendtoken,
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: this._verificationId, smsCode: otp),
    );
    return credentials.user != null ? true : false;
  }

  String? lbltxt1;
  String? lbltxt2;
  String? lbltxt3;
  String? lbltxt4;
  String? lbltxt5;
  void lblForText(String text, Map<String, String> lstOfLabels) {
    var items = text.split('|');
    setState(() {
      lbltxt1 = text.isEmpty ? lstOfLabels['page3lbl1'] : items[0];
      lbltxt2 = text.isEmpty ? lstOfLabels['page3lbl2'] : items[1];
      lbltxt3 = text.isEmpty ? lstOfLabels['page3lbl3'] : items[2];
      lbltxt4 = text.isEmpty ? lstOfLabels['page3lbl4'] : items[3];
      lbltxt5 = text.isEmpty ? lstOfLabels['page3lbl5'] : items[4];
    });
  }

  Widget getOtpWidget() {
    return Row(
      children: List.generate(6, (index) {
        return TextField(
          maxLength: 1,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
          ),
          onChanged: ((value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          }),
        );
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _setCredentials();
    setState(() {
      lstOtpController.add(_otpController1);
      lstOtpController.add(_otpController2);
      lstOtpController.add(_otpController3);
      lstOtpController.add(_otpController4);
      lstOtpController.add(_otpController5);
      lstOtpController.add(_otpController6);
    });
  }

  Future<void> _setCredentials() async {
    await phoneAuthentication(widget.phoneNumber);
  }

  List<TextEditingController> lstOtpController = [];
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final _otpController5 = TextEditingController();
  final _otpController6 = TextEditingController();

  Future<void> _validateOtpTxtBox() async {
    String? otp;
    final controller1 = _otpController1.text;
    final controller2 = _otpController2.text;
    final controller3 = _otpController3.text;
    final controller4 = _otpController4.text;
    final controller5 = _otpController5.text;
    final controller6 = _otpController6.text;
    bool returnifempty = false;
    setState(() {
      if (controller1.isEmpty) {
        returnifempty = true;
      } else if (controller2.isEmpty) {
        returnifempty = true;
      } else if (controller3.isEmpty) {
        returnifempty = true;
      } else if (controller4.isEmpty) {
        returnifempty = true;
      } else if (controller5.isEmpty) {
        returnifempty = true;
      } else if (controller6.isEmpty) {
        returnifempty = true;
      } else {
        otp = controller1 +
            controller2 +
            controller3 +
            controller4 +
            controller5 +
            controller6;
      }
    });

    if (returnifempty) {
      return;
    }
    bool _isvalid = await verifyOTP(otp!);
    if (_isvalid) {
      String value = widget.convertTo.isEmpty
          ? ''
          : await _getLblText(widget.convertTo, widget.dicLabel);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Radiopage(value, widget.dicLabel)));
    }
  }

  Future<String> _getLblText(String? To, Map<String, String> dicLbl) async {
    List<String> translatedElement = [];
    for (var items in dicLbl.keys) {
      if (items.contains('page4')) {
        translatedElement.add(dicLbl[items]!);
      }
    }
    String element = translatedElement.join('|');
    Translate objToTranslate = new Translate();
    String translatedTxt = await objToTranslate.translate(element, To!);

    return translatedTxt as String;
  }

  @override
  Widget build(BuildContext context) {
    lblForText(widget.lblText, widget.dicLabel);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_double_arrow_left,
          )),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(children: [
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 100,
              ),
              child: Column(
                children: [
                  Text(
                    lbltxt1!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    '${lbltxt3!} ${widget.phoneNumber}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 45,
                    ),
                    child: Row(
                      children: lstOtpController.map((e) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          child: SizedBox(
                            width: 40,
                            child: TextField(
                              controller: e,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              onChanged: (value) {
                                setState(() {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  } else {
                                    FocusScope.of(context).previousFocus();
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 174, 218, 254),
                                border: OutlineInputBorder(),
                                counterText: '',
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(lbltxt3!),
                  TextButton(
                    onPressed: () async {
                      await phoneAuthentication(widget.phoneNumber);
                    },
                    child: Text(lbltxt4!),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _enableSubmit
                          ? () async {
                              await _validateOtpTxtBox();
                            }
                          : null,
                      child: Text(
                        lbltxt5!,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 102, 84, 143)),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  _status.isNotEmpty
                      ? SizedBox(
                          width: 500,
                          child: Text(
                            _status,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
