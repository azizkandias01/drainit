class Timeline {
  Timeline({
    this.id,
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
    this.downvote,
    this.vote,
  });

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
    vote = json['vote'].toString();
  }
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
  String? vote;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_masyarakat'] = idMasyarakat;
    data['nama_pelapor'] = namaPelapor;
    data['nama_jalan'] = namaJalan;
    data['foto'] = foto;
    data['tipe'] = tipe;
    data['deskripsi'] = deskripsi;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['geometry'] = geometry;
    data['upvote'] = upvote;
    data['downvote'] = downvote;
    data['vote'] = vote;
    return data;
  }
}
