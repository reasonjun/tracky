import 'package:camera/camera.dart';
import '../services/camera_service.dart';

class CameraRepository {
  final CameraService _cameraService;

  CameraRepository({CameraService? cameraService})
      : _cameraService = cameraService ?? CameraService();

  Future<List<CameraDescription>> getAvailableCameras() {
    return _cameraService.getAvailableCameras();
  }

  Future<CameraController> initializeCamera(CameraDescription camera) {
    return _cameraService.initializeCamera(camera);
  }

  Future<bool?> savePicture(String imagePath) {
    return _cameraService.savePicture(imagePath);
  }
}