import 'dart:io';

import 'package:contact_book/ui/contact_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/contact_helper.dart';
import 'package:flutter/material.dart';

enum OrderOptions { orderaz, orderza }

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();

    getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                value: OrderOptions.orderaz,
                child: Text('Ordenar de A-Z'),
              ),
              const PopupMenuItem<OrderOptions>(
                value: OrderOptions.orderza,
                child: Text('Ordenar de Z-A'),
              )
            ],
            onSelected: _orderList,
          )
        ],
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('Contatos'),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemBuilder: (context, index) => (_contactCard(context, index)),
        itemCount: contacts.length,
        padding: const EdgeInsets.all(10),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => _showContactPage(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: contacts[index].img != null
                          ? FileImage(File(contacts[index].img as String))
                          : const AssetImage('images/account.jpg')
                              as ImageProvider<Object>,
                    ),
                    shape: BoxShape.circle),
                height: 80,
                width: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contacts[index].name ?? '',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contacts[index].email ?? '',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      contacts[index].phone ?? '',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () => _showOptions(context, index),
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => (BottomSheet(
        builder: (context) => (Container(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  launch('tel:${contacts[index].phone}');
                  Navigator.pop(context);
                },
                child: const Text(
                  'Ligar',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showContactPage(contact: contacts[index]);
                },
                child: const Text(
                  'Editar',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    helper.deleteContact(contacts[index].id!);
                    contacts.removeAt(index);
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            )
          ]),
        )),
        onClosing: () {},
      )),
    );
  }

  void _showContactPage({Contact? contact}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactPage(contact: contact)),
    );

    if (recContact != null) {
      if (contact != null) {
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      getAllContacts();
    }
  }

  void getAllContacts() {
    helper
        .getAllContacts()
        .then((contactsList) => setState(() => contacts = contactsList));
  }

  void _orderList(OrderOptions option) {
    contacts.sort((a, b) => (option == OrderOptions.orderaz
        ? a.name!.toLowerCase().compareTo(b.name!.toLowerCase())
        : b.name!.toLowerCase().compareTo(a.name!.toLowerCase())));

    setState(() {});
  }
}
