import 'package:bloc_test_todo/presentation/themes/cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Switch Theme'),
            CupertinoSwitch(
              value: context.watch<ThemeCubit>().state == ThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeCubit>().setTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
