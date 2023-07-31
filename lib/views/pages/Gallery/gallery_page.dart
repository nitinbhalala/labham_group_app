// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/Cubit/GalleryList/gallery_list_state.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/loader.dart';
import 'package:minimall_store/views/comman/no_found.dart';
import 'package:minimall_store/views/comman/shimmer_loader.dart';
import 'package:minimall_store/views/pages/Gallery/view_image.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../Cubit/GalleryList/gellary_list_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../comman/app_text.dart';

class GalleyPage extends StatefulWidget {
  const GalleyPage({super.key});

  @override
  State<GalleyPage> createState() => _GalleyPageState();
}

class _GalleyPageState extends State<GalleyPage> {
  // final GallerytListBloc _gallerytListBloc =
  //     GallerytListBloc(LabhamRepository());

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return BlocProvider(
      create: (context) => GallerytListCubit(ApiServices()),
      child: Scaffold(
        backgroundColor: AppColors.PRIMERY_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.PRIMERY_COLOR,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.WHITE_COLOR,
            ),
          ),
          title: appText(
            title: lang?.getTranslatedValue('Gallery'),
            fontFamily: AppFonts.latoBold,
            fontWeight: FontWeight.w700,
            color: AppColors.WHITE_COLOR,
          ),
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.WHITE_COLOR,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.w),
              topRight: Radius.circular(7.w),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: BlocBuilder<GallerytListCubit, GalleryListState>(
              builder: (context, state) {
                if (state is GalleryLodingState) {
                  return Center(
                    child: Loader(
                      color: AppColors.PRIMERY_COLOR,
                    ),
                  );
                }
                if (state is GalleryLoadadState) {
                  return state.gallery.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: state.gallery.length,
                          itemBuilder: (context, index) {
                            var data = state.gallery[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewImage(
                                          image: state.gallery,
                                          currentIndex: index),
                                    ));
                              },
                              child: Card(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4.w),
                                      child: CachedNetworkImage(
                                        imageUrl: data['image_url'],
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, progress) {
                                          return const ShimmerLoader();
                                        },
                                      ))),
                            );
                          },
                          addAutomaticKeepAlives: true,
                          cacheExtent: double.infinity,
                        )
                      : noFound(
                          title: lang?.getTranslatedValue('Gallery not found'));
                }
                if (state is GalleryErrorState) {
                  return Center(
                    child: appText(title: state.error),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
