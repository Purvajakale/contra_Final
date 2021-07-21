import 'package:flutter/material.dart';
import 'package:contra_care/features/reminders//helpers/platform_slider.dart';

class UserSlider extends StatelessWidget {
  final Function handler;
  final int howManyWeeks;
  UserSlider(this.handler,this.howManyWeeks);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: PlatformSlider(
              divisions: null,
              min: 1,
              max: 28,
              value: howManyWeeks,
              color: Color(0xffF38BA0),
              handler:  this.handler,)),
      ],
    );
  }
}
