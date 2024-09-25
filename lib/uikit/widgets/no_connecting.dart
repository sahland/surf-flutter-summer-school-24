import 'package:flutter/material.dart';

class NoConnecting extends StatelessWidget {
  final Future<void> Function() onRetry;

  final double imageWidth;
  final double imageHeight;
  final double upsFontSize;
  final double errorFontSize;
  final double reloadFontSize;
  const NoConnecting({
    super.key,
    required this.onRetry,
    this.imageWidth = 74,
    this.imageHeight = 63,
    this.upsFontSize = 32,
    this.errorFontSize = 16,
    this.reloadFontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    const imagePath = './assets/images/smile.png';
    const upsTitle = 'Упс!';
    const errorTitle = 'Произошла ошибка.\nПопробуйте снова.';
    const reloadTitle = 'ПОПРОБОВАТЬ СНОВА';

    const sizedBoxHeight = 16.0;

    const greyColor = Colors.grey;
    const blueColor = Color(0xFF247487);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _noConnectingImage(imagePath),
          const SizedBox(height: sizedBoxHeight),
          Text(
            upsTitle,
            style: TextStyle(
              fontSize: upsFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            errorTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: greyColor,
              fontSize: errorFontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: sizedBoxHeight),
          _reloadButton(blueColor, reloadTitle)
        ],
      ),
    );
  }

  Image _noConnectingImage(String imagePath) {
    return Image.asset(
      imagePath,
      width: imageWidth,
      height: imageHeight,
    );
  }

  ElevatedButton _reloadButton(
    Color blueColor,
    String reloadTitle, [
    double elevation = 16,
  ]) {
    return ElevatedButton(
      onPressed: onRetry,
      style: ElevatedButton.styleFrom(
        backgroundColor: blueColor,
        elevation: elevation,
      ),
      child: Text(
        reloadTitle,
        style: TextStyle(
          fontSize: reloadFontSize,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
