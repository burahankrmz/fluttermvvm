import 'package:flutter/material.dart';
import 'package:flutteradvancedmvvm/app/dependency_injection.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModeule();
  runApp(MyApp());
}
