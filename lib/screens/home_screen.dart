import 'package:animated_page_transition/animated_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubits/cubit/home_screen_cubit.dart';
import '../models/notification_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenCubit homeScreenCubit;
  GetStorage box = GetStorage();

  @override
  void initState() {
    homeScreenCubit = HomeScreenCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageTransitionReceiver(
      scaffold: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            "KTU Notifications",
            style: GoogleFonts.comfortaa(),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          bloc: homeScreenCubit,
          builder: (context, state) {
            if (state is HomeScreenLoaded) {
              return notificationList(state.notification);
            } else if (state is HomeScreenLoading) {
              return loadingScreen();
            } else if (state is HomeScreenOffline &&
                box.read("notification") != null) {
              return notificationList(box.read("notification"));
            } else {
              return errorScreen("Network Error");
            }
          },
        ),
      ),
    );
  }

  Widget notificationList(NotificationModel notification) {
    return LiquidPullToRefresh(
      onRefresh: homeScreenCubit.handleRefresh,
      child: ListView.builder(
        itemCount: notification.notifications.length,
        itemBuilder: (context, index) {
          var item = notification.notifications[index];
          return Column(
            children: [
              ListTile(
                title: Text(
                  item.title,
                  style: GoogleFonts.comfortaa(fontWeight: FontWeight.w800),
                ),
                leading: const Icon(
                  Icons.notification_important_outlined,
                  color: Colors.red,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.description,
                        style:
                            GoogleFonts.comfortaa(fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        launchURL(item.links[0].url);
                      },
                      child: Text(
                        item.links[0].urlTitle,
                        style: GoogleFonts.comfortaa(color: Colors.purple),
                      ),
                    ),
                  ],
                ),
              ),
              index != 9
                  ? const Divider(
                      thickness: 2,
                      color: Colors.indigo,
                    )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }

  void launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  Widget errorScreen(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget loadingScreen() {
    homeScreenCubit.getNotificationsFromAPI();
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
