import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FinishPage extends StatefulWidget {
  final num bal;
  final num jemiBal;
  FinishPage({Key? key, required this.bal, required this.jemiBal})
      : super(key: key);

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
