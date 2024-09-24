// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/blog_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../utils/app_icon.dart';

class PostDetailScreen extends StatefulWidget {
  final BlogModel blog;
  const PostDetailScreen({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  bool _isPlayerReady = false;
  late String idVideo;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    if (widget.blog.link != null) {
      _controller = YoutubePlayerController(
        initialVideoId: widget.blog.link!,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: true,
          isLive: false,
          forceHD: true,
          enableCaption: false,
          hideControls: true,
        ),
      )..addListener(listener);
      _idController = TextEditingController();
      _seekToController = TextEditingController();
    }
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  void deactivated() {
    if (widget.blog.link != null) {
      _controller.pause();
    }
  }

  void diposed() {
    if (widget.blog.link != null) {
      _controller.dispose();
      _idController.dispose();
      _seekToController.dispose();
    }
  }

  @override
  void deactivate() {
    deactivated();
    super.deactivate();
  }

  @override
  void dispose() {
    diposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.blog.link != null
        ? YoutubePlayerBuilder(
            onExitFullScreen: () {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: [
                    SystemUiOverlay.top,
                  ]);
              setPortraitOrientation();
            },
            onEnterFullScreen: () {
              setLandscapeOrientation();
            },
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _controller.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                _controller.load(idVideo);
              },
            ),
            builder: (p0, player) {
              return _buildBody(player);
            },
          )
        : _buildBody(null);
  }

  _buildBody(Widget? player) {
    return Scaffold(
      backgroundColor: primary900,
      appBar: AppBar(
        backgroundColor: primary900,
        leading: const KBackButton(),
        centerTitle: true,
        title: TextWidget(
          text: 'Tin tức công ty',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 320.h,
            width: double.infinity,
            child: Stack(
              children: [
                networkImageWithCached(
                  size: Size(double.infinity, 320.h),
                  url: widget.blog.image,
                  borderRadius: 0,
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.6,
            maxChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.3),
                      blurRadius: 100,
                      spreadRadius: 10,
                      offset: const Offset(0, -10),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      16.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Hành chính nhân sự',
                                color: black,
                                textStyle: textStyle17,
                              ),
                              TextWidget(
                                text: formatPostDateTime(widget.blog.createdAt),
                                color: black,
                                textStyle: textStyle12SemiBold,
                              ),
                            ],
                          ),
                          Container(
                              height: 35.h,
                              width: 35.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: primary900),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(17))),
                              child: Image.asset(AppIcon.group, scale: 3.5)),
                        ],
                      ),
                      16.verticalSpace,
                      const Divider(height: 0, color: black),
                      12.verticalSpace,
                      TextWidget(
                        text: widget.blog.title ?? '',
                        color: black,
                        textStyle: textStyle16Bold,
                        maxLines: 3,
                      ),
                      12.verticalSpace,
                      if (player != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: player,
                        ),
                        12.verticalSpace,
                      ],
                      TextWidget(
                        text: widget.blog.content ?? '',
                        color: black,
                        textStyle: textStyle12,
                        maxLines: 200,
                      ),
                      30.verticalSpace,
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

// Chuyển sang chế độ xoay ngang
void setLandscapeOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

// Trở lại chế độ màn hình bình thường
void setPortraitOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

// Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Container(
//                       color: rose300,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconButton(
//                             icon: const Icon(
//                               Icons.fast_rewind,
//                               color: white,
//                             ),
//                             onPressed: _isPlayerReady
//                                 ? () => _controller.seekTo(Duration(
//                                     seconds:
//                                         _controller.value.position.inSeconds -
//                                             10))
//                                 : null,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               _controller.value.isPlaying
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                               color: white,
//                             ),
//                             onPressed: _isPlayerReady
//                                 ? () {
//                                     _controller.value.isPlaying
//                                         ? _controller.pause()
//                                         : _controller.play();
//                                     setState(() {});
//                                   }
//                                 : null,
//                           ),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.fast_forward,
//                               color: white,
//                             ),
//                             onPressed: _isPlayerReady
//                                 ? () => _controller.seekTo(Duration(
//                                     seconds:
//                                         _controller.value.position.inSeconds +
//                                             10))
//                                 : null,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               _muted ? Icons.volume_off : Icons.volume_up,
//                               color: white,
//                             ),
//                             onPressed: _isPlayerReady
//                                 ? () {
//                                     _muted
//                                         ? _controller.unMute()
//                                         : _controller.mute();
//                                     setState(() {
//                                       _muted = !_muted;
//                                     });
//                                   }
//                                 : null,
//                           ),
//                           FullScreenButton(
//                             controller: _controller,
//                             color: white,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
