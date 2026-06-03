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
  final BorderRadiusGeometry borderRadius;
  final ImageErrorWidgetBuilder? errorBuilder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  const MPNetworkImage(
    this.imageUrl, {
    super.key,
    this.size,
    this.height,
    this.width,
    this.color,
    this.fit = .cover,
    this.borderRadius = .zero,
    this.errorBuilder,
    this.progressIndicatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final imageHeight = size?.r ?? height?.h;
    final imageWidth = size?.r ?? width?.w;

    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: imageHeight,
        width: imageWidth,
        fit: fit,
        errorBuilder:
            errorBuilder ??
            (context, url, error) => _MPNetworkImageSkeletonPlaceholder(
              height: imageHeight,
              width: imageWidth,
              borderRadius: borderRadius,
            ),
        progressIndicatorBuilder:
            progressIndicatorBuilder ??
            (context, url, progress) => _MPNetworkImageSkeletonPlaceholder(
              height: imageHeight,
              width: imageWidth,
              borderRadius: borderRadius,
            ),
      ),
    );
  }
}

class _MPNetworkImageSkeletonPlaceholder extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;

  const _MPNetworkImageSkeletonPlaceholder({
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final placeholderHeight =
            height ??
            (constraints.hasBoundedHeight ? constraints.maxHeight : null);
        final placeholderWidth =
            width ??
            (constraints.hasBoundedWidth ? constraints.maxWidth : null);

        return Skeletonizer(
          child: Skeleton.unite(
            borderRadius: borderRadius,
            child: Skeleton.replace(
              height: placeholderHeight,
              width: placeholderWidth,
              child: SizedBox(
                height: placeholderHeight,
                width: placeholderWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
