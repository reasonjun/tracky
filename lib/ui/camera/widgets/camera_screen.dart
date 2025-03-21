// lib/ui/camera/widgets/camera_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/camera_view_model.dart';
import '../../../data/repositories/camera_repository.dart';
import 'display_picture_screen.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CameraViewModel>(
      create: (_) => CameraViewModel(CameraRepository())..initialize(),
      child: const CameraView(),
    );
  }
}

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('사진 촬영')),
      body: Consumer<CameraViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.error != null) {
            return Center(child: Text('에러: ${viewModel.error}'));
          }
          if (viewModel.controller == null ||
              !viewModel.controller!.value.isInitialized) {
            return const Center(child: Text('카메라를 사용할 수 없습니다.'));
          }
          return CameraPreview(viewModel.controller!);
        },
      ),
      floatingActionButton: Consumer<CameraViewModel>(
        builder: (context, viewModel, child) {
          return FloatingActionButton(
            onPressed: () async {
              final imagePath = await viewModel.takePicture();
              if (imagePath != null) {
                if (!context.mounted) return;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        DisplayPictureScreen(imagePath: imagePath),
                  ),
                );
              }
            },
            child: const Icon(Icons.camera_alt),
          );
        },
      ),
    );
  }
}