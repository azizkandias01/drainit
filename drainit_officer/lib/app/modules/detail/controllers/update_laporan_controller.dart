import 'package:drainit_petugas/app/modules/detail/providers/update_laporan_provider.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UpdateLaporanController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  void updateLaporan(String id, String judul, String deskripsi) {
    change(
      null,
      status: RxStatus.loading(),
    );
    final updateData = {
      'id_pengaduan': id,
      'judul': judul,
      'deskripsi': deskripsi,
    };
    UpdateLaporanProvider()
        .updateLaporan(updateData, box.read(Routes.TOKEN))
        .then(
          (resp) => change(
            resp,
            status: RxStatus.success(),
          ),
        );
  }
}
