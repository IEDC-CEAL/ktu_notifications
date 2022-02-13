part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}


class HomeScreenLoading extends HomeScreenState {}

// ignore: must_be_immutable
class HomeScreenLoaded extends HomeScreenState {
  HomeScreenLoaded({required this.notification});
  NotificationModel notification;
}

// ignore: must_be_immutable
class HomeScreenError extends HomeScreenState {
  HomeScreenError({required this.errorText});
  String errorText;
}

class HomeScreenOffline extends HomeScreenState {}