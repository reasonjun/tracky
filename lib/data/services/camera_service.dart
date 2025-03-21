import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CameraService {
  Future<List<CameraDescription>> getAvailableCameras() async {
    return availableCameras();
  }

  Future<CameraController> initializeCamera(CameraDescription camera) async {
    final controller = CameraController(camera, ResolutionPreset.medium);
    await controller.initialize();
    return controller;
  }

  Future<bool?> savePicture(String imagePath) async {
    return await GallerySaver.saveImage(imagePath);
  }
}