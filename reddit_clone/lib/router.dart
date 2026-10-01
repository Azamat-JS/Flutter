import 'package:reddit_clone/features/auth/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';
import "package:flutter/material.dart";

final loggedOutRoute = RouteMap(
  routes: {'/': (_) => const MaterialPage(child: LoginScreen())},
);
