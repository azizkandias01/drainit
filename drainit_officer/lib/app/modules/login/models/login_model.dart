class Login {
  String? idPetugas;
  String? token;

  Login({this.idPetugas, this.token});

  Login.fromJson(Map<String, dynamic> json) {
    idPetugas = json['id_petugas'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_petugas'] = idPetugas;
    data['token'] = token;
    return data;
  }
}
