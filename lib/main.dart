import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lusy_in_the_sky/core/route/lucy_router.gr.dart';
import 'package:lusy_in_the_sky/features/catalog/presentation/blocs/catalog_bloc/catalog_bloc.dart';
import 'package:lusy_in_the_sky/features/catalog/presentation/blocs/lucy_bloc_observer.dart';
import 'package:lusy_in_the_sky/injection_container.dart' as getIt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.setup();
  Bloc.observer = LucyBlocObserver();
  runApp(LucyApp());
}

class LucyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatalogBloc>(
          create: (BuildContext context) => getIt.getIt<CatalogBloc>(),
        ),
      ],
      child: OrientationBuilder(
        builder: (context, orientation) {
          return ScreenUtilInit(
            allowFontScaling: false,
            designSize: orientation == Orientation.portrait
                ? Size(375, 667)
                : Size(667, 375),
            child: MaterialApp(
              title: 'Lucy app',
              builder: ExtendedNavigator.builder(
                router: LucyRouter(),
                initialRoute: Routes.catalogPage,
                builder: (context, extendedNav) => Theme(
                  data: ThemeData(
                    brightness: Brightness.light,
                    textTheme: TextTheme(
                      bodyText2: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        color: Colors.black,
                      ),
                      button: TextStyle(
                        fontSize: ScreenUtil().setSp(10),
                      ),
                    ),
                  ),
                  child: extendedNav,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
