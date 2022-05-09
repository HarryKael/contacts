import 'package:contacts/src/consts/chars.dart';
import 'package:contacts/src/models/contact_model.dart';
import 'package:contacts/src/service/list_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showDialogAddEditContact(BuildContext context,
    {ContactModel? contactModel}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialogAddEditContact(contactModel);
    },
  );
}

// ignore: must_be_immutable
class AlertDialogAddEditContact extends StatefulWidget {
  AlertDialogAddEditContact(this.contactModel, {Key? key}) : super(key: key);
  ContactModel? contactModel;

  @override
  State<AlertDialogAddEditContact> createState() =>
      _AlertDialogAddEditContactState();
}

class _AlertDialogAddEditContactState extends State<AlertDialogAddEditContact> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _age;
  late TextEditingController _phoneNumber;
  late TextEditingController _email;
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    if (widget.contactModel != null) {
      _firstName = TextEditingController(text: widget.contactModel!.firstName);
      _lastName = TextEditingController(text: widget.contactModel!.lastName);
      _age = TextEditingController(text: widget.contactModel!.age.toString());
      _phoneNumber = TextEditingController(
          text: widget.contactModel!.phoneNumber.toString());
      if (widget.contactModel!.email != null) {
        _email = TextEditingController(text: widget.contactModel!.email!);
      } else {
        _email = TextEditingController();
      }
    }
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _age = TextEditingController();
    _phoneNumber = TextEditingController();
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _age.dispose();
    _phoneNumber.dispose();
    _email.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _ageFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 400,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Center(
                    child: Text(
                      widget.contactModel != null
                          ? editContactString
                          : addContactString,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _firstName,
                  focusNode: _firstNameFocusNode,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: firstNameString,
                  ),
                  onEditingComplete: () {
                    _lastNameFocusNode.requestFocus();
                  },
                  validator: (String? v) {
                    if (v == null || v.isEmpty) {
                      return esteCampoEsRequeridoString;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _lastName,
                  focusNode: _lastNameFocusNode,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: lastNameString),
                  onEditingComplete: () {
                    _ageFocusNode.requestFocus();
                  },
                  validator: (String? v) {
                    if (v == null || v.isEmpty) {
                      return esteCampoEsRequeridoString;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _age,
                  focusNode: _ageFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: ageString),
                  onEditingComplete: () {
                    _phoneNumberFocusNode.requestFocus();
                  },
                  validator: (String? v) {
                    if (v == null || v.isEmpty) {
                      return esteCampoEsRequeridoString;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _phoneNumber,
                  focusNode: _phoneNumberFocusNode,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: phoneNumberString),
                  onEditingComplete: () {
                    _emailFocusNode.requestFocus();
                  },
                  validator: (String? v) {
                    if (v == null || v.isEmpty) {
                      return esteCampoEsRequeridoString;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _email,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: emailString),
                  onEditingComplete: () {
                    _emailFocusNode.unfocus();
                  },
                  validator: (String? v) {
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<ListContactsService>(
                  builder: (context, listContactsService, child) =>
                      OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.contactModel != null) {
                                listContactsService.updateContact(
                                    contact: listContactsService.contactModel
                                        .copyWith(
                                  age: int.parse(_age.value.text),
                                  email: _email.value.text.isEmpty
                                      ? null
                                      : _email.value.text,
                                  firstName: _firstName.value.text,
                                  lastName: _lastName.value.text,
                                  phoneNumber:
                                      int.parse(_phoneNumber.value.text),
                                ));
                              } else {
                                listContactsService.addAContact(
                                    contact: ContactModel(
                                  age: int.parse(_age.value.text),
                                  email: _email.value.text.isEmpty
                                      ? null
                                      : _email.value.text,
                                  firstName: _firstName.value.text,
                                  lastName: _lastName.value.text,
                                  phoneNumber:
                                      int.parse(_phoneNumber.value.text),
                                ));
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(submitString)),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
