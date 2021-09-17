class Drainage {
  Drainage({
    this.id,
    this.namaJalan,
    this.keterangan,
    this.status,
    this.foto,
    this.geometry,
  });

  Drainage.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    namaJalan = json['nama_jalan'] as String;
    keterangan = json['keterangan'] as String;
    status = json['status'];
    foto = json['foto'] as String;
    geometry = json['geometry'] as String;
  }

  String? id;
  String? namaJalan;
  String? keterangan;
  dynamic status;
  String? foto;
  String? geometry;

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
