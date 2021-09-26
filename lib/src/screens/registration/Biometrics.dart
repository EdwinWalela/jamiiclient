import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Biometrics extends StatefulWidget {
  final String header;
  final bool isPotrait;
  final PageController pageController;
  final camera;

  Biometrics({
    this.header,
    this.isPotrait,
    this.pageController,
    this.camera,
  });

  @override
  _BiometricsState createState() => _BiometricsState();
}

class _BiometricsState extends State<Biometrics> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.stopImageStream().then((value) => _controller.dispose());
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Container(margin: EdgeInsets.only(top: 20)),
              buildHeader(widget.header),
              Container(margin: EdgeInsets.only(top: 40)),
              buildImageFrame(context),
              Container(margin: EdgeInsets.only(top: 40)),
              buildButton("Capture", widget.pageController),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildHeader(String header) {
    return Text(
      header,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildImageFrame(BuildContext context) {
    return Container(
      width: this.widget.isPotrait
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.8,
      height: this.widget.isPotrait
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.black, width: 3),
          ),
      child: CameraPreview(_controller),
    );
  }

  Widget buildButton(String buttonText, PageController pageController) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            print(image.path);
            pageController.nextPage(
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          } catch (e) {
            print(e);
          }
        },
        child: Text(buttonText),
      ),
    );
  }
}
