import 'package:drainit_flutter/app/modules/history/providers/history_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("get all history", () async {
    var history = await HistoryProvider().loadHistory(
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNDgwZjQ4NTQ4ZmU0MTg4ZjVmYmIyZDYxNGUxYjczMzRlZjE1MmIxYmNjMGQxN2Y1MTI2NmViMTVmZTg5ZDJhNTQ2NzEzZDQ4NDcyMGE1MjEiLCJpYXQiOjE2Mzc4MjcyNDAsIm5iZiI6MTYzNzgyNzI0MCwiZXhwIjoxNjY5MzYzMjQwLCJzdWIiOiJmYmE5NWMyYi1hMjBlLTRjM2EtODQzMC01MDEwZGRlOTI0NDQiLCJzY29wZXMiOltdfQ.SlWZX5skaZ9jjy8ozeq-o-koOjRiA7XXQ5znK_0S0cMDoPLcolabPWiblSPnESsN_jRib_-ly_quI2qCxJPrA0ULuS8BLC-n8uLDyrJUMNn7YbLOm0a37TFv-IyDOuGLmWTNPLtpeWU_YTbeR1EkyXSSsTMwdJwzcPJ6eVAQqHKdDAyOVUOAnV4_w999OKUeWMUjIF37R-bi8IijR0jQSX7VNuA7j1bOxdKs84WLSoWHxvoq9ik9rdSQwZx10OPYQPcJNDZhVTN4cW8JxoNYh2mx1Xr41yV3mFGz7np5MIzSr3OFrw4hy7OLidFju9lC9IYJbxaQo3M12-JY18e65BgyIYf5gqdLHcy9yW2AkdOyljzChp6gpSnJntPN19NeBLpPfEnueBbYxdBfqK3DxWMR3HzUc7WYvKPSETONF--D1H5O9o4Qkz00aKnaT-wL07U2CfCiNqOvSpi0ry3KwUEjnBH2N0eUhacM9gzBeGAb4JWWMW-yQz7xoNSodvU6WFJlMNZ9h5jV4_NgKhS2fESd8QYAQIAGNXEIGQnn2V0EMEom3rWxg_bWmP6cwmS9D_voJKco-phdXrwk2C9wB2E3aLlJkn_5BikIXeogykJTxYaAAKsyk4g58VbLEQ_Fa661XPYYPQhu3PMWFCek32qypIsOLAbvwmbhEOOt6cE");
    expect(history.length, greaterThan(0));
  });
  test("get all history without bearer", () async {
    try {
      var history = await HistoryProvider().loadHistory("");
      expect(history.length, greaterThan(0));
    } catch (e) {
      expect(e.toString(), "Internal Server Error");
    }
  });
}
