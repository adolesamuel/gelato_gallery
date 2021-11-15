import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  List<Map> downloadsListMaps = [];
  @override
  void initState() {
    super.initState();
    task();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  Future task() async {
    List<DownloadTask>? getTasks = await FlutterDownloader.loadTasks();
    getTasks!.forEach((_task) {
      Map _map = Map();
      _map['status'] = _task.status;
      _map['progress'] = _task.progress;
      _map['id'] = _task.taskId;
      _map['filename'] = _task.filename;
      _map['savedDirectory'] = _task.savedDir;
      downloadsListMaps.add(_map);
    });
    setState(() {});
  }

  Widget downloadStatusWidget(DownloadTaskStatus _status) {
    return _status == DownloadTaskStatus.canceled
        ? Text('Download canceled')
        : _status == DownloadTaskStatus.complete
            ? Text('Download completed')
            : _status == DownloadTaskStatus.failed
                ? Text('Download failed')
                : _status == DownloadTaskStatus.paused
                    ? Text('Download paused')
                    : _status == DownloadTaskStatus.running
                        ? Text('Downloading..')
                        : Text('Download waiting');
  }

  Widget buttons(DownloadTaskStatus _status, String taskid, int index) {
    void changeTaskID(String taskid, String newTaskID) {
      Map? task = downloadsListMaps?.firstWhere(
        (element) => element['taskId'] == taskid,
        orElse: () => Map(),
      );
      task!['taskId'] = newTaskID;
      setState(() {});
    }

    return _status == DownloadTaskStatus.canceled
        ? GestureDetector(
            child: Icon(Icons.cached, size: 20, color: Colors.green),
            onTap: () {
              FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
                changeTaskID(taskid, newTaskID!);
              });
            },
          )
        : _status == DownloadTaskStatus.failed
            ? GestureDetector(
                child: Icon(Icons.cached, size: 20, color: Colors.green),
                onTap: () {
                  FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
                    changeTaskID(taskid, newTaskID!);
                  });
                },
              )
            : _status == DownloadTaskStatus.paused
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.play_arrow,
                            size: 20, color: Colors.blue),
                        onTap: () {
                          FlutterDownloader.resume(taskId: taskid).then(
                            (newTaskID) => changeTaskID(taskid, newTaskID!),
                          );
                        },
                      ),
                      GestureDetector(
                        child: Icon(Icons.close, size: 20, color: Colors.red),
                        onTap: () {
                          FlutterDownloader.cancel(taskId: taskid);
                        },
                      )
                    ],
                  )
                : _status == DownloadTaskStatus.running
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: Icon(Icons.pause,
                                size: 20, color: Colors.green),
                            onTap: () {
                              FlutterDownloader.pause(taskId: taskid);
                            },
                          ),
                          GestureDetector(
                            child:
                                Icon(Icons.close, size: 20, color: Colors.red),
                            onTap: () {
                              FlutterDownloader.cancel(taskId: taskid);
                            },
                          )
                        ],
                      )
                    : _status == DownloadTaskStatus.complete
                        ? GestureDetector(
                            child:
                                Icon(Icons.delete, size: 20, color: Colors.red),
                            onTap: () {
                              downloadsListMaps.removeAt(index);
                              FlutterDownloader.remove(
                                  taskId: taskid, shouldDeleteContent: true);
                              setState(() {});
                            },
                          )
                        : Container();
  }

  ReceivePort _port = ReceivePort();
  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      var task = downloadsListMaps?.where((element) => element['id'] == id);
      task!.forEach((element) {
        element['progress'] = progress;
        element['status'] = status;
        setState(() {});
      });
    });
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  showDialogue(File? file) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                child: Image.file(
                  file!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Downloads'),
      ),
      body: downloadsListMaps.isEmpty
          ? Center(child: Text("No Downloads yet"))
          : Container(
              child: ListView.builder(
                itemCount: downloadsListMaps.length,
                itemBuilder: (BuildContext context, int i) {
                  Map _map = downloadsListMaps[i];
                  String _filename = _map['filename'];
                  int _progress = _map['progress'];
                  DownloadTaskStatus _status = _map['status'];
                  String _id = _map['id'];
                  String _savedDirectory = _map['savedDirectory'];

                  List<FileSystemEntity> _directories =
                      Directory(_savedDirectory).listSync(followLinks: true);
                  File? _file = _directories.isNotEmpty
                      ? _directories.first as File
                      : null;
                  return GestureDetector(
                    onTap: () {
                      if (_status == DownloadTaskStatus.complete) {
                        showDialogue(_file);
                      }
                    },
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            isThreeLine: false,
                            title: Text(_filename),
                            subtitle: downloadStatusWidget(_status),
                            trailing: SizedBox(
                              child: buttons(_status, _id, i),
                              width: 60,
                            ),
                          ),
                          _status == DownloadTaskStatus.complete
                              ? Container()
                              : SizedBox(height: 5),
                          _status == DownloadTaskStatus.complete
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text('$_progress%'),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: LinearProgressIndicator(
                                              value: _progress / 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(height: 10)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
