import 'package:flutter/material.dart';
import 'package:flutter_app/data/classes/activity_class.dart';
import 'package:flutter_app/views/pages/expanded_flexible_page.dart';
import 'package:flutter_app/views/widgets/hero_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late final Future<Activity> _activityFuture;

  @override
  void initState() {
    _activityFuture = getData();
    super.initState();
  }

  Future<Activity> getData() async {
    var url = Uri.https('bored-api.appbrewery.com', '/random');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return Activity.fromJson(
        convert.jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load activity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Page'), centerTitle: true),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<Activity> snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.waiting) {
            widget = Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            widget = Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            Activity activity = snapshot.data!;
            widget = Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(children: [HeroWidget(title: activity.activity)]),
              ),
            );
          } else {
            widget = Center(child: Text('No data available'));
          }
          return widget;
        },
      ),
    );
  }
}
