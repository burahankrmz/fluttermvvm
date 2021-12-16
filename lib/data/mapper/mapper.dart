//! to convert the response into non nullable object (model)
import 'package:flutteradvancedmvvm/data/responses/responses.dart';
import 'package:flutteradvancedmvvm/domain/model/model.dart';
import 'package:flutteradvancedmvvm/app/extensions.dart';

// ignore: constant_identifier_names
const EMPTY = "";
// ignore: constant_identifier_names
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email?.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

//! toDomain extensionlari ile gelen responseler modellere donusturuldu.
extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}

extension ForgotPassswordResponseManager on ForgotPasswordResponse? {
  ForgotPassword toDomain() {
    return ForgotPassword(this?.support?.orEmpty() ?? EMPTY);
  }
}

//! HOME RESPONSES MAPPER

extension ServicesResponsesMapper on ServicesResponse? {
  Services toDomain() {
    return Services(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension BannersResponsesMapper on BannersResponse? {
  BannersAd toDomain() {
    return BannersAd(this?.id?.orZero() ?? ZERO, this?.link?.orEmpty() ?? EMPTY,
        this?.title?.orEmpty() ?? EMPTY, this?.image?.orEmpty() ?? EMPTY);
  }
}

extension StoresResponsesMapper on StoresResponse? {
  Stores toDomain() {
    return Stores(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Services> mappedServices =
        (this?.data?.services?.map((services) => services.toDomain()) ??
                const Iterable.empty())
            .cast<Services>()
            .toList();
    List<BannersAd> mappedBanners =
        (this?.data?.banners?.map((bannersAd) => bannersAd.toDomain()) ??
                const Iterable.empty())
            .cast<BannersAd>()
            .toList();
    List<Stores> mappedStores =
        (this?.data?.stores?.map((stores) => stores.toDomain()) ??
                const Iterable.empty())
            .cast<Stores>()
            .toList();
    var data = HomeData(mappedServices, mappedBanners, mappedStores);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
        this?.id?.orZero() ?? ZERO,
        this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY,
        this?.details?.orEmpty() ?? EMPTY,
        this?.services?.orEmpty() ?? EMPTY,
        this?.about?.orEmpty() ?? EMPTY);
  }
}
