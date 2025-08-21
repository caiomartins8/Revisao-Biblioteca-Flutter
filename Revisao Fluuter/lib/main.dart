import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/book.dart';
import 'services/storage.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await Storage.create();
  runApp(MyApp(storage: storage));
}

class MyApp extends StatelessWidget {
  final Storage storage;
  const MyApp({required this.storage, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: storage,
      child: MaterialApp(
        title: 'Biblioteca Digital',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}