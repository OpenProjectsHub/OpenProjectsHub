// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'dart:async';
import 'dart:math';

import 'package:shoppingapp/presentation/theme/app_style.dart';

class ImageCropperForMarker {
  Future<BitmapDescriptor> resizeAndCircle(String? imageURL, int size) async {
    final File imageFile = await _urlToFile(imageURL);
    final Uint8List byteData = imageFile.readAsBytesSync();
    final Image image = await _resizeAndConvertImage(byteData, size, size);
    return _paintToCanvas(image, Size.zero);
  }

  Future<File> imageToFile({String? imageName, String? ext}) async {
    var bytes = await rootBundle.load('assets/$imageName.$ext');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/app_logo.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }

  Future<File> _urlToFile(String? imageUrl) async {
    final rd = Random();
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    try {
      final File file = File('$tempPath${rd.nextInt(100)}.png');
      final http.Response response = await http.get(Uri.parse(imageUrl ?? ''));
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      return await imageToFile(imageName: "images/app_logo", ext: "png");
    }
  }

  Future<Image> _resizeAndConvertImage(
    Uint8List? data,
    int height,
    int width,
  ) async {
    ByteData bytes = await rootBundle.load('assets/images/app_logo.png');
    final img.Image? baseSizeImage =
        img.decodeImage(data ?? bytes.buffer.asUint8List());
    final img.Image? newSizeImage = img.decodeImage(bytes.buffer.asUint8List());

    final img.Image resizeImage = img.copyResize(baseSizeImage ?? newSizeImage!,
        height: height, width: width);
    final Codec codec = await instantiateImageCodec(
        Uint8List.fromList(img.encodePng(resizeImage)));
    final FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  Future<BitmapDescriptor> _paintToCanvas(Image image, Size size) async {
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint();
    paint.isAntiAlias = true;

    _performCircleCrop(image, size, canvas);

    final recordedPicture = pictureRecorder.endRecording();
    Image img = await recordedPicture.toImage(image.width, image.height);
    final byteData = await img.toByteData(format: ImageByteFormat.png);
    final buffer = byteData?.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(buffer!);
  }

  Canvas _performCircleCrop(Image image, Size size, Canvas canvas) {
    Paint paint = Paint();
    canvas.drawCircle(const Offset(0, 0), 0, paint);

    double drawImageWidth = 0;
    double drawImageHeight = 0;
    double imageW = image.width.toDouble();
    double imageH = image.height.toDouble();
    final Path path = Path()
      ..addOval(
        Rect.fromLTRB(
          drawImageWidth + imageW / 8,
          drawImageHeight + imageH / 8,
          imageW - imageW / 8,
          imageH - imageH / 8,
        ),
      );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTRB(
            drawImageWidth,
            drawImageHeight,
            imageW,
            imageH,
          ),
          Radius.circular(imageW / 4)),
      Paint()
        ..color = Style.white.withOpacity(0.75)
        ..imageFilter = ImageFilter.blur(sigmaX: 7, sigmaY: 7),
    );
    canvas.clipPath(path);
    canvas.drawImage(image, Offset(drawImageWidth, drawImageHeight), Paint());
    return canvas;
  }
}
