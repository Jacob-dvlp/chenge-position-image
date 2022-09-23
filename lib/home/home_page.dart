import 'package:chenge_position_img/home/widget/custom_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int chengePositionImage = 0;
  chengePosition() {
    setState(() {
      if (chengePositionImage == 5) {
        chengePositionImage = 0;
      }
      ++chengePositionImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: Text('$chengePositionImage'),
        centerTitle: true,
      ),
      backgroundColor: Colors.brown[500],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown[500],
        child: const Icon(Icons.update),
        onPressed: () => chengePosition(),
      ),
      body: CustomWidget(chengePositionImage: chengePositionImage),
    );
  }
}
