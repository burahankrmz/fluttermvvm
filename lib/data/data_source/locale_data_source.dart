import '../network/error_handler.dart';
import '../responses/responses.dart';

// ignore: constant_identifier_names
const CACHE_HOME_KEY = "CACHE_HOME_KEY";
// ignore: constant_identifier_names
const CACHE_HOME_INTERVAL = 60 * 1000; //? 1 MINUTE IN MILLIS
// ignore: constant_identifier_names
const CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
// ignore: constant_identifier_names
const CACHE_STORE_DETAILS_INTERVAL = 60 * 1000; // 30s in millis

abstract class LocaleDataSource {
  Future<HomeResponse> getHome();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response);
}

class LocaleDataSourceImpl implements LocaleDataSource {
  //! runtime cache
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async{
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if (cachedItem != null &&
        cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response) async{
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(response);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    //? expiration time is 60secs
    int currentTimeInMillis =
        DateTime.now().millisecondsSinceEpoch; //? time now is 1:00:00
    bool isCacheValid = currentTimeInMillis - expirationTime <
        cacheTime; //? cache time was in 12:59:30
    //? false if current time > 1:00:30
    //? otherwise true
    return isCacheValid;
  }
}
