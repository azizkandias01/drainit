class UpdateLaporan {
  String? id;
  String? namaPetugas;
  String? judul;
  String? deskripsi;
  String? foto;
  String? waktu;
  String? createdAt;
  String? updatedAt;

  UpdateLaporan(
      {this.id,
      this.namaPetugas,
      this.judul,
      this.deskripsi,
      this.foto,
      this.waktu,
      this.createdAt,
      this.updatedAt});

  UpdateLaporan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPetugas = json['nama_petugas'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    foto = json['foto'];
    waktu = json['waktu'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama_petugas'] = namaPetugas;
    data['judul'] = judul;
    data['deskripsi'] = deskripsi;
    data['foto'] = foto;
    data['waktu'] = waktu;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
