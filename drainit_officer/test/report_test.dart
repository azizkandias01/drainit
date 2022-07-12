import 'package:drainit_petugas/app/modules/done_reports/providers/done_reports_provider.dart';
import 'package:drainit_petugas/app/modules/processed_reports/providers/processed_reports_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final doneReport = ReportProvider();
  final processedReport = ProcessedProvider();
  test(
    "get processed report",
    () async {
      final reportData = await doneReport.reportList();
      expect(reportData.length, greaterThan(0));
    },
  );
  test(
    "get processed report",
    () async {
      final reportData = await processedReport.reportList();
      expect(reportData.length, greaterThan(0));
    },
  );
}
