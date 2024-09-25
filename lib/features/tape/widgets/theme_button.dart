import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:surf_flutter_summer_school_24/features/features.dart';

class ThemeButton extends StatefulWidget {
  final double height;
  final double width;
  final double fontSize;

  const ThemeButton({
    super.key,
    this.height = 50,
    this.width = double.infinity,
    this.fontSize = 18,
  });

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: () {
        setState(() {
          ThemeInherited.of(context).switchThemeMode();
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: EdgeInsets.zero,
        child: _themeConfig(context),
      ),
    );
  }

  Column _themeConfig(
    BuildContext context, [
    String title = 'Тема',
    String imagePath = './assets/icons/sun.svg',
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
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeInherited.of(context).themeMode,
              builder: (context, themeMode, _) {
                return _textTheme(themeMode);
              },
            ),
          ],
        ),
      ],
    );
  }

  Text _textTheme(ThemeMode themeMode) {
    const darkTitle = 'Темная';
    const lightTitle = 'Свветлая';

    return Text(
      themeMode == ThemeMode.dark ? darkTitle : lightTitle,
      style: TextStyle(
        color: Colors.grey,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
