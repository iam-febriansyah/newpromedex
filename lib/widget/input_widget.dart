import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final double height;
  final String topLabel;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType textInputType;

  InputWidget(
      {this.hintText,
      this.prefixIcon,
      this.height = 48.0,
      this.topLabel = "",
      this.obscureText = false,
      this.controller,
      this.textInputType});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.topLabel),
        SizedBox(height: 5.0),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            keyboardType: textInputType,
            controller: controller,
            obscureText: this.obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 5, left: 10),
              prefixIcon: this.prefixIcon == null
                  ? this.prefixIcon
                  : Icon(
                      this.prefixIcon,
                      color: Color.fromRGBO(105, 108, 121, 1),
                    ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              hintText: this.hintText,
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(105, 108, 121, 0.7),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class InputWidgetDate extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final double height;
  final String topLabel;
  final bool obscureText;
  final TextEditingController controller;

  InputWidgetDate(
      {this.hintText,
      this.prefixIcon,
      this.height = 48.0,
      this.topLabel = "",
      this.obscureText = false,
      this.controller});

  @override
  _InputWidgetDateState createState() => _InputWidgetDateState();
}

class _InputWidgetDateState extends State<InputWidgetDate> {
  @override
  Widget build(BuildContext context) {
    void _selectDate() async {
      final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: DateTime(1990, 0, 0),
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2021, 1),
        helpText: 'Select a date',
      );
      if (newDate != null) {
        setState(() {
          widget.controller.text = newDate.toString().substring(0, 10);
        });
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.widget.topLabel),
        SizedBox(height: 5.0),
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            readOnly: true,
            onTap: () async {
              _selectDate();
            },
            controller: widget.controller,
            obscureText: this.widget.obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 5, left: 10),
              prefixIcon: this.widget.prefixIcon == null
                  ? this.widget.prefixIcon
                  : Icon(
                      this.widget.prefixIcon,
                      color: Color.fromRGBO(105, 108, 121, 1),
                    ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              hintText: this.widget.hintText,
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(105, 108, 121, 0.7),
              ),
            ),
          ),
        )
      ],
    );
  }
}
