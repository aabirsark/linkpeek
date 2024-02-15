
# Linkpeek 🔍

LinkPeek is a Flutter package that allows you to retrieve information about a web link, including title, description, thumbnail, favicon, default color, etc. It also provides a convenient popup widget for displaying link previews.

## Features

- Get detailed information about a web link using the `LinkPeek.fromUrl` method.
- Display a small popup showing a preview of the link using the `LinkPeek.showLinkPeekPopup` method.

## Installation

To use this package, add `linkpeek` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  linkpeek: ^latest_version
```
## Usages
import linkpeek first
```dart
import "package:linkpeek/linkpeek.dart";
```


To get link preview use this snippet of code

```dart
LinkPeekModel? linkPeekModel;

// Initailize It

LinkPeek.fromUrl("your url").then((value) {
    linkPeekModel = value;
});

```

To open the linkpeek popup 

```dart
 LinkPeek.showLinkPeekPopup(context, controller.text);
```


## Example output

![Linkpeek preview](./Screenshots/screenshot2.png)

![Link peek popup](./Screenshots/screenshot1.gif)


## 🚀 About Me
Hi, I am Aabir Kaveri Sarkar - a full stack developer from India

- checkout my portfolio (https://aabirsarkar.vercel.app/)

## License

[MIT](https://choosealicense.com/licenses/mit/)


