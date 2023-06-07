import 'package:flutter/material.dart';

class Internet extends StatelessWidget {
  const Internet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off),
            SizedBox(
              width: 20,
            ),
            Text('Internet is not available'),
          ],
        ),
      ),
    );
  }
}
