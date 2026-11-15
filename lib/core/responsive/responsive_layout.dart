import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

class ResponsiveBreakpoints {
  static const double tabletBreakpoint = 768.0;
  static const double desktopBreakpoint = 1200.0;
  static const Size baseDesignSize = Size(1440, 900);

  static DeviceType getDeviceType(double width) {
    if (width >= desktopBreakpoint) {
      return DeviceType.desktop;
    } else if (width >= tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < tabletBreakpoint;
  }
}

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints)? desktop;
  final Widget Function(BuildContext context, BoxConstraints constraints)? tablet;
  final Widget Function(BuildContext context, BoxConstraints constraints)? mobile;

  const ResponsiveLayoutBuilder({
    super.key,
    this.desktop,
    this.tablet,
    this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = ResponsiveBreakpoints.getDeviceType(constraints.maxWidth);

        switch (deviceType) {
          case DeviceType.desktop:
            if (desktop != null) {
              return desktop!(context, constraints);
            }
            if (tablet != null) {
              return tablet!(context, constraints);
            }
            return mobile != null ? mobile!(context, constraints) : const SizedBox.shrink();

          case DeviceType.tablet:
            if (tablet != null) {
              return tablet!(context, constraints);
            }
            if (desktop != null) {
              return desktop!(context, constraints);
            }
            return mobile != null ? mobile!(context, constraints) : const SizedBox.shrink();

          case DeviceType.mobile:
            if (mobile != null) {
              return mobile!(context, constraints);
            }
            if (tablet != null) {
              return tablet!(context, constraints);
            }
            return desktop != null ? desktop!(context, constraints) : const SizedBox.shrink();
        }
      },
    );
  }
}

class ResponsiveAppWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveAppWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ResponsiveBreakpoints.baseDesignSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => child,
    );
  }
}
