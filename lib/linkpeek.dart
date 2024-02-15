library linkpeek;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:linkpeek/models/linkpeek.model.dart';
import 'package:linkpeek/utils/utils.dart';
import 'package:linkpeek/widget/linkPeek_window.widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LinkPeek {
  /// Get all the info about the link in form of `LinkPeekModel`
  static Future<LinkPeekModel> fromUrl(String url) async {
    final LinkPeekUtils utils = LinkPeekUtils();
    return utils.getHtmlContent(url);
  }

  /// Get a small popup showing preview of the link
  static showLinkPeekPopup(BuildContext context, String url,
      {WebViewController? controller}) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black26,
                    child: LinkPeekWindow(url: url, controller: controller),
                  ),
                ),
              ),
            ));
  }
}
