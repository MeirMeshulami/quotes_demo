import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quotes_demo/examples/quotes_app/quotes_app.dart';
import 'package:quotes_demo/firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase. initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BasicCrudApp());
  // runApp(const QuoteApp());
}