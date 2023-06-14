import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gif_searcher/ui/gif_page.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _offset = 0;
  String? _search;

  _getSearch() async {
    http.Response response;

    (_search == null)
        ? response = await http.get(
            'https://api.giphy.com/v1/gifs/trending?api_key=XZaawm6FU4HPTPi4TYlGnrtZwAa7VtSM&limit=20&rating=r')
        : response = await http.get(
            'https://api.giphy.com/v1/gifs/search?api_key=XZaawm6FU4HPTPi4TYlGnrtZwAa7VtSM&q=$_search&limit=19&offset=$_offset&rating=r&lang=en');

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getSearch().then((map) => print(map));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.network(
            'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.white),
                labelText: 'Pesquise aqui!',
              ),
              onSubmitted: (text) => setState(() {
                _search = text.isNotEmpty ? text : null;
                _offset = 0;
              }),
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: _getSearch(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: 200,
                    child: const CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                default:
                  return snapshot.hasError
                      ? Container()
                      : _createGifTable(context, snapshot);
              }
            },
          )),
        ],
      ),
    );
  }

  /* int _getCount(List data) {
    return _search == null ? data.length : data.length + 1;
  } */

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (context, i) => (_search == null ||
              i < snapshot.data['data'].length
          ? GestureDetector(
        onLongPress: () {
          Share.share(snapshot.data['data'][i]['images']['fixed_height']['url']);
        },
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GifPage(snapshot.data['data'][i]),
                    ));
              },
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                height: 300,
                image: snapshot.data['data'][i]['images']['fixed_height']['url'],
                placeholder: kTransparentImage,
              ),
            )
          : GestureDetector(
              onTap: () => setState(() => _offset += 19),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 70,
                  ),
                  Text(
                    'Carregar mais...',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
            )),
      itemCount: _search == null
          ? snapshot.data['data'].length
          : snapshot.data['data'].length + 1,
      padding: const EdgeInsets.all(10.0),
    );
  }
}
