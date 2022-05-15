import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReelPage extends StatefulWidget {
  const ReelPage({Key? key}) : super(key: key);

  @override
  State<ReelPage> createState() => _ReelPageState();
}

class _ReelPageState extends State<ReelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: Text("This is Reel Page"))
        ],
      ),
    );
  }
}
