import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkpeek/linkpeek.dart';
import 'package:linkpeek/models/linkpeek.model.dart';

void main() {
  // Ensure Flutter is initialized before running any tests
  WidgetsFlutterBinding.ensureInitialized();

  test('Get info from the url', () async {
    final LinkPeekModel linkPeek =
        await LinkPeek.fromUrl("https://www.youtube.com/watch?v=y9JsHJpRXbs");

    expect(linkPeek.title,
        "Jaya Radhe Jaya Krishna by HG Amarendra Das (enable captions for lyrics) - YouTube");
    expect(linkPeek.domain, "www.youtube.com");
  });
}
