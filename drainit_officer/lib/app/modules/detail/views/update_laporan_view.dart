import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_petugas/app/modules/detail/controllers/detail_controller.dart';
import 'package:drainit_petugas/app/utils/constant.dart';
import 'package:drainit_petugas/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/text_default.dart';

class UpdateLaporanView extends GetView<DetailController> {
  const UpdateLaporanView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextRegular(
              text: 'Update Laporan',
            ),
            20.verticalSpace,
            if (controller.bytes64Image.value.isNotEmpty)
              Center(
                child: Container(
                  height: Get.width / 2,
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    image: DecorationImage(
                      image: MemoryImage(
                        base64Decode(controller.bytes64Image.value),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            20.verticalSpace,
            TextField(
              controller: controller.updateLaporanController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Update Laporan',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.getImage(ImageSource.gallery);
                      },
                      child: Icon(
                        Icons.image,
                        color: Colors.grey,
                      ),
                    ),
                    10.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        controller.getImage(ImageSource.camera);
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                    ),
                    10.horizontalSpace,
                    if (controller.bytes64Image.value.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          controller.bytes64Image.value = '';
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.green,
                      ),
                    ),
                    onPressed: () {
                      if (controller.detail.status == done) {
                        Get.dialog(
                          AlertDialog(
                            title: Text('Laporan Sudah Selesai'),
                            content: Text(
                                'Laporan sudah selesai, tidak dapat diupdate'),
                            actions: [
                              FlatButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (controller
                          .updateLaporanController.text.isEmpty) {
                        Get.dialog(
                          AlertDialog(
                            title: Text('Update Laporan'),
                            content: Text('Laporan tidak boleh kosong'),
                            actions: [
                              FlatButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        controller.updateLaporan(
                            controller.detail.id!,
                            "update",
                            controller.updateLaporanController.text,
                            controller.bytes64Image.value);
                        controller.notifikasi();
                      }
                    },
                    child: Text('Update')),
              ],
            ),
            20.verticalSpace,
            const TextBold(text: "Riwayat Update Laporan"),
            20.verticalSpace,
            if (controller.listUpdate.isEmpty)
              const Center(child: Text("Belum ada update untuk sekarang"))
                  .paddingAll(20.r),
            for (int i = 0; i < controller.listUpdate.length; i++)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: const CachedNetworkImageProvider(
                      "https://i.pravatar.cc/300",
                    ),
                    backgroundColor: Colors.amber,
                    minRadius: 20.r,
                  ),
                  10.horizontalSpace,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: controller.listUpdate[i].foto != "tidak ada",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image(
                              image: CachedNetworkImageProvider(
                                  Routes.IMAGEURL +
                                      controller.listUpdate[i].foto!),
                            ),
                          ),
                        ),
                        10.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.grey[200],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextBold(
                                text: "${controller.listUpdate[i].namaPetugas}",
                              ),
                              5.verticalSpace,
                              TextRegular(
                                text: "${controller.listUpdate[i].deskripsi}",
                              ),
                            ],
                          ).paddingAll(10.r),
                        ),
                        5.verticalSpace,
                        TextRegular(
                          text: timeAgoSinceDate(
                              controller.listUpdate[i].createdAt != null
                                  ? controller.listUpdate[i].createdAt
                                      .toString()
                                  : controller.listUpdate[i].waktu.toString()),
                          fontSize: 11.sp,
                          textColour: Colors.grey,
                        ),
                        10.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ).paddingAll(20.r));
  }
}
