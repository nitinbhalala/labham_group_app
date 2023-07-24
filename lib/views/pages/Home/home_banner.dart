// ignore_for_file: sized_box_for_whitespace, avoid_print, unused_element, no_leading_underscores_for_local_identifiers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/shimmer_loader.dart';
import 'package:sizer/sizer.dart';
import '../../../businessLogic/blocs/BannerBloc/banner_state.dart';
import '../../../businessLogic/blocs/BannerBloc/banner_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../comman/app_text.dart';
import '../../comman/loader.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetBannerCubit(ApiServices()),
      child: BlocBuilder<GetBannerCubit, GetBannerState>(
        builder: (context, state) {
          if (state is GetBannerLodingState) {
            return const Center(child: ShimmerLoader());
          }
          if (state is GetBannerLoadadState) {
            return state.banner.isNotEmpty ? state.banner.length > 1
                ? Swiper(
                    itemCount: state.banner.length,
                    autoplay: true,
                    itemBuilder: (context, index) {
                      var bannerList = state.banner[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5.w),
                            bottomRight: Radius.circular(5.w)),
                        child: CachedNetworkImage(
                            imageUrl: bannerList['banner_url'],
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, progress) {
                              return const Center(child: ShimmerLoader());
                            }),
                      );
                    },
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 4.h),
                      builder: const DotSwiperPaginationBuilder(
                        size: 5,
                        activeSize: 7,
                        color: AppColors.GREY,
                        activeColor: AppColors.WHITE_COLOR,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.w),
                        bottomRight: Radius.circular(5.w)),
                    child: CachedNetworkImage(
                        imageUrl: state.banner[0]['banner_url'],
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Center(
                            child: Loader(
                              color: AppColors.PRIMERY_COLOR,
                            ),
                          );
                        }),
                  ) :const SizedBox();
          }
          if (state is GetBannerErrorState) {
            return Center(
              child: appText(title: state.error),
            );
          }
          return Container();
        },
      ),
    );

    // CarouselSlider(
    //     items: List.generate(
    //         3,
    //         (index) => ClipRRect(
    //             borderRadius: BorderRadius.circular(4.w),
    //             child: Image.asset(AppAssets.BANNER,fit: BoxFit.cover,))),
    //     options: CarouselOptions(
    //       height: 25.h,
    //       viewportFraction: 0.7,
    //       initialPage: 0,
    //       enableInfiniteScroll: true,
    //       reverse: false,
    //       autoPlay: true,
    //       autoPlayInterval: const Duration(seconds: 3),
    //       autoPlayAnimationDuration: const Duration(milliseconds: 800),
    //       autoPlayCurve: Curves.fastOutSlowIn,
    //       enlargeCenterPage: true,

    //       // onPageChanged: callbackFunction,
    //       scrollDirection: Axis.horizontal,
    //     ));
  }
}
