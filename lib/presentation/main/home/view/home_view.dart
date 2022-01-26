import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../app/dependency_injection.dart';
import '../../../../core/colors/color_manager.dart';
import '../../../../core/constants/strings_manager.dart';
import '../../../../core/constants/value_manager.dart';
import '../../../../core/routes/routes_manager.dart';
import '../../../../domain/model/model.dart';
import '../../../common/state_renderer_impl.dart';
import '../viewmodel/home_viewmodel.dart';

import 'package:easy_localization/easy_localization.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();
  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  }) ??
                  Container();
            }),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewObject>(
        stream: _viewModel.outputHomeData,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getBanners(snapshot.data?.banners),
              _getSection(AppStrings.services.tr()),
              _getServicesWidget(snapshot.data?.services),
              _getSection(AppStrings.stores.tr()),
              _getStoresWidget(snapshot.data?.stores),
            ],
          );
        });
  }

  Widget _getBanners(List<BannersAd>? bannersAd) {
    if (bannersAd != null) {
      return FadeInDown(
        child: CarouselSlider(
          items: bannersAd
              .map(
                (banner) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: AppSize.s1_5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.white, width: AppSize.s1_5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      child: Image.network(
                        banner.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
              height: AppSize.s190,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true),
        ),
      );
    }
    return Container();
  }

  Widget _getServicesWidget(List<Services>? services) {
    if (services != null) {
      return FadeInDown(
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p12, right: AppPadding.p12),
          child: Container(
            height: AppSize.s140,
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: services
                  .map((service) => Card(
                        elevation: AppSize.s4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            side: BorderSide(
                                color: ColorManager.white,
                                width: AppSize.s1_5)),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              child: Image.network(
                                service.image,
                                fit: BoxFit.cover,
                                width: AppSize.s120,
                                height: AppSize.s100,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: AppPadding.p8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  service.title,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoresWidget(List<Stores>? stores) {
    if (stores != null) {
      return FadeInDown(
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
          child: Flex(
            direction: Axis.vertical,
            children: [
              GridView.count(
                crossAxisSpacing: AppSize.s8,
                mainAxisSpacing: AppSize.s8,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(stores.length, (index) {
                  return InkWell(
                    onTap: () {
                      // navigate to store details screen
                      Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                    },
                    child: Card(
                      elevation: AppSize.s4,
                      child: Image.network(
                        stores[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p12,
            right: AppPadding.p12,
            bottom: AppPadding.p2),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
