import 'package:drainit_petugas/app/modules/done_reports/providers/done_reports_provider.dart';
import 'package:drainit_petugas/app/modules/homepage/providers/report_provider.dart';
import 'package:drainit_petugas/app/modules/processed_reports/providers/processed_reports_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final doneReport = HomepageProvider();
  final processedReport = ProcessedProvider();
  test(
    "get done report",
    () async {
      final reportData = await doneReport.getLaporan("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjBmODY5NDMyLThlNjEtNDk1Yi05YTY4LTFkZDRhNzEzN2NlOCIsImVtYWlsIjoiam9rb0BnbWFpbC5jb20iLCJyb2xlIjoiUGV0dWdhcyIsImV4cCI6MTY1ODc3MjUwMH0.oWdwNoajbGQi2w9HRU0HQxW8wn5EGZrGfqpWzrWvyP8");
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
