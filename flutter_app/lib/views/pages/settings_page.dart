import 'package:flutter/material.dart';
import 'package:flutter_app/views/pages/expanded_flexible_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller = TextEditingController();
  bool isChecked = false;
  bool isSwitched = false;
  double sliderValue = 0.0;
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('This is a snackbar'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text('Open snackbar!'),
              ),
              Divider(color: Colors.teal, thickness: 4, endIndent: 200),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Alert Dialog'),
                        content: Text('This is an alert dialog'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text('Open Alert dialog!'),
              ),
              DropdownButton(
                value: dropdownValue,
                items: [
                  DropdownMenuItem(value: 'element1', child: Text('Element 1')),
                  DropdownMenuItem(value: 'element2', child: Text('Element 2')),
                  DropdownMenuItem(value: 'element3', child: Text('Element 3')),
                ],
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value;
                  });
                },
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(border: OutlineInputBorder()),
                onEditingComplete: () => setState(() {}),
              ),
              Text(controller.text),
              Checkbox.adaptive(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
              CheckboxListTile.adaptive(
                title: Text("Check me"),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
              Switch.adaptive(
                value: isSwitched,
                onChanged: (bool? value) {
                  setState(() {
                    isSwitched = value ?? false;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title: Text("Switch me"),
                value: isSwitched,
                onChanged: (bool? value) {
                  setState(() {
                    isSwitched = value ?? false;
                  });
                },
              ),
              Slider.adaptive(
                max: 10.0,
                value: sliderValue,
                divisions: 10,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              Text("Slider value: $sliderValue"),
              InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  print('Image tapped');
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white12,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ExpandedFlexiblePage();
                            },
                          ),
                        );
                      },
                      child: Text('Show flexible and Expanded!'),
                    ),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: Text('Click me!'),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.red,
                      ),
                      child: Text('Click me!'),
                    ),
                    OutlinedButton(onPressed: () {}, child: Text('Click me!')),
                    CloseButton(onPressed: () {}),
                    BackButton(onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
