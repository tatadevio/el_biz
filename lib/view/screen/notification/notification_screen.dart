import 'package:el_biz/bloc/notification/notification_bloc.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'widgets/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Show the button if the user scrolls down 300 pixels or more
      if (_scrollController.offset > 300 && !_showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else if (_scrollController.offset <= 300 && _showScrollToTopButton) {
        setState(() {
          _showScrollToTopButton = false;
        });
      }

      final notificationBloc = context.read<NotificationBloc>();

      // isShowcategories mean showCompanies
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !notificationBloc.state.isLoading &&
          !notificationBloc.state.isMoreLoading) {
        int pageSize = notificationBloc.state.pageSize;
        if (notificationBloc.state.currentPage < pageSize) {
          int nextPage = notificationBloc.state.currentPage;

          notificationBloc.add(GetNotification(nextPage + 1));
        }
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.tr),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NotificationBloc>().add(GetNotification(1));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, notificationState) {
            if (notificationState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (notificationState.notificationsList.isEmpty) {
              return Center(
                child: Text(
                  'no_notifications'.tr,
                  style: body16.copyWith(color: ColorResources.gray),
                ),
              );
            }
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: notificationState.notificationsList.length,
                        itemBuilder: (context, index) {
                          return NotificationItemWidget(
                            notification:
                                notificationState.notificationsList[index],
                            index: index,
                          );
                        },
                      ),
                    ),
                    if (notificationState.isMoreLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ).paddingOnly(
                          bottom: MediaQuery.of(context).padding.bottom),
                  ],
                ),
                if (_showScrollToTopButton)
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: _scrollToTop,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorResources.primary,
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
