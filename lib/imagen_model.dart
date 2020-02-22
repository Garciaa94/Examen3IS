import 'dart:convert';

ImagenModel imagenModelFromJson(String str) => ImagenModel.fromJson(json.decode(str));

String imagenModelToJson(ImagenModel data) => json.encode(data.toJson());

class ImagenModel {
    String id;
    String nombre;
    String url;

    ImagenModel({
        this.id,
        this.nombre,
        this.url,
    });

    factory ImagenModel.fromJson(Map<String, dynamic> json) => ImagenModel(
        id: json["id"],
        nombre: json["nombre"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "url": url,
    };
}