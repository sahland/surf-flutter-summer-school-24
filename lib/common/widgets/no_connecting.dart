import 'package:flutter/material.dart';

class NoConnecting extends StatelessWidget {
  final Future<void> Function() onRetry;

  const NoConnecting({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            './assets/images/smile.png',
            width: 74,
            height: 63,
          ),
          const SizedBox(height: 16),
          const Text(
            'Упс!',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          const Text(
            'Произошла ошибка.\nПопробуйте снова.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF247487), elevation: 16),
            child: const Text(
              'ПОПРОБОВАТЬ СНОВА',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
