import 'package:drainit_flutter/app/modules/history/providers/history_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("get all history with bearer should success", () async {
    final history = await HistoryProvider().loadHistory(
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzVhYTYwODQ5MGJjNGYxNjU1ZGJjZjdlMDRhNTcwYmQ5YmFlOWU1ODQxZDNjOTI1MWRmZGE4YmVjMmU0Yzc2MzY4OWJmMjI0ZWQzOGVmNDEiLCJpYXQiOjE2NDc3NTQyMjEuNDE1NjM1LCJuYmYiOjE2NDc3NTQyMjEuNDE1NjQyLCJleHAiOjE2NzkyOTAyMjEuMzg1OTUzLCJzdWIiOiJjNDAxZjlmOS0wMDE0LTQ1MzMtOTRhYS0xNDkxMmQ1ZmIyMjEiLCJzY29wZXMiOltdfQ.Y1zdB4LBLe1eAXJk7LKJzqPriDcx7Fs9dP3zdxHK1NqkFiXuUpyN9gZ4M9xxF5yUt1BmEFtyhNAK8MMnijyPpLZJmmPXZ-0QAYMQt5VYNSbSSmXygolP6RyA7BlC1FCHCJ2G525elxnfRy_ydEgjKykAi3v3HGojczvcgW9nfLJAmYLKc2LgLpD_7qVze6pfDzXsVRYUh7fvlzBrJkdKDC9SxRsUQlhJludJLnB2CktEPhqnXhK2g1kkX7mTIyXmKSCRgwls_BhGQzqwzMcn5LXCW-kpmvSpism6Gjm3HfidKIzR7xaU-KIzcNEH3mjaZDfbnXkduDHSUy_F7t44GFOgZeWZy-7rYFQQSFzBBclUw8asQI-hmcVd24rnfaI55w9_CI4a1aeI7XnzPtkE58KaTZ-lwHfuHkm1EqgjZNC9HzqdNNaOSGrXZqfzGcVRiCfYmisFFX7ZZLlxkjewUTh1VU4MTWg20z35IoE_sNcc1Nlm-Sbsh9i4boYeGv7zwRjEFqS13aSqIQHnmLB-ZP3hrV0SB2XMzqiNa4EV5usYRpY1KNB-HuboIqg5o4l9GMdmSQnC5G9anIUarF7NaZrq3LACceoADg4vXMPCBghl0jRe2eq3MwsEqTgYUE90O64jmoXU0djcvRl4V7Z6-8ExK36rBRZ9kPfIvn8YFPQ",
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
