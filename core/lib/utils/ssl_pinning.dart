import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('certificates/some-random-api.ml.cer');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

class SSLCertifiedClient extends IOClient {
  Future<IOClient> get execute async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return IOClient(client);
  }
}
