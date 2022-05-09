import 'package:contacts/src/models/contact_model.dart';
import 'package:flutter/material.dart';

class ListContactsService with ChangeNotifier {
  List<ContactModel> listContacts = [];
  late ContactModel contactModel;
  ListContactsService();

  void addAContact({required ContactModel contact}) {
    contact.id = listContacts.length;
    listContacts.add(contact);
    notifyListeners();
  }

  void removeContact({required ContactModel contact}) {
    bool finded = false;
    List<ContactModel> list = [];
    for (int i = 0; i < listContacts.length; i++) {
      if (finded) {
        list.add(listContacts[i].copyWith(id: i - 1));
      } else {
        if (listContacts[i].id == contact.id) {
          finded = true;
        } else {
          list.add(listContacts[i]);
        }
      }
    }
    listContacts = list;
    notifyListeners();
  }

  void updateContact({required ContactModel contact}) {
    List<ContactModel> list = [];
    for (int i = 0; i < listContacts.length; i++) {
      if (listContacts[i].id == contact.id) {
        list.add(listContacts[i].copyWith(
          firstName: contact.firstName,
          lastName: contact.lastName,
          age: contact.age,
          email: contact.email,
          phoneNumber: contact.phoneNumber,
        ));
      } else {
        list.add(listContacts[i]);
      }
    }
    listContacts = list;
    contactModel = contact;
    notifyListeners();
  }
}
