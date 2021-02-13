import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:catalog_domain/catalog_domain.dart';
import 'package:lusy_in_the_sky/features/catalog/blocs/catalog_bloc/catalog_bloc.dart';
import 'package:lusy_in_the_sky/features/catalog/widgets/widgets.dart';

class ItemTab extends StatefulWidget {
  @override
  _ItemTabState createState() => _ItemTabState();
}

class _ItemTabState extends State<ItemTab> {
  // ignore: close_sinks
  CatalogBloc _catalogBloc;

  @override
  void initState() {
    super.initState();
    _catalogBloc = BlocProvider.of<CatalogBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
        cubit: _catalogBloc,
        builder: (context, catalogState) {
          if (catalogState is GetCatalogItemListState) {
            return PageView.builder(
                //preloadPagesCount: 2,
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: catalogState.catalogItemList.length,
                itemBuilder: (context, index) {
                  CatalogItem _currentItem =
                      catalogState.catalogItemList[index];
                  return Stack(
                    children: [
                      VideoBackground(
                        image: _currentItem.image,
                        video: _currentItem.regularVideo,
                      ),
                      Positioned(
                        left: ScreenUtil().setWidth(15),
                        bottom: ScreenUtil().setHeight(71),
                        child: Row(
                          children: [
                            Text(
                              _currentItem.price,
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(7),
                            ),
                            Text(
                              _currentItem.special,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: ScreenUtil().setWidth(15),
                        bottom: ScreenUtil().setHeight(93),
                        child: Text(
                          _currentItem.name,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(11),
                          ),
                        ),
                      ),
                      BuyButton(
                        onTap: () {},
                      ),
                      FavoriteButton(
                        onTap: () {},
                      ),
                    ],
                  );
                });
          } else if (catalogState is CatalogErrorState) {
            return Center(
              child: Text(catalogState.error),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
