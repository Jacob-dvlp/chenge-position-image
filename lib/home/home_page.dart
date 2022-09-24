import 'package:chenge_position_img/const/image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  final double maxScale = 4;
  final double minScale = 1;
  int chengePositionImage = 0;
  OverlayEntry? entry;
  chengePosition() {
    setState(() {
      if (chengePositionImage == 5) {
        chengePositionImage = 0;
      }
      ++chengePositionImage;
    });
  }

  @override
  void initState() {
    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )
      ..addListener(() => controller.value = animation!.value)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          removeOverlay();
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[500],
          title: Text('$chengePositionImage'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => chengePosition(),
              icon: const Icon(Icons.update),
            )
          ],
        ),
        backgroundColor: Colors.brown[500],
        body: buildImage());
  }

  Widget buildImage() {
    return Builder(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: InteractiveViewer(
                transformationController: controller,
                onInteractionEnd: (details) {
                  resetAnimation();
                },
                onInteractionStart: (details) {
                  if (details.pointerCount < 2) return;
                  showOverlay(context);
                },
                panEnabled: false,
                clipBehavior: Clip.none,
                minScale: minScale,
                maxScale: maxScale,
                child: RotatedBox(
                  quarterTurns: chengePositionImage,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: size.width,
                      height: size.height / 1,
                      child: Image.asset(myPhoto,
                          height: size.height / 1, fit: BoxFit.fitHeight),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  void removeOverlay() {
    entry?.remove();
    entry = null;
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.bounceIn),
    );
    animationController.forward(from: 0);
  }

  void showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offSet = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;
    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offSet.dx,
          top: offSet.dy,
          width: size.width,
          child: buildImage(),
        );
      },
    );
    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }
}
