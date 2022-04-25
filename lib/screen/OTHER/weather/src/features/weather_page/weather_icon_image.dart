import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeatherIconImage extends StatelessWidget {
  const WeatherIconImage({Key key, this.iconUrl, this.size})
      : super(key: key);
  final String iconUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: iconUrl,
      width: size,
      height: size,
    );
  }
}
