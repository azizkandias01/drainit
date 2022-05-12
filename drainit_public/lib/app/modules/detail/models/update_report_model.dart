class UpdateReport {
  String? id;
  String? namaPetugas;
  String? judul;
  String? deskripsi;
  String? foto;
  String? waktu;

  UpdateReport(
      {this.id,
      this.namaPetugas,
      this.judul,
      this.deskripsi,
      this.foto,
      this.waktu});

  UpdateReport.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    namaPetugas = json['nama_petugas'].toString();
    judul = json['judul'].toString();
    deskripsi = json['deskripsi'].toString();
    foto = json['foto'].toString();
    waktu = json['waktu'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama_petugas'] = namaPetugas;
    data['judul'] = judul;
    data['deskripsi'] = deskripsi;
    data['foto'] = foto;
    data['waktu'] = waktu;
    return data;
  }
}
