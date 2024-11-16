import 'package:flutter/material.dart';


class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
        children: List.generate(errors.length,
                (index) => formErrorText(error: errors[index]))
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        Directionality(textDirection: TextDirection.rtl,
            child: Text(error,style: TextStyle(fontSize: 20,color: Colors.red)
              ,textDirection: TextDirection.rtl,)
        ),
      ],
    );
  }
}
