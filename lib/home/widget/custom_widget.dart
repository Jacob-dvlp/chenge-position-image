import 'package:chenge_position_img/const/image.dart';
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final int chengePositionImage;
  const CustomWidget({
    Key? key,
    required this.chengePositionImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: RotatedBox(
              quarterTurns: chengePositionImage,
              child: Image.asset(myPhoto,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fitHeight),
            ),
          ),
        ),
      ],
    );
  }
}
