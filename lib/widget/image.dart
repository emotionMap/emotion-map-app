part of 'index.dart';

class EMImage extends StatelessWidget {
  final String assetName;
  final double? size;
  final double? height;
  final double? width;
  final BoxFit fit;

  const EMImage(
    this.assetName, {
    super.key,
    this.size,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetName,
      height: size != null ? size! : height,
      width: size != null ? size! : width,
      fit: fit,
    );
  }
}

class EMSvgImage extends StatelessWidget {
  final String assetName;
  final double? size;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const EMSvgImage(
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
    return SvgPicture.asset(
      assetName,
      height: size != null ? size! : height,
      width: size != null ? size! : width,
      fit: fit,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}

class EMNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? size;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const EMNetworkImage(
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
      height: size != null ? size! : height,
      width: size != null ? size! : width,
      fit: fit,
      errorWidget: (context, url, error) => SizedBox.shrink(),
      progressIndicatorBuilder: (context, url, progress) => SizedBox.shrink(),
    );
  }
}
