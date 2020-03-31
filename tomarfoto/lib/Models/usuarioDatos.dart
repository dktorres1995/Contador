class Usuario{
  String _token;
  String _nombre;
  String _tennant;
  String _correo;
  String _apellido;
  String _tokenMicrosof;

  String gettoken() {
    return _token;
  }

  void setToken(String tok) {
    _token = tok;
  }
  String gettokenMicrosoft() {
    return _tokenMicrosof;
  }

  void setTokenMicrosoft(String tok) {
    _tokenMicrosof = tok;
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
  String getApellido() {
    return _apellido;
  }

  void setApellido(String apellido) {
    _apellido = apellido;
  }

  //constructores
  Usuario(this._token);

  void completarDatosBasicos(Map<String,dynamic> claims){
    _nombre = claims['name'];
    _correo = (claims['emails'] as List<dynamic>).first;
    _apellido = claims['family_name'];
    _tokenMicrosof = claims['idp_access_token']!=null?claims['idp_access_token']:'';
  }



}