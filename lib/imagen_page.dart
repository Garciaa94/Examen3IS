import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imagenes/imagen_model.dart';
import 'package:imagenes/provider.dart';
import 'package:image_picker/image_picker.dart';

class ImagenPage extends StatefulWidget {
  ImagenPage({Key key}) : super(key: key);

  @override
  _ImagenPageState createState() => _ImagenPageState();
}

class _ImagenPageState extends State<ImagenPage> {
  final imagenProvider = new ImagensProvider();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ImagenModel producto = new ImagenModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed:_seleccionarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
   return TextFormField(
     initialValue: producto.nombre,
     textCapitalization: TextCapitalization.sentences,
     decoration: InputDecoration(
       labelText: 'Nombre'
     ),
     onSaved: (value)=>producto.nombre=value,
     validator: (value){
       if(value.length<3){
         return 'Ingrese el nombre del producto';
       }else{
         return null;
       }
     },
   );
 }

 _mostrarFoto(){
    if (producto.url != null) {
      return FadeInImage(
        image: NetworkImage(producto.url),
        placeholder: AssetImage('assets/no-image.png'),
        height: 300.0,
        width: double.infinity,
        fit: BoxFit.contain,
      );
    }else{
      return (foto==null) ? Image(
        image: AssetImage('assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      ): Image.file(
        foto,
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }
  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Agregar Imagen'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null :_submit,
    );
  }

  void _seleccionarFoto() async {
    foto = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (foto !=null) {
      producto.url=null;
    }
    setState(() {});
  }

 void _submit()async {
    //Cuando no es valido
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();
    
    setState(() {_guardando = true;});

    if (foto != null) {
      producto.url = await imagenProvider.subirImagen(foto);
    }

    //Cuando es valido
    if(producto.id == null){
      imagenProvider.crearProducto(producto);
      Navigator.pushReplacementNamed(context, 'home');
    }else{
      imagenProvider.editarProducto(producto);
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

}