import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Error'),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
