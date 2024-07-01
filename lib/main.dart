import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_029/Pages/add_contact_page.dart';
import 'package:test_029/Pages/contact_page.dart';
import 'package:test_029/Pages/details_page.dart';
import 'package:test_029/Provider/contact_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context)=>ContactProvider()..getAllDataProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: ContactPage.routeName,
      routes: {
        ContactPage.routeName:(context)=>const ContactPage(),
        Add_New.routeName:(context)=>const Add_New(),
        Details_Page.routeName:(context)=>const Details_Page()
      },
    );
  }
}

