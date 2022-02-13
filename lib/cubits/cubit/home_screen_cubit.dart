import 'package:bloc/bloc.dart';

import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

import '../../models/notification_model.dart';
import '../../repository/notifications_api.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenLoading());

  NotificationsAPI api = NotificationsAPI();

  GetStorage box = GetStorage();
  late NotificationModel notification;

  void getNotificationsFromAPI() async {
    try {
      emit(HomeScreenLoading());
      api.getNotifications().then((value) {
        notification = notificationModelFromJson(value);

        emit(HomeScreenLoaded(notification: notification));
        box.write("notification", notification);
      });
    } on NetworkException {
      emit(
        HomeScreenError(errorText: "Network Error"),
      );
    }
  }

  Future<void> handleRefresh() async {
    getNotificationsFromAPI();
  }
}
