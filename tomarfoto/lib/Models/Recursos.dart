class Recursos {
  final String id;
  final String imagenUrl;
  final String tenant;
  final int conteo;
  final List<dynamic> centros;
  
  Recursos({this.id, this.imagenUrl, this.tenant,this.conteo, this.centros});


  factory Recursos.fromJson(Map<String, dynamic> json) {
    if(json["resultado"] != null){
    return Recursos(
        id: json["_id"],
        imagenUrl: json["image_url"],
        tenant: json["tenant"],
        centros: json["resultado"]["centros"],
        conteo: json["resultado"]["conteo"]);
    }
    else{

    return Recursos(
        id: json["_id"],
        imagenUrl: json["image_url"],
        tenant: json["tenant"],
        conteo: -1);
    }
  }


factory Recursos.fromJsonItem(Map<String, dynamic> json) {
    
    return Recursos(
        id: json["_id"], imagenUrl: json["image_url"], tenant: json["tenant"],conteo: json["resultado"]["conteo"]);
  }

}