// import 'package:flutter/material.dart';

// class CircleImageAvatar extends StatelessWidget {
//   final double? radius;
//   final bool? enableNavigate;
//   const CircleImageAvatar({
//     super.key,
//     this.radius,
//     this.enableNavigate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       // onTap: enableNavigate != null && !enableNavigate!
//       //     ? null
//       //     : () {
//       //         Navigator.of(context).pushNamed(
//       //           Routes.profileScreen,
//       //           arguments: personInfo,
//       //         );
//       //       },
//       onTap: () {},
//       child: ClipOval(
//         child: SizedBox.fromSize(
//           size: Size.fromRadius(radius ?? 20),
//           child: ImageBuilder(
//             imageUrl: personInfo.imageUrl,
//           ),
//         ),
//       ),
//     );
//   }
// }
