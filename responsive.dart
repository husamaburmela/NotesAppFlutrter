import 'package:flutter/material.dart';

//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Responseive screens
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Responseive screens
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Responseive screens
// BaseWidget >
class BaseWidget extends StatelessWidget {
  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;

  const BaseWidget({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return LayoutBuilder(builder: (context, boxConstraints) {
      var sizingInformation = SizingInformation(
        orientation: mediaQuery.orientation,
        deviceScreenType: getDeviceType(mediaQuery),
        screenSize: mediaQuery.size,
        localWidgetSize:
            Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
      );
      return builder(context, sizingInformation);
    });
  }
}

// SizingInformation >
class SizingInformation {
  final Orientation? orientation;
  final DeviceScreenType? deviceScreenType;
  final Size? screenSize;
  final Size? localWidgetSize;
  SizingInformation(
      {this.orientation,
      this.deviceScreenType,
      this.screenSize,
      this.localWidgetSize});
  @override
  String toString() {
    return 'Orientation:$orientation DeviceScreenType:$deviceScreenType ScreenSize:$screenSize LocalWidgetSize:$localWidgetSize';
  }
}

// DeviceScreenType >
enum DeviceScreenType { mobile, tablet, desktop }

// Get DeviceType >
DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  var orientation = mediaQuery.orientation;
  double deviceWidth = 0;
  if (orientation == Orientation.landscape) {
    deviceWidth = mediaQuery.size.height;
  } else {
    deviceWidth = mediaQuery.size.width;
  }
  if (deviceWidth > 950) {
    return DeviceScreenType.desktop;
  }
  if (deviceWidth > 600) {
    return DeviceScreenType.tablet;
  }
  return DeviceScreenType.mobile;
}




  class HomeViewTest2 extends StatelessWidget {
  const HomeViewTest2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return BaseWidget(builder: (context, sizingInformation) =>
Container(
        width: sizingInformation.screenSize!.width)
);
}
 
}
// How to use ?! >
// sizingInformation.toString() ( Print this for sizes )
// sizingInformation.screenSize!.height
// sizingInformation.screenSize!.width
// sizingInformation.localWidgetSize!.width (max width)
// sizingInformation.localWidgetSize!.height (max height)
// sizingInformation.orientation (for check if portrait or landscape)
// sizingInformation.deviceScreenType (for check if mobile or tablet or desktop)

//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Responseive screens
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Responseive screens
//IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII Responseive screens