
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/journeyBloc.dart';
class AppStateContainer extends StatefulWidget {
  final Widget child;
  final BlocProvider blocProvider;
  const AppStateContainer({
    Key key,
    @required this.child,
    @required this.blocProvider,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();

  static AppState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_AppStoreContainer>() as _AppStoreContainer).appData;
  }
}

class AppState extends State<AppStateContainer> {
  BlocProvider get blocProvider => widget.blocProvider;

  @override
  Widget build(BuildContext context) {
    return _AppStoreContainer(
      appData: this,
      blocProvider: widget.blocProvider,
      child: widget.child,
    );
  }

  void dispose() {
    super.dispose();
  }

  // 'LIFTING STATE UP' REGION:
  int cartCount = 0;
  void updateCartTotal(int count) {
    setState(() => cartCount += count);
  }
}

class _AppStoreContainer extends InheritedWidget {
  final AppState appData;
  final BlocProvider blocProvider;

  _AppStoreContainer({
    Key key,
    @required this.appData,
    @required child,
    @required this.blocProvider,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_AppStoreContainer oldWidget) => oldWidget.appData != this.appData;
}

/*class ServiceProvider {
 // final CatalogService catalogService;
  //final CartService cartService;

  ServiceProvider({
   *//* @required this.catalogService,
    @required this.cartService,*//*
  });
}*/


class BlocProvider {
  journeyBloc journey_bloc;
  //CatalogBloc catalogBloc;
  //UserBloc userBloc;

  BlocProvider({

    @required this.journey_bloc,


  });
}

