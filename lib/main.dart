import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/app/pages/gallery_landing_page.dart';
import 'injection_container.dart' as get_it;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Await [Dependency_injection] processing
  ///using Get_it package
  await get_it.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const GalleryLandingPage(),
    );
  }
}
