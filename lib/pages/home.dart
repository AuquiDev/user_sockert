import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_sockert/model/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Alberto', votes: 5),
    Band(id: '2', name: 'Cecilia', votes: 2),
    Band(id: '3', name: 'Eduardo', votes: 1),
    Band(id: '4', name: 'Orlando', votes: 3),
    Band(id: '5', name: 'Teo', votes: 5),
    Band(id: '6', name: 'Carlos', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Usuarios',
            style: TextStyle(color: Colors.black87),
          )),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => _bandsTile(bands[index])),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange[600],
          elevation: 1,
          onPressed: () {
            return addNewBands();
          },
          child: const Icon(Icons.add_alert)),
    );
  }

  Widget _bandsTile(Band bands) {
    return Dismissible(
      key: Key(bands.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('Direccion : $direction');
        print('Direccion : ${bands.id}');
      },
      background: Container(
        padding: EdgeInsets.all(10),
        color: Colors.orangeAccent,
        child:Text('eliminar',textAlign: TextAlign.start,)
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(bands.name.substring(0, 2)),
        ),
        title: Text(bands.name),
        trailing: Text(
          '${bands.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(bands.name);
        },
      ),
    );
  }

//Referencia new Bands
  addNewBands() {
    final TextEditingController _controller = new TextEditingController();

    if (Platform.isAndroid) {
      //ALERT DIALOG PARA ANDROID
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('New Band nmae:'),
              content: TextField(
                controller: _controller,
              ),
              actions: [
                MaterialButton(
                    color: Colors.orangeAccent,
                    elevation: 5,
                    textColor: Colors.white,
                    onPressed: () => addBadTolist(_controller.text),
                    child: const Text('Agregar'))
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('New band name: '),
            content: CupertinoTextField(
              controller: _controller,
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Agregar'),
                onPressed: () => addBadTolist(_controller.text),
              ),
              CupertinoDialogAction(
                child: const Text('Salir'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  //DIalogo, para IOS: Para manejar

  void addBadTolist(String name) {
    print(name);
    if (name.length > 1) {
      //podemos agregar
      this.bands.add(
          Band(id: DateTime.now().toString(), name: name, votes: 2));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
