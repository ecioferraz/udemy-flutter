import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;

  const ContactPage({Key? key, this.contact}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact? _editedContact;
  bool _userEdited = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact!.toMap());
      _nameController.text = _editedContact!.name ?? '';
      _emailController.text = _editedContact!.email ?? '';
      _phoneController.text = _editedContact!.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(_editedContact?.name ?? 'Novo Contato'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => ImagePicker()
                    .getImage(source: ImageSource.camera)
                    .then((image) {
                  if (image == null) return;

                  setState(() => _editedContact!.img = image.path);
                }),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _editedContact!.img != null
                          ? FileImage(File(_editedContact!.img!))
                          : const AssetImage("images/account.jpg")
                              as ImageProvider,
                    ),
                    shape: BoxShape.circle,
                  ),
                  height: 140,
                  width: 140,
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                focusNode: _nameFocus,
                onChanged: (text) {
                  _userEdited = true;
                  setState(() => _editedContact!.name = text);
                },
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact!.email = text;
                },
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact!.phone = text;
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            if (_editedContact!.name != null &&
                _editedContact!.name!.isNotEmpty) {
              Navigator.pop(context, _editedContact);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
        context: context,
        builder: (context) => (AlertDialog(
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Sim')),
          ],
          content: const Text('Se sair, as alterações serão perdidas!'),
          title: const Text('Descartar alterações?'),
        )),
      );

      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
