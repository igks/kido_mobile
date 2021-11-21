part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class PageInitial extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMenuPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnJudulDoaPage extends PageState {
  final Category category;
  OnJudulDoaPage(this.category);
  @override
  List<Object> get props => [category];
}

class OnContentDoaPage extends PageState {
  final Title title;
  final Category category;

  OnContentDoaPage(this.title, this.category);
  @override
  List<Object> get props => [title];
}

class OnFavoritePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnFavoriteDetailPage extends PageState {
  final Content content;
  OnFavoriteDetailPage(this.content);
  @override
  List<Object> get props => [content];
}

class OnSearchPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnInformationPage extends PageState {
  @override
  List<Object> get props => [];
}
