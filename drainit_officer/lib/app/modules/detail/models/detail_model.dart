class Detail {
  Detail({
    this.id,
    this.idMasyarakat,
    this.namaPelapor,
    this.idAdmin,
    this.namaAdmin,
    this.namaJalan,
    this.foto,
    this.tipe,
    this.deskripsi,
    this.status,
    this.feedbackMasyarakat,
    this.createdAt,
    this.updatedAt,
    this.geometry,
    this.petugas,
    this.upvote,
    this.downvote,
  });

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idMasyarakat = json['id_masyarakat'].toString();
    namaPelapor = json['nama_pelapor'].toString();
    idAdmin = json['id_admin'].toString();
    namaAdmin = json['nama_admin'].toString();
    namaJalan = json['nama_jalan'].toString();
    foto = json['foto'].toString();
    tipe = json['tipe'].toString();
    deskripsi = json['deskripsi'].toString();
    status = json['status'].toString();
    feedbackMasyarakat = json['feedback_masyarakat'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    geometry = json['geometry'].toString();
    if (json['petugas'] != null) {
      petugas = <Petugas>[];
      json['petugas'].forEach((v) {
        petugas?.add(Petugas.fromJson(v as Map<String, dynamic>));
      });
    }
    upvote = json['upvote'] as int;
    downvote = json['downvote'] as int;
  }
  String? id;
  String? idMasyarakat;
  String? namaPelapor;
  String? idAdmin;
  String? namaAdmin;
  String? namaJalan;
  String? foto;
  String? tipe;
  String? deskripsi;
  String? status;
  String? feedbackMasyarakat;
  String? createdAt;
  String? updatedAt;
  String? geometry;
  List<Petugas>? petugas;
  int? upvote;
  int? downvote;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_masyarakat'] = idMasyarakat;
    data['nama_pelapor'] = namaPelapor;
    data['id_admin'] = idAdmin;
    data['nama_admin'] = namaAdmin;
    data['nama_jalan'] = namaJalan;
    data['foto'] = foto;
    data['tipe'] = tipe;
    data['deskripsi'] = deskripsi;
    data['status'] = status;
    data['feedback_masyarakat'] = feedbackMasyarakat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['geometry'] = geometry;
    if (petugas != null) {
      data['petugas'] = petugas?.map((v) => v.toJson()).toList();
    }
    data['upvote'] = upvote;
    data['downvote'] = downvote;
    return data;
  }
}

class Petugas {
  Petugas({this.id, this.idPetugas, this.namaPetugas});

  Petugas.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idPetugas = json['id_petugas'].toString();
    namaPetugas = json['nama_petugas'].toString();
  }
  String? id;
  String? idPetugas;
  String? namaPetugas;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_petugas'] = idPetugas;
    data['nama_petugas'] = namaPetugas;
    return data;
  }
}
