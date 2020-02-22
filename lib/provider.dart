import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:imagenes/imagen_model.dart';
import 'package:mime_type/mime_type.dart';

class ImagensProvider{
  final String _url = 'https://flutter-44624.firebaseio.com';

  //Crear

  Future<bool> crearProducto(ImagenModel producto)async {
    final url = '$_url/imagenes.json';

    await http.post(url, body: imagenModelToJson(producto));

    return true;
  }

  //Leer

  Future<List<ImagenModel>>cargarImagenes() async {
    final url = '$_url/imagenes.json';

    final response = await http.get(url);

    final Map<String,dynamic> decodeData = json.decode(response.body);
    
    final List<ImagenModel> productos = new List();

    if (decodeData == null ) return [];

    decodeData.forEach((id, prod){
      final prodTemp = ImagenModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
    });
    return productos;
  }

  //Editar

  Future<bool> editarProducto(ImagenModel producto)async {
    final url = '$_url/productos/${producto.id}.json';

    await http.put(url, body: imagenModelToJson(producto));

    return true;
  }


  //Eliminar

  Future<int> borrarProducto(String id) async {
    final url = '$_url/productos/$id.json';
    final response = await http.delete(url);
    
    print(json.decode(response.body));

    return 1;
  }

  //Subida de imagenes a Cloudinary
  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dtldllkzv/image/upload?upload_preset=dfeijmgb');
    final mimeType = mime(imagen.path).split('/');

    final imageUpload = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType(mimeType[0],mimeType[1])
    );

    imageUpload.files.add(file);

    final streamResponse = await imageUpload.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode !=200 && resp.statusCode!=201){
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    
    return respData['secure_url'];
  }

}