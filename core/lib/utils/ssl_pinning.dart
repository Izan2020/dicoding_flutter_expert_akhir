import 'package:core/utils/shared.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class SSLCertifiedClient extends IOClient {
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    return await Shared.initializeIOClient().then((value) => value.get(url));
  }
}
