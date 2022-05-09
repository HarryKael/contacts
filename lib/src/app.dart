import 'package:contacts/src/consts/chars.dart';
import 'package:contacts/src/consts/consts.dart';
import 'package:contacts/src/screens/add_edit/edit_screen.dart';
import 'package:contacts/src/screens/list/list_screen.dart';
import 'package:contacts/src/service/list_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListContactsService(),
      child: MaterialApp(
        title: appName,
        initialRoute: listRoute,
        onGenerateRoute: (RouteSettings settings) {
          // final dynamic data = settings.arguments;
          return MaterialPageRoute(builder: (BuildContext context) {
            switch (settings.name) {
              case listRoute:
                return const ListScreen();
              case addEditRoute:
                return const ContactScreen();
              default:
                return const ListScreen();
            }
          });
        },
      ),
    );
  }
}
