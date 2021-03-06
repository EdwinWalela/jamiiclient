import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:jamiiclient/src/blocs/BiometricsBloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Biometrics extends StatefulWidget {
  final String header;
  final bool isPotrait;
  final PageController pageController;
  final camera;
  final BiometricsBloc biometricsBloc;

  Biometrics({
    this.header,
    this.isPotrait,
    this.pageController,
    this.camera,
    this.biometricsBloc,
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
      ResolutionPreset.veryHigh,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // try {
    //   _controller
    //       .stopImageStream()
    //       .then((value) => _controller.dispose())
    //       .catchError((e) => {print(e)});
    // } catch (e) {
    //   print(e);
    // }
    super.dispose();
    // _controller.dispose();
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
              Container(margin: EdgeInsets.only(top: 20)),
              buildImageFrame(context, widget.isPotrait),
              Container(margin: EdgeInsets.only(top: 10)),
              buildButton("Capture", widget.pageController, widget.isPotrait,
                  widget.biometricsBloc),
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

  Widget buildImageFrame(BuildContext context, bool selfie) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.black, width: 3),
            ),
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            Positioned.fill(
              child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: CameraPreview(_controller)),
            ),
            Image.asset(
              selfie
                  ? 'assets/images/face-placeholder.png'
                  : 'assets/images/id-placeholder.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ],
        ));
  }

  Widget buildButton(String buttonText, PageController pageController,
      bool isPortrait, BiometricsBloc bloc) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: () async {
          try {
            Directory dir = await getApplicationDocumentsDirectory();
            final type = isPortrait ? "selfie" : "id";
            final path = join(
              dir.path,
              type + DateTime.now().toString() + ".jpg",
            );

            await _initializeControllerFuture;
            await _controller.takePicture(path);

            if (isPortrait) {
              // Selfie
              bloc.addSelfie(path);
            } else {
              // ID
              bloc.addId(path);
              bloc.submit();
            }

            await pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } catch (e) {
            print(e);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(buttonText),
            Container(margin: EdgeInsets.only(right: 5)),
            Icon(Icons.camera),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.purple,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.purple),
            ),
          ),
        ),
      ),
    );
  }
}

// 