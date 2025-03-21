import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/camera_repository.dart';

class CameraViewModel extends ChangeNotifier {
  final CameraRepository _cameraRepository;
  CameraController? _controller;
  bool isLoading = true;
  String? error;
  
  CameraViewModel(this._cameraRepository);

  CameraController? get controller => _controller;

  Future<void> initialize() async {
    try {
      final cameras = await _cameraRepository.getAvailableCameras();
      if (cameras.isEmpty) {
        error = '사용 가능한 카메라가 없습니다.';
      } else {
        final firstCamera = cameras.first;
        _controller = await _cameraRepository.initializeCamera(firstCamera);
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      error = '카메라가 초기화되지 않았습니다.';
      notifyListeners();
      return null;
    }
    try {
      final image = await _controller!.takePicture();
      final saveResult = await _cameraRepository.savePicture(image.path);
      if (saveResult != true) {
        error = '사진 저장에 실패했습니다.';
        notifyListeners();
        return null;
      }
      return image.path;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}