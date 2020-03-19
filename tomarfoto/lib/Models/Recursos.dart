class Recursos {
  final String id;
  final String imagenUrl;
  final String tenant;
  final int conteo;
  final List<dynamic> centros;
  final double radio;
  final List<dynamic> etiquetasAdd;

  Recursos(
      {this.id,
      this.imagenUrl,
      this.tenant,
      this.conteo,
      this.centros,
      this.radio,
      this.etiquetasAdd});

  factory Recursos.fromJson(Map<String, dynamic> json) {
    if (json["resultado"] != null) {
      return Recursos(
          id: json["_id"],
          imagenUrl: json["image_url"],
          tenant: json["tenant"],
          centros: json["resultado"]["centros"],
          radio: json["resultado"]["mean_radius"],
          conteo: json["resultado"]["conteo"],
          etiquetasAdd: json["etiquetasAdd"]);

    } else {
      return Recursos(
          id: json["_id"],
          imagenUrl: json["image_url"],
          tenant: json["tenant"],
          conteo: -1);
    }
  }

    factory Recursos.fromJson2(Map<String, dynamic> json) {
    if (json["resultado"] != null) {
      return Recursos(
          id: json["_id"],
          conteo: json["resultado"]["conteo"]);
    } else {
      return Recursos(
          id: json["_id"],
          conteo: -1);
    }
  }


}
