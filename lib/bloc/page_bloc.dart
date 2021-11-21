import 'package:bloc/bloc.dart';
import 'package:doa_kidung_flutter/models/models.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    on<ToMenuPage>((event, emit) {
      emit(OnMenuPage());
    });

    on<ToSplashPage>((event, emit) {
      emit(OnSplashPage());
    });

    on<ToJudulDoaPage>((event, emit) {
      emit(OnJudulDoaPage(event.category));
    });

    on<ToContentDoaPage>((event, emit) {
      emit(OnContentDoaPage(event.title, event.category));
    });

    on<ToFavoritePage>((event, emit) {
      emit(OnFavoritePage());
    });

    on<ToFavoriteDetailPage>((event, emit) {
      emit(OnFavoriteDetailPage(event.content));
    });

    on<ToSearchPage>((event, emit) {
      emit(OnSearchPage());
    });

    on<ToInformationPage>((event, emit) {
      emit(OnInformationPage());
    });

    on<ToPersiapanPage>((event, emit) {
      emit(OnPersiapanPage());
    });
  }
}
