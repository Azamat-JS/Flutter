import 'package:flutter/material.dart';

class ExpandedFlexiblePage extends StatelessWidget {
  const ExpandedFlexiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expanded and Flexible')),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.teal,
                  height: 50.0,
                  child: Text('Expanded'),
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.red,
                  height: 50.0,
                  child: Text('Flexible'),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  color: Colors.red,
                  height: 50.0,
                  child: Text('Flexible'),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.teal,
                  height: 50.0,
                  child: Text('Expanded'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
