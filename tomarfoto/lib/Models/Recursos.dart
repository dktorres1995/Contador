class Recursos {
  final String id;
  final String imagenUrl;
  final String tenant;
  final int conteo;

  Recursos({this.id, this.imagenUrl, this.tenant,this.conteo});

  factory Recursos.fromJson(Map<String, dynamic> json) {
    
    return Recursos(
        id: json["_id"],
         imagenUrl: json["image_url"],
          tenant: json["tenant"],
          conteo: json["resultado"]["conteo"]);
  }

factory Recursos.fromJsonItem(Map<String, dynamic> json) {
    
    return Recursos(
        id: json["_id"], imagenUrl: json["image_url"], tenant: json["tenant"],conteo: json["resultado"]["conteo"]);
  }

}