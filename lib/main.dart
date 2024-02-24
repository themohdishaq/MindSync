import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:nayapakistan/common/color_extension.dart';
import 'package:nayapakistan/firebase_options.dart';

import 'package:nayapakistan/view/on_boarding/started_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindSync',
      theme: ThemeData(
        primaryColor: TColor.primaryColor1,
        fontFamily: "Poppins",
      ),
      home: const StartedView(),
    );
  }
}
