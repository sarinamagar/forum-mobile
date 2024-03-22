import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/forum/presentation/widgets/forum_post_view.dart';
import 'package:forum/src/features/profile/presentation/viewmodels/profile_viewmodel.dart';

class ProfilePostScreen extends StatelessWidget {
  final User user;
  const ProfilePostScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Post> posts = [];
    return BlocProvider(
      create: (context) => sl<ProfileViewModel>()
        ..add(ProfileLoadPost(userID: user.userInfo.uid!)),
      child: BlocBuilder<ProfileViewModel, ProfileState>(
        builder: (context, state) {
          if (state is ProfilePostLoading) {
            return const CupertinoActivityIndicator(
              color: AppColors.white,
              animating: true,
            );
          }
          if (state is ProfilePostsLoadingSuccess) {
            posts = state.posts;
          }
          return SingleChildScrollView(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.viewPost,
                    arguments: PostScreensArgs(
                      post: posts[index],
                      personInfo: user,
                    ),
                  );
                },
                child: ForumPostView(
                  screensArgs: PostScreensArgs(
                    post: posts[index],
                    personInfo: user,
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: posts.length,
            ),
          );
        },
      ),
    );
  }
}
