import 'package:flutter/material.dart';
import 'package:imagenes/imagen_model.dart';
import 'package:imagenes/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imagensProvider = new ImagensProvider();

  @override
  Widget build(BuildContext context) {
    bool estado = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagian de Inicio'),
      ),
      body: _crearListado(),
      floatingActionButton: (estado)? _crearBoton(context) : Container(),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: imagensProvider.cargarImagenes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ImagenModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) => _crearItem(context, snapshot.data[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ImagenModel producto) {
    return Card(
      child: Column(
        children: <Widget>[
          (producto.url == null)
              ? Image(image: AssetImage('assets/no-image.png'))
              : GestureDetector(
                  child: FadeInImage(
                    image: NetworkImage(producto.url),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
          ListTile(
            title: Text('${producto.nombre}'),
          ),
        ],
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.image,),
      backgroundColor: Colors.blue,
      onPressed: () => Navigator.pushNamed(context, 'Imagen'),
    );
  }
}
