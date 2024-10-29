import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_screen_event.dart';
part 'chat_screen_state.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, ChatScreenState> {
  ChatScreenBloc() : super(ChatScreenInitial()) {
    on<ChatScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}