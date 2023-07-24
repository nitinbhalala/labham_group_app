// ignore_for_file: unnecessary_null_comparison, no_leading_underscores_for_local_identifiers

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/businessLogic/blocs/VideoList/video_cubit.dart';
import 'package:minimall_store/businessLogic/blocs/VideoList/video_sate.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/loader.dart';
import 'package:minimall_store/views/comman/no_found.dart';
import 'package:minimall_store/views/pages/Video/view_video.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../comman/app_text.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final Map<String, VideoPlayerController> _initializedControllers = {};
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return BlocProvider(
      create: (context) => VideoListCubit(ApiServices()),
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
            title: lang?.getTranslatedValue('Video'),
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
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
              child: BlocBuilder<VideoListCubit, VideoListState>(
                  builder: (context, state) {
                if (state is VideoListLodingState) {
                  return Center(
                    child: Loader(
                      color: AppColors.PRIMERY_COLOR,
                    ),
                  );
                }
                if (state is VideoLoadadState) {
                  return state.video.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.video.length,
                          itemBuilder: (context, index) {
                            var data = state.video[index];

                            VideoPlayerController _controller;

                            if (_initializedControllers
                                .containsKey(data['video_url'])) {
                              _controller =
                                  _initializedControllers[data['video_url']]!;
                            } else {
                              _controller = VideoPlayerController.network(
                                  data['video_url']);
                              _initializedControllers[data['video_url']] =
                                  _controller;

                              _controller.initialize().then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewVideo(videoUrl: data['video_url'])));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 2.h),
                                  height: 20.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.WHITE_COLOR,
                                      borderRadius: BorderRadius.circular(4.w)),
                                  child: isLoading
                                      ? Center(child: Loader())
                                      : Stack(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4.w),
                                                child:
                                                    VideoPlayer(_controller)),
                                            Center(
                                                child: Icon(
                                              Icons.play_circle,
                                              size: 6.h,
                                              color: AppColors.WHITE_COLOR,
                                            ))
                                          ],
                                        )),
                            );
                          })
                      : noFound(
                          title: lang?.getTranslatedValue('Video not found'));
                }
                if (state is VideoListErrorState) {
                  return Center(
                    child: appText(title: state.error),
                  );
                }
                return Container();
              })),
        ),
      ),
    );
  }
}
