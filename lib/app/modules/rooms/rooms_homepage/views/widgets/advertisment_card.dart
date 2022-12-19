import 'package:easy_hotel/app/components/image_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/values/app_assets.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdCard extends StatelessWidget {
  const AdCard({Key? key, required this.hotel, required this.image, required this.name}) : super(key: key);
  final String hotel;
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        clipBehavior: Clip.antiAlias,
        width: 250,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
                child: ImageWidget(
                  path: image,
                  fit: BoxFit.fill,
                  backgroundColor: Colors.black12,
                )),
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Expanded(
                        flex: 2,
                        child: TextWidget(
                          name,
                          maxLines: 1,
                          textColor: Colors.white,
                          weight: FontWeight.bold,
                        )),
                    // Expanded(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         TextWidget(stars.toString(),textColor: Colors.white,),
                    //         Icon(Icons.star_rounded,color: Colors.white,)
                    //       ],
                    //     )),
                     Expanded(
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: TextWidget(
                          hotel,
                          size: 11,
                          textColor: Colors.white,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
