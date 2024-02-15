import 'dart:ui';

import 'package:palette_generator/palette_generator.dart';

/// Main Class for link peek information
class LinkPeekModel {
  /// provides the title for the webpage
  final String title;

  /// provides full url of the page
  final String? url;

  /// provides domain of the webpage
  final String? domain;

  /// provides icon of the webpage `can be .svg .ico .png`
  final String? webIcon;

  /// provides default color of the webpage (if available)
  final Color? defaultColor;

  /// provides description of the webpage (if available)
  final String? description;

  /// provides thumbnail of the website (if available)
  final String? thumbnail;

  /// provides color scheme for the website
  final PaletteGenerator? colorScheme;

  const LinkPeekModel(
      {this.url,
      this.domain,
      required this.title,
      this.thumbnail,
      this.webIcon,
      this.defaultColor,
      this.description,
      this.colorScheme});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LinkPeekModel &&
        other.title == title &&
        other.webIcon == webIcon &&
        other.defaultColor == defaultColor &&
        other.thumbnail == thumbnail &&
        other.description == description;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      webIcon.hashCode ^
      defaultColor.hashCode ^
      thumbnail.hashCode ^
      description.hashCode;

  @override
  String toString() {
    return 'LinkPeek{title: $title, favicon: $webIcon, defaultColor: $defaultColor, description: $description}';
  }
}
