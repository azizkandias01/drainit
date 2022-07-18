import 'package:drainit_flutter/app/modules/history/providers/history_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("get all history with bearer should success", () async {
    final history = await HistoryProvider().loadHistory(
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQyMDQwNTgzLWE3NDMtNDVhNi05ZDg2LTI5MWZhMmI5MGQwZSIsImVtYWlsIjoicmluYUBnbWFpbC5jb20iLCJyb2xlIjoiTWFzeWFyYWthdCIsImV4cCI6MTY1ODEzNzExNH0.EZRjwB86tWarXx37lTikLBh8vE0HNSDQmqV2CRE9U54",
    );
    expect(history.length, greaterThan(0));
  });
  test("get all history without bearer should unsuccessful", () async {
    try {
      final history = await HistoryProvider().loadHistory("");
      expect(history.length, greaterThan(0));
    } catch (e) {
      expect(e.toString(), "Internal Server Error");
    }
  });
}
