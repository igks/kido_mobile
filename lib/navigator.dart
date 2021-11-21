import 'package:doa_kidung_flutter/bloc/page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doa_kidung_flutter/pages/pages.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  void showSplash() async {
    context.read<PageBloc>().add(ToSplashPage());
  }

  @override
  void initState() {
    super.initState();
    showSplash();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(builder: (_, state) {
      if (state is OnSplashPage) {
        return SplashPage();
      } else if (state is OnMenuPage) {
        return MenuPage();
      } else if (state is OnJudulDoaPage) {
        return JudulDoaPage(
          category: state.category,
        );
      } else if (state is OnContentDoaPage) {
        return ContentDoaPage(
          title: state.title,
          category: state.category,
        );
      } else if (state is OnFavoritePage) {
        return FavoritePage();
      } else if (state is OnFavoriteDetailPage) {
        return FavoriteDetailPage(content: state.content);
      } else if (state is OnSearchPage) {
        return SearchPage();
      } else if (state is OnInformationPage) {
        return InformationPage();
      } else {
        return SplashPage();
      }
    });
  }
}
