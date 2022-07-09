class Timeline {
  String? id;
  String? idMasyarakat;
  String? namaPelapor;
  String? namaJalan;
  String? foto;
  String? tipe;
  String? deskripsi;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? geometry;
  int? upvote;
  int? downvote;

  Timeline(
      {this.id,
      this.idMasyarakat,
      this.namaPelapor,
      this.namaJalan,
      this.foto,
      this.tipe,
      this.deskripsi,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.geometry,
      this.upvote,
      this.downvote});

  Timeline.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idMasyarakat = json['id_masyarakat'].toString();
    namaPelapor = json['nama_pelapor'].toString();
    namaJalan = json['nama_jalan'].toString();
    foto = json['foto'].toString();
    tipe = json['tipe'].toString();
    deskripsi = json['deskripsi'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    geometry = json['geometry'].toString();
    upvote = json['upvote'] as int;
    downvote = json['downvote'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_masyarakat'] = this.idMasyarakat;
    data['nama_pelapor'] = this.namaPelapor;
    data['nama_jalan'] = this.namaJalan;
    data['foto'] = this.foto;
    data['tipe'] = this.tipe;
    data['deskripsi'] = this.deskripsi;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['geometry'] = this.geometry;
    data['upvote'] = this.upvote;
    data['downvote'] = this.downvote;
    return data;
  }
}
