import 'package:soon_sak/utilities/index.dart';

class LinearLayeredPosterImg extends StatelessWidget {
  const LinearLayeredPosterImg({
    Key? key,
    required this.imgUrl,
    this.aspectRatio = 2 / 3,
    this.borderRadius = 12,
    this.usedInCuration = false,
    this.linearColor = AppColor.black,
    this.linearStep = const [0.1, 0.5, 1.0],
    this.linearBeginPosition = Alignment.topCenter,
    this.linearEndPosition = Alignment.bottomCenter,
  }) : super(key: key);

  final double? borderRadius;
  final double? aspectRatio;
  final String? imgUrl;
  final Color? linearColor;
  final List<double>? linearStep;
  final Alignment? linearBeginPosition;
  final Alignment? linearEndPosition;
  final bool? usedInCuration;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius!),
      child: AspectRatio(
        aspectRatio: aspectRatio!,
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              memCacheWidth: SizeConfig.to.screenWidth.toInt() *
                  (usedInCuration ?? false ? 1 : 2),
              imageUrl: imgUrl?.prefixTmdbImgPath ?? '',
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),

            // Linear Over Layer
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    linearColor!,
                  ],
                  begin: linearBeginPosition!,
                  end: linearEndPosition!,
                  stops: linearStep,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
