import 'package:contacts/src/components/components.dart';
import 'package:contacts/src/consts/chars.dart';
import 'package:contacts/src/consts/consts.dart';
import 'package:contacts/src/service/list_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(contactsString),
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Consumer<ListContactsService>(
          builder: (context, listContactsService, child) {
            return Column(
              children: listContactsService.listContacts
                  .map(
                    (e) => ListTile(
                      onTap: () {
                        listContactsService.contactModel = e;
                        Navigator.pushNamed(context, addEditRoute);
                      },
                      title: Text(
                        "${e.firstName} ${e.lastName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(e.phoneNumber.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          listContactsService.removeContact(
                              contact: listContactsService.listContacts[e.id!]);
                        },
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogAddEditContact(context, contactModel: null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
