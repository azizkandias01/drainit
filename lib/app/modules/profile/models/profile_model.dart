class Profile {
  Profile({
    this.id,
    this.nama,
    this.foto,
    this.noHp,
    this.alamat,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    nama = json['nama'] as String;
    foto = json['foto'] as String;
    noHp = json['no_hp'] as String;
    alamat = json['alamat'] as String;
    email = json['email'] as String;
    createdAt = json['created_at'] as String;
    updatedAt = json['updated_at'] as String;
  }
  String? id;
  String? nama;
  String? foto;
  String? noHp;
  String? alamat;
  String? email;
  String? createdAt;
  String? updatedAt;

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
