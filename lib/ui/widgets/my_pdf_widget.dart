/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */


import 'package:flutter/cupertino.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class MyPDFWidget extends StatefulWidget {
  final String pdfPath;

  MyPDFWidget({required this.pdfPath});

  @override
  _MyPDFWidgetState createState() => _MyPDFWidgetState();
}

class _MyPDFWidgetState extends State<MyPDFWidget>
    with AutomaticKeepAliveClientMixin {
 // late PDFDocument _pdfDocument;

  @override
  void initState() {
    super.initState();
  //  _loadPDFDocument();
  }

  /*Future<void> _loadPDFDocument() async {
    // Load your PDF document here
    _pdfDocument = await PDFDocument.fromFile(File(widget.pdfPath));
    setState(() {}); // Trigger a state update after loading the document
  }*/

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AutomaticKeepAlive(
      child: PageStorage(
        child: const PDF(
          enableSwipe: true,
          //swipeHorizontal: true,
          autoSpacing: true,
          pageFling: false,
        ).fromUrl(
          widget.pdfPath,
          errorWidget: (dynamic error) =>
              Center(
                  child:
                  Text(error.toString())),
        ),
        key: PageStorageKey(widget.pdfPath), bucket: PageStorageBucket(), // Unique key for each PDF
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
