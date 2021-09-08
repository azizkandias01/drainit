class Drainage {
  String? id;
  String? namaJalan;
  String? keterangan;
  dynamic status;
  String? foto;
  String? geometry;

  Drainage(
      {this.id,
      this.namaJalan,
      this.keterangan,
      this.status,
      this.foto,
      this.geometry});

  Drainage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaJalan = json['nama_jalan'];
    keterangan = json['keterangan'];
    status = json['status'];
    foto = json['foto'];
    geometry = json['geometry'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama_jalan'] = namaJalan;
    data['keterangan'] = keterangan;
    data['status'] = status;
    data['foto'] = foto;
    data['geometry'] = geometry;
    return data;
  }
}
