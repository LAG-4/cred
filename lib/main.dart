import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stacking Bottom Sheets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomSheetStackingScreen(),
    );
  }
}

class BottomSheetStackingScreen extends StatefulWidget {
  @override
  _BottomSheetStackingScreenState createState() =>
      _BottomSheetStackingScreenState();
}

class _BottomSheetStackingScreenState extends State<BottomSheetStackingScreen> {
  int sheetIndex = 1;

  // Method to show a bottom sheet
  void showStackedBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Transparent background to see behind
      builder: (BuildContext context) {
        return BottomSheetContent(sheetIndex: sheetIndex);
      },
    ).then((value) {
      setState(() {
        sheetIndex++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stacking Bottom Sheets'),
      ),
      body: Center(
        child: Text('Press the button to add bottom sheets'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showStackedBottomSheet,
        child: Icon(Icons.add),
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  final int sheetIndex;

  BottomSheetContent({required this.sheetIndex});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9), // Semi-transparent sheet
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Text(
                'Bottom Sheet $sheetIndex',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text('This is the content of bottom sheet $sheetIndex.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the current sheet
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
