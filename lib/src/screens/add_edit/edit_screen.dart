// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:contacts/src/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:contacts/src/consts/chars.dart';
import 'package:contacts/src/service/list_contacts.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListContactsService>(
      builder: (context, listContactsService, child) => Scaffold(
        appBar: AppBar(
          title: const Text(contactString),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  listContactsService.removeContact(
                      contact: listContactsService.contactModel);
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "${listContactsService.contactModel.firstName} ${listContactsService.contactModel.lastName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text(nameString),
                    ),
                    ListTile(
                      title: Text(
                        listContactsService.contactModel.age.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text(ageString),
                    ),
                    ListTile(
                      title: Text(
                        listContactsService.contactModel.phoneNumber.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: const Text(phoneNumberString),
                    ),
                    listContactsService.contactModel.email != null
                        ? ListTile(
                            title: Text(
                              listContactsService.contactModel.email!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: const Text(emailString),
                          )
                        : const Offstage(),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            listContactsService.contactModel = listContactsService.contactModel;
            showDialogAddEditContact(context,
                contactModel: listContactsService.contactModel);
          },
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
