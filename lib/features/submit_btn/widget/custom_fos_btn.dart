import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomFosButton extends StatelessWidget {
  final VoidCallback submit;
  final bool disableButton;
  final String label;
  final bool isLoading;
  final double height;
  final int percent;
  final bool isLinearLoadingindicator;
  const CustomFosButton({
    super.key,
    required this.submit,
    required this.label,
    required this.isLoading,
    this.height = 50,
    required this.percent,
    required this.disableButton,
    required this.isLinearLoadingindicator,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disableButton || isLoading ? null : submit,
      child: isLoading
          ? isLinearLoadingindicator
              ? SpinKitThreeBounce(
                  color: context.primaryColor,
                  size: 20,
                )
              : CircularPercentIndicator(
                  radius: 20,
                  lineWidth: 4.0,
                  percent: percent / 100,
                  center: Text("$percent%"),
                  backgroundColor: Colors.blue.withOpacity(0.3),
                  progressColor: Colors.blue,
                )
          : Text(
              label,
              style: TextStyle(
                color: disableButton ? Colors.blue : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
