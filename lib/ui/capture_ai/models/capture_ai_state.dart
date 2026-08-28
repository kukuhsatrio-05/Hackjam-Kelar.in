import 'dart:io';
import 'package:kelarin_hackjam/ui/capture_ai/models/task_result.dart';

class CaptureAIState {
  final bool isLoading;
  final String? errorMessage;
  final File? selectedImage;
  final AITaskResult? taskResult;

  const CaptureAIState({
    this.isLoading = false,
    this.errorMessage,
    this.selectedImage,
    this.taskResult,
  });

  CaptureAIState copyWith({
    bool? isLoading,
    String? errorMessage,
    File? selectedImage,
    AITaskResult? taskResult,
    bool clearImage = false,
    bool clearTaskResult = false,
    bool clearError = false,
  }) {
    return CaptureAIState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedImage: clearImage ? null : (selectedImage ?? this.selectedImage),
      taskResult: clearTaskResult ? null : (taskResult ?? this.taskResult),
    );
  }
}
