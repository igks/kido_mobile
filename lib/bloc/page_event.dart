part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class ToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class ToMenuPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class ToJudulDoaPage extends PageEvent {
  final Category category;
  ToJudulDoaPage(this.category);
  @override
  List<Object> get props => [category];
}

class ToContentDoaPage extends PageEvent {
  final Title title;
  final Category category;

  ToContentDoaPage(this.title, this.category);
  @override
  List<Object> get props => [title];
}

class ToFavoritePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class ToFavoriteDetailPage extends PageEvent {
  final Content content;
  ToFavoriteDetailPage(this.content);

  @override
  List<Object> get props => [content];
}

class ToSearchPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class ToInformationPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class ToPersiapanPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class ToCachedPage extends PageEvent {
  final Map<String, dynamic> title;
  ToCachedPage(this.title);

  @override
  List<Object> get props => [title];
}
