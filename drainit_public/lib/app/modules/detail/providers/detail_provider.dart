import 'package:get/get.dart';

import '../models/detail_model.dart';

class DetailProvider extends GetConnect {
  Future<Detail?> getDetail(String id) async {
    final response = await get(
      'https://gis-drainase.pocari.id/api/pengaduan/$id',
    );
    if (response.status.hasError) {
      return Detail.fromJson(
        {
          "id": "9a01e678-d440-4fa3-a1c5-a30f6d3e765a",
          "id_masyarakat": "e5923414-2bf7-444c-b312-51778f30eb11",
          "id_admin": null,
          "id_petugas": null,
          "nama_jalan": "jalan pesisir",
          "foto": "'<img src=update Gambar\/>",
          "tipe_pengaduan": "banjir",
          "deskripsi_pengaduan":
              "banjir udh dua bulan belum ada penanganan banjir sampe masuk rumah",
          "status_pengaduan": "Menunggu Konfirmasi",
          "laporan_petugas": null,
          "feedback_masyarakat": null,
          "geometry": "{\"type\": \"Point\", \"coordinates\": [30, 10]}"
        } as Map<String, dynamic>,
      );
    } else {
      return Detail.fromJson(response.body as Map<String, dynamic>);
    }
  }
}
