import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UploadButton extends StatelessWidget {
  final VoidCallback onClickGallery;
  final VoidCallback onClickCamera;

  final double height;
  final double width;
  final double fontSize;
  const UploadButton({
    super.key,
    required this.onClickGallery,
    required this.onClickCamera,
    this.height = 50,
    this.width = double.infinity,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: () {
        _tapeDialog(context);
      },
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.zero,
        child: _uploadImage(fontSize),
      ),
    );
  }

  Column _uploadImage(
    double fontSize, [
    String title = 'Загрузить фото...',
    String imagePath = './assets/icons/upload.svg',
  ]) {
    const sizedBoxHeight = 10.0;
    const sizedBoxWidth = 15.0;

    return Column(
      children: [
        const SizedBox(
          height: sizedBoxHeight,
        ),
        Row(
          children: [
            SvgPicture.asset(imagePath),
            const SizedBox(
              width: sizedBoxWidth,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<dynamic> _tapeDialog(BuildContext context) {
    const dialogTitle = 'Выберите источник изображения';
    const galleryTitle = 'Галерея';
    const cameraTitle = 'Камера';

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(dialogTitle),
        actions: <Widget>[
          TextButton(
            onPressed: onClickGallery,
            child: const Text(galleryTitle),
          ),
          TextButton(
            onPressed: onClickCamera,
            child: const Text(cameraTitle),
          ),
        ],
      ),
    );
  }
}
