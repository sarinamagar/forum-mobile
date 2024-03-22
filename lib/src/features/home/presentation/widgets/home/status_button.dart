import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/features/home/presentation/bloc/home_bloc.dart';

class StatusButton extends StatefulWidget {
  final String userId;
  final String status;

  const StatusButton({Key? key, required this.status, required this.userId})
      : super(key: key);

  @override
  State<StatusButton> createState() => _StatusButtonState();
}

class _StatusButtonState extends State<StatusButton> {
  late String statusText;
  late Color statusColor;

  @override
  void initState() {
    super.initState();
    statusText = widget.status == "online" ? "On" : "Off";
    statusColor =
        widget.status == "online" ? AppColors.green : AppColors.shadow;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<HomeBloc>().add(UpdateStatus(userID: widget.userId));
            setState(() {
              statusText =
                  context.read<HomeBloc>().status == "offline" ? "On" : "Off";
              statusColor = context.read<HomeBloc>().status == "offline"
                  ? AppColors.green
                  : AppColors.shadow;
            });
          },
          child: Container(
            width: context.width / 2,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: statusColor,
              ),
              borderRadius: BorderRadius.circular(isTablet ? 26 : 14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: isTablet ? 20 : 16,
                  height: isTablet ? 20 : 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: statusColor,
                    border: Border.all(
                      color: AppColors.piano,
                      width: 2,
                    ),
                  ),
                ),
                SizedBox(width: isTablet ? 10 : 4),
                Text(
                  "Online Status: $statusText",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      fontSize: isTablet ? 20 : null),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
