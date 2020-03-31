class Usuario{
  String _token;
  String _nombre;
  String _tennant;
  String _correo;

  String gettoken() {
    return _token;
  }

  void setToken(String tok) {
    _token = tok;
  }

  String getcorreo() {
    return _correo;
  }

  void setcorreo(String correo) {
    _correo = correo;
  }

  String gettennant() {
    return _tennant;
  }

  void settennant(String tennant) {
    _tennant = tennant;
  }

  String getnombre() {
    return _nombre;
  }

  void setnombre(String nombre) {
    _nombre = nombre;
  }

  //constructores
  Usuario(this._token);

  void completarDatosBasicos(Map<String,dynamic> claims){
    _nombre = claims['name'];
    _correo = (claims['emails'] as List<dynamic>).first;
  }



}