part of 'index.dart';

class MPImage extends StatelessWidget {
  final String assetName;
  final double? size;
  final double? height;
  final double? width;
  final BoxFit fit;

  const MPImage(
    this.assetName, {
    super.key,
    this.size,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      child: Image.asset(
        assetName,
        height: size?.r ?? height?.h,
        width: size?.r ?? width?.w,
        fit: fit,
      ),
    );
  }
}

class MPSvgImage extends StatelessWidget {
  final String assetName;
  final double? size;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const MPSvgImage(
    this.assetName, {
    super.key,
    this.size,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      child: SvgPicture.asset(
        assetName,
        height: size?.r ?? height?.h,
        width: size?.r ?? width?.w,
        fit: fit,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      ),
    );
  }
}

class MPNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? size;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const MPNetworkImage(
    this.imageUrl, {
    super.key,
    this.size,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: size?.r ?? height?.h,
      width: size?.r ?? width?.w,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          Skeletonizer(child: Skeleton.replace(child: Container())),
      progressIndicatorBuilder: (context, url, progress) =>
          Skeletonizer(child: Skeleton.replace(child: Container())),
    );
  }
}
