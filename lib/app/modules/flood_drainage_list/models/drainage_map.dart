class DrainageMap {
  String? id;
  String? namaJalan;
  double? lebar;
  double? panjang;
  double? kedalaman;
  String? bahan;
  String? kondisi;
  String? akhirPembuangan;
  String? arahAlir;
  String? foto;
  String? tipeDrainase;
  dynamic status;
  String? geometry;

  DrainageMap(
      {this.id,
      this.namaJalan,
      this.lebar,
      this.panjang,
      this.kedalaman,
      this.bahan,
      this.kondisi,
      this.akhirPembuangan,
      this.arahAlir,
      this.foto,
      this.tipeDrainase,
      this.status,
      this.geometry});

  DrainageMap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaJalan = json['nama_jalan'];
    lebar = double.parse(json['lebar'].toString());
    panjang = double.parse(json['panjang'].toString());
    kedalaman = double.parse(json['kedalaman'].toString());
    bahan = json['bahan'];
    kondisi = json['kondisi'];
    akhirPembuangan = json['akhir_pembuangan'];
    arahAlir = json['arah_alir'];
    foto = json['foto'];
    tipeDrainase = json['tipe_drainase'];
    status = json['status'];
    geometry = json['geometry'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama_jalan'] = namaJalan;
    data['lebar'] = lebar;
    data['panjang'] = panjang;
    data['kedalaman'] = kedalaman;
    data['bahan'] = bahan;
    data['kondisi'] = kondisi;
    data['akhir_pembuangan'] = akhirPembuangan;
    data['arah_alir'] = arahAlir;
    data['foto'] = foto;
    data['tipe_drainase'] = tipeDrainase;
    data['status'] = status;
    data['geometry'] = geometry;
    return data;
  }
}
