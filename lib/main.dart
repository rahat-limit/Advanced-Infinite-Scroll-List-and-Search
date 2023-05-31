import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_and_infinite_list/main_screen.dart';
import 'package:search_and_infinite_list/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    Provider<SiProvider>(
      create: (_) => SiProvider(),
    )
  ], child: const MainScreen()));
}
