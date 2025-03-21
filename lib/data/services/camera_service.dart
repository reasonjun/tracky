import 'package:camera/camera.dart';

class CameraService {
  Future<List<CameraDescription>> getAvailableCameras() async {
    return availableCameras();
  }

  Future<CameraController> initializeCamera(CameraDescription camera) async {
    final controller = CameraController(camera, ResolutionPreset.medium);
    await controller.initialize();
    return controller;
  }
}