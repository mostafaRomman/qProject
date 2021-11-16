import 'package:flutter/material.dart';

myTextField({lable, controller, muController, lambdaController}) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        if (lable.toString() == 'M' ||
            lable.toString() == 'K' ||
            lable.toString() == 'X Range' ||
            lable.toString() == 'Y Range') return null;
        return 'empty field!';
      } else {
        if (value.contains('/')) {
          int i = value.indexOf('/');

          if (lable.toString() == 'μ') {
            muController.text = (double.parse(value.substring(0, i)) /
                    double.parse(value.substring(i + 1, value.length)))
                .toString();
            debugPrint('mu ====== ${muController.text}');
          }
          if (lable.toString() == 'λ') {
            lambdaController.text = (double.parse(value.substring(0, i)) /
                    double.parse(value.substring(i + 1, value.length)))
                .toString();
            debugPrint('lambda ======= ${lambdaController.text}');

          }
        }
        if (double.tryParse(value) == null) {
          return 'not number!';
        }
        if (double.parse(value).isNegative) {
          return 'negative number not allowed!';
        }
      }
    },
    controller: controller,
    decoration: InputDecoration(
      label: Text(lable.toString()),
      alignLabelWithHint: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  );
}
