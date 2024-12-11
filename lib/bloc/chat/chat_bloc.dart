import 'package:el_biz/data/repo/chat_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo chatRepo;
  ChatBloc(this.chatRepo) : super(const ChatState()) {
    on<UpdateShowChat>(
      (event, emit) {
        print('value of update show chat  = ${event.showChat}');
        emit(state.copyWith(isShowChat: event.showChat));
      },
    );

    on<UpdateShowAllMessages>(
      (event, emit) {
        print('value of update show all messages = ${event.showAllMessages}');
        emit(state.copyWith(isShowAllMessage: event.showAllMessages));
      },
    );

    on<UpdateShowMySales>(
      (event, emit) {
        print('value of update show my sales = ${event.showMySales}');
        emit(state.copyWith(isShowMySales: event.showMySales));
      },
    );
  }
}
