import 'package:flutter_riverpod/flutter_riverpod.dart';

class BerandaState {
  final int completedTasks;
  final int totalTasks;
  final int clientMeetings;

  BerandaState({
    this.completedTasks = 8,
    this.totalTasks = 10,
    this.clientMeetings = 3,
  });
}

class BerandaViewModel extends Notifier<BerandaState> {
  @override
  BerandaState build() {
    return BerandaState();
  }
}

final berandaViewModelProvider =
    NotifierProvider<BerandaViewModel, BerandaState>(BerandaViewModel.new);
