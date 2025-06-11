import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/contracts/my_purchases_widget.dart';
import 'package:el_biz/view/screen/chat/widgets/contracts/my_sales_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContractsListWidget extends StatelessWidget {
  const ContractsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, chatState) {
      if (chatState.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      final userId =
          context.read<UserBloc>().state.userInfo!.data!.id.toString();

      if (chatState.isShowMySales) {
        return MySalesWidget(currentUserId: userId);
      } else {
        return MyPurchasesWidget(currentUserId: userId);
      }
    });
  }
}
