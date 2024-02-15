import 'package:flutter/widgets.dart';
import 'package:linkpeek/linkpeek.dart';
import 'package:linkpeek/models/linkpeek.model.dart';
import 'package:logger/logger.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class LinkPeekUtils {
  final _logger = Logger();

  Future<PaletteGenerator?> _getIconPalette(String url) async {
    try {
      if (url.isEmpty) {
        _logger.e("Empty url ");
        return null;
      }

      return await PaletteGenerator.fromImageProvider(
        NetworkImage(url),
        maximumColorCount: 20,
      );
    } catch (e) {
      _logger.e("Some error in palette generation", error: e);
      return null;
    }
  }

  Map<String, String> _parseHtml(String htmlString) {
    final document = parser.parse(htmlString);

    Map<String, String> info = {};

    final titleElement = document.querySelector('title');
    info['title'] = titleElement?.text ?? '';

    final metaTags = document.querySelectorAll('meta[name="description"]');
    if (metaTags.isNotEmpty) {
      info['description'] = metaTags.first.attributes['content'] ?? "";
    }

    final linkTags = document.querySelectorAll('link[rel="icon"]');
    if (linkTags.isNotEmpty) {
      info['favicon'] = linkTags.first.attributes['href'] ?? "";
    }

    final shortCuts = document.querySelectorAll('link[rel="shortcut icon"]');
    if (shortCuts.isNotEmpty) {
      info['favicon'] = shortCuts.first.attributes['href'] ?? "";
    }

    final thumbnailTags =
        document.querySelectorAll('meta[property="og:image"]');
    if (thumbnailTags.isNotEmpty) {
      info['thumbnail'] = thumbnailTags.first.attributes['content'] ?? "";
    }

    return info;
  }

  Future<LinkPeekModel> getHtmlContent(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final htmlContent = response.body;
        final parsedInfo = _parseHtml(htmlContent);

        String favicon = parsedInfo['favicon'] ?? "";
        Uri uri = Uri.parse(url);

        if (favicon.isNotEmpty) {
          if (favicon.startsWith("//")) {
            favicon = "https:$favicon";
          } else if (favicon.startsWith("/")) {
            favicon = uri.origin + favicon;
          }
        }

        final PaletteGenerator? palette = await _getIconPalette(favicon);
        final String title = (parsedInfo['title'] ?? "").trim();
        final String description = (parsedInfo['description'] ?? "").trim();
        final String thumbnail = parsedInfo['thumbnail'] ?? "";
        final String domain = uri.origin.split("/").last;

        return LinkPeekModel(
            title: title,
            webIcon: favicon,
            defaultColor: palette?.dominantColor?.color,
            description: description,
            thumbnail: thumbnail,
            colorScheme: palette,
            domain: domain,
            url: url);
      } else {
        _logger.e("Server responsed very badly! package is upset",
            error: response.statusCode);
        throw Exception("Error fetching URL: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("One more error in your code ☠️", error: e);
      throw Exception("Error fetching URL: $e");
    }
  }
}
