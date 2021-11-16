// import 'dart:io';

// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';

// Future<void> requestDownload(String _url, String _name) async {
//   final dir = await getApplicationDocumentsDirectory();
// //From path_provider package
//   var _localPath = dir.path + _name;
//   final savedDir = Directory(_localPath);
//   await savedDir.create(recursive: true).then((value) async {
//     String? _taskid = await FlutterDownloader.enqueue(
//       url: _url,
//       fileName: _name,
//       savedDir: _localPath,
//       showNotification: true,
//       openFileFromNotification: false,
//     );
//     print(_taskid);
//   });
// }
