
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../constance/constance.dart';
class BannerSlider extends StatefulWidget {
  const BannerSlider({Key key}) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: MediaQuery.of(context).size.width - 20,
      child: Swiper(
        itemCount: ConstanceData.bannerList.length,
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),

          child: CarouselSlider(
            options: CarouselOptions(height: 400.0),
            items: ConstanceData.bannerList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      image:DecorationImage(
                        image: NetworkImage(
                          i.url,
                          scale: 1,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          // autoplay: false,
        ),
      ),
    );
  }
}
