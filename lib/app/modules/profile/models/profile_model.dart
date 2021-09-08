class Profile {
  String? id;
  String? nama;
  String? foto;
  String? noHp;
  String? alamat;
  String? email;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.nama,
      this.foto,
      this.noHp,
      this.alamat,
      this.email,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    foto = json['foto'];
    noHp = json['no_hp'];
    alamat = json['alamat'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['foto'] = foto;
    data['no_hp'] = noHp;
    data['alamat'] = alamat;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
