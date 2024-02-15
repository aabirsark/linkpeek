import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LinkPeekWindow extends StatefulWidget {
  const LinkPeekWindow({
    super.key,
    required this.url,
    this.controller,
  });

  final String url;
  final WebViewController? controller;

  @override
  State<LinkPeekWindow> createState() => _LinkPeekWindowState();
}

class _LinkPeekWindowState extends State<LinkPeekWindow> {
  // ignore: non_constant_identifier_names
  late AnimationController ani_controller;
  late WebViewController controller;

  @override
  void initState() {
    controller = widget.controller ?? WebViewController()
      ..canGoForward()
      ..setBackgroundColor(Colors.transparent)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: ZoomIn(
          controller: (controller) {
            ani_controller = controller;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.link,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          widget.url,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontStyle: FontStyle.normal),
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          ani_controller.reverseDuration =
                              const Duration(milliseconds: 400);
                          ani_controller.reverse();
                          Future.delayed(const Duration(milliseconds: 400))
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                clipBehavior: Clip.antiAlias,
                height: constraints.maxHeight * .85,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                  color: Colors.white10,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: WebViewWidget(controller: controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
