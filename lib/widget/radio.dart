import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Radiopage extends StatefulWidget {
  final txtlbls;
  final diclbls;
  const Radiopage(this.txtlbls, this.diclbls);

  @override
  State<Radiopage> createState() => _RadioState();
}

class _RadioState extends State<Radiopage> {
  String? grpValue;
  String? lbltxt1;
  String? lbltxt2;
  String? lbltxt3;
  String? lbltxt4;
  String? lbltxt5;
  String? lbltxt6;

  @override
  void initState() {
    super.initState();
    _setlbltxt(widget.txtlbls, widget.diclbls);
  }

  _setlbltxt(String lbltext, Map<String, String> dic) {
    var items = lbltext.split('|');
    setState(() {
      lbltxt1 = lbltext.isEmpty ? dic['page4lbl1'] : items[0];
      lbltxt2 = lbltext.isEmpty ? dic['page4lbl2'] : items[1];
      lbltxt3 = lbltext.isEmpty ? dic['page4lbl2sub'] : items[2];
      lbltxt4 = lbltext.isEmpty ? dic['page4lbl3'] : items[3];
      lbltxt5 = lbltext.isEmpty ? dic['page4lbl3sub'] : items[4];
      lbltxt6 = lbltext.isEmpty ? dic['page4lbl4'] : items[5];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(
          top: 200,
        ),
        child: Column(
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                lbltxt1!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  grpValue = 'Shipper';
                });
              },
              child: Card(
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: RadioListTile(
                        value: 'Shipper',
                        groupValue: grpValue,
                        onChanged: (value) {
                          setState(() {
                            grpValue = value.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.warehouse_outlined,
                      size: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListTile(
                        title: Text(lbltxt2!),
                        subtitle: Text(lbltxt3!),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  grpValue = "Transporter";
                });
              },
              child: Card(
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: RadioListTile(
                        value: 'Transporter',
                        groupValue: grpValue,
                        onChanged: (value) {
                          setState(() {
                            grpValue = value.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListTile(
                        title: Text(lbltxt4!),
                        subtitle: Text(lbltxt5!),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(lbltxt6!),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 102, 84, 143))),
            ),
          ],
        ),
      ),
    );
  }
}
