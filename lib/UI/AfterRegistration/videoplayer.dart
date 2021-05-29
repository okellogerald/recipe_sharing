import 'package:recipes_sharing/source.dart';

class VideoPlayer extends StatelessWidget {
  final String videoLink, image;
  final Widget placeholder;
  final Size size;
  final ThemesData colors;
  final int index;
  const VideoPlayer(
      {Key key,
      this.size,
      this.colors,
      this.index,
      this.image,
      this.videoLink,
      this.placeholder})
      : super(key: key);

  static final _showPreviewVideo = ValueNotifier<bool>(false);
  VlcPlayerController vlcPlayerController(
      {String video, bool autoplay = false}) {
    final _videoPlayerController = VlcPlayerController.network(
      video,
      hwAcc: HwAcc.FULL,
      autoPlay: autoplay,
      options: VlcPlayerOptions(),
    );
    return _videoPlayerController;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _showPreviewVideo,
        builder: (context, child, snapshot) {
          return Container(
              height: 250,
              width: size.width,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                  left: _showPreviewVideo.value && index ==valuesKeeper.itemIndex? 0 : 10,
                  bottom: _showPreviewVideo.value && index ==valuesKeeper.itemIndex? 0 : 5),
              decoration:
                  _showPreviewVideo.value && index == valuesKeeper.itemIndex
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(image))),
              child: _showPreviewVideo.value && index == valuesKeeper.itemIndex
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                onTap: () {
                                  _showPreviewVideo.value = false;
                                },
                                child: Icon(EvaIcons.close,
                                    color: colors.iconColor))),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: VlcPlayer(
                            aspectRatio: 16 / 9,
                            placeholder: placeholder,
                            controller: vlcPlayerController(
                                video: videoLink, autoplay: true),
                          ),
                        ),
                      ],
                    )
                  : TextButton(
                      onPressed: () {
                        valuesKeeper.itemIndex = index;
                        _showPreviewVideo.value =
                            index == valuesKeeper.itemIndex ? true : false;
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          backgroundColor: colors.buttonColor2),
                      child: Text('Preview',
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 16,
                              color: colors.textColor1))));
        });
  }
}
