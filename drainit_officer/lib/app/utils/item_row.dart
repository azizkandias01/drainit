import 'package:drainit_petugas/app/modules/done_reports/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemRow extends StatelessWidget {
  final Report report;
  const ItemRow({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return report.tipePengaduan == "banjir"
        ? Stack(
            children: [
              SvgPicture.asset("assets/svg/bg_banjir.svg"),
              Row(
                children: [Text(report.namaPelapor!)],
              )
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Stack(
                children: [
                  Center(
                      child: SvgPicture.asset("assets/svg/bg_tersumbat.svg",
                          fit: BoxFit.fill)),
                  Row(
                    children: [Text(report.namaJalan!)],
                  )
                ],
              ),
            ),
          );
  }
}
