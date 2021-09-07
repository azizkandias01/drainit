class FloodModel {
  String? id;
  String? namaJalan;
  String? kondisiKerusakan;
  String? foto;
  String? keterangan;
  dynamic status;
  String? geometry;

  FloodModel(
      {this.id,
      this.namaJalan,
      this.kondisiKerusakan,
      this.foto,
      this.keterangan,
      this.status,
      this.geometry});

  FloodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaJalan = json['nama_jalan'];
    kondisiKerusakan = json['kondisi_kerusakan'];
    foto = json['foto'];
    keterangan = json['keterangan'];
    status = json['status'];
    geometry = json['geometry'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama_jalan'] = namaJalan;
    data['kondisi_kerusakan'] = kondisiKerusakan;
    data['foto'] = foto;
    data['keterangan'] = keterangan;
    data['status'] = status;
    data['geometry'] = geometry;
    return data;
  }
}
