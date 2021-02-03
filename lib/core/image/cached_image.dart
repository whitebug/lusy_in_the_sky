import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachedImage {
  static get({Key key, String url}) async {
    return DefaultCacheManager().getSingleFile(url);
  }
}
