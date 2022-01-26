//! SliderObject class tanimlandi.
class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(
    this.title,
    this.subTitle,
    this.image,
  );
}

//! login icin modeller
class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String email;
  String phone;
  String link;
  Contacts(this.email, this.phone, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class ForgotPassword {
  String? support;
  ForgotPassword(this.support);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}

//? HOME MODELS

class Services {
  int id;
  String title;
  String image;

  Services(this.id, this.title, this.image);
}

class BannersAd {
  int id;
  String link;
  String title;
  String image;

  BannersAd(this.id, this.link, this.title, this.image);
}

class Stores {
  int id;
  String title;
  String image;

  Stores(this.id, this.title, this.image);
}

class HomeData {
  List<Services> services;
  List<BannersAd> bannersAd;
  List<Stores> stores;

  HomeData(this.services, this.bannersAd, this.stores);
}

class HomeObject {
  HomeData data;
  HomeObject(this.data);
}

class StoreDetails {
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoreDetails(
      this.id, this.title, this.image, this.details, this.services, this.about);
}
