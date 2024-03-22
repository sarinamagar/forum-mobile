import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/core/widgets/posts/post_view.dart';
import 'package:forum/src/features/home/presentation/bloc/home_bloc.dart';

class PostBuilder extends StatelessWidget {
  final User userInfo;
  const PostBuilder({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomePostsLoadingFailed) {
          buildToast(toastType: ToastType.error, msg: state.message);
        }
      },
      buildWhen: (previous, current) {
        return current is HomePostsLoadingSuccess ||
            current is HomePostsLoading;
      },
      builder: (context, state) {
        if (state is HomePostsLoading) {
          return const CupertinoActivityIndicator(
            color: AppColors.white,
            animating: true,
          );
        }
        if (context.read<HomeBloc>().posts.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.viewPost,
                  arguments: PostScreensArgs(
                    post: context.read<HomeBloc>().posts[index],
                    personInfo: userInfo,
                  ),
                );
              },
              child: PostView(
                screensArgs: PostScreensArgs(
                  post: context.read<HomeBloc>().posts[index],
                  personInfo: userInfo,
                ),
                details: false,
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemCount: context.read<HomeBloc>().posts.length,
          );
        } else {
          return Center(
            child: Image(
              width: context.width / 2,
              height: context.height / 2,
              image: const AssetImage(AppImages.appLogo),
            ),
          );
        }
      },
    );
  }
}
