import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fonepay_flutter/fonepay_flutter.dart';
import 'package:one_byte_foods/models/orders.dart';
import 'package:one_byte_foods/services/database_service.dart';

import 'package:one_byte_foods/user/login.dart';
import 'package:provider/provider.dart';

class Booking extends StatefulWidget {
  final String resId;
  Booking({required this.resId});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String refId = '';
  String hasError = '';
  List<DateTime?> _dates = [
    DateTime.now(),
  ];
  DateTime? selectedDate;

  List<String> size = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  String dropdownValue = "1";

  List<String> time = ["9 am", "10 am", "11 am", "12 pm", "1 pm"];
  String selectedTime = "9 am";

  String _getValueText(
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');
    return valueText;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final _dbService = DatabaseService();
    String restaurantid = widget.resId;
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[350], borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Book Now"),
          Text("Select your party size"),
          DropdownButton(
              underline: Container(
                height: 2,
                color: Colors.black, // Set the underline color here
              ),
              hint: SizedBox(width: 300),
              value: dropdownValue,
              items: size.map<DropdownMenuItem<String>>((String value) {
                print(value);
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              }),
          Row(
            children: [
              Column(children: [
                Text("Select date"),
                Row(
                  children: [
                    Text(_getValueText(_dates)),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CalendarDatePicker2(
                                config: CalendarDatePicker2Config(),
                                value: _dates,
                                onValueChanged: (dates) {
                                  setState(() {
                                    _dates = dates;
                                  });

                                  Navigator.pop(context);
                                });
                            // Close the bottom sheet after selecting a date
                          },
                        );
                      },
                      child: Icon(Icons.calendar_month),
                    ),
                  ],
                )
              ]),
              SizedBox(width: 90),
              Column(
                children: [
                  Text("Select Time"),
                  DropdownButton(
                      underline: Container(
                        height: 2,
                        color: Colors.black, // Set the underline color here
                      ),
                      value: selectedTime,
                      items: time.map<DropdownMenuItem<String>>((String value) {
                        print(value);
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedTime = value!;
                        });
                      }),
                ],
              )
            ],
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    Orders order = new Orders(
                        resId: restaurantid,
                        size: this.dropdownValue,
                        selectedDate: _getValueText(_dates) as String,
                        time: this.selectedTime);
                    if (user?.uid == null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserLogin()));
                    } else {
                      String uid = user!.uid;
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Pay in advance?"),
                              actions: [
                                FonePayButton(
                                  paymentConfig: FonePayConfig.dev(
                                    amt: 10.0,
                                    r2: 'https://www.marvel.com/hello',
                                    ru: 'https://www.marvel.com/hello',
                                    r1: 'qwq',
                                    prn:
                                        'PD-2-${FonePayUtils.generateRandomString(len: 6)}',
                                  ),
                                  width: 100,
                                  onFailure: (result) async {
                                    setState(() {
                                      refId = '';
                                      hasError = result;
                                    });
                                    if (kDebugMode) {
                                      print(result);
                                    }
                                  },
                                  onSuccess: (result) async {
                                    setState(() {
                                      hasError = '';
                                      refId = result.uid!;
                                    });
                                    if (kDebugMode) {
                                      print(result.toJson());
                                    }
                                  },
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"))
                              ],
                            );
                          });

                      await _dbService.addOrders(order, uid);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Text("Restaurant reserved succesfully")));
                    }
                  },
                  child: Text("Book Now!")))
        ]));
  }
}
