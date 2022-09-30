import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:plasticz/Views/HomePage.dart';

class PDFViewerPage extends StatelessWidget {
  final String path;
  const PDFViewerPage({Key key, this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: PDFViewerScaffold(
        path: path,
        appBar: AppBar(
          title: Text('PDF-Generado'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(Icons.home_sharp),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false);
                })
          ],
        ),
      ),
    );
  }
}
