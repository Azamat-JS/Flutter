// valueNotifier: hold data that can be listened to
// ValueListenableBuilder: listen to the data (dont need the setState)
import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);
