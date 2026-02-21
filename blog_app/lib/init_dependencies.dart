import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
}
