
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast2(String texto, Color color) {
  Fluttertoast.showToast(msg: "$texto", toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3, backgroundColor: color, textColor: Colors.white);
}


String dosDecimales(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 2 : 2);
}
