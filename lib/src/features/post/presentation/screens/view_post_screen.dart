import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forum/src/config/app_routes/app_route.dart';
import 'package:forum/src/config/container_injector.dart';
import 'package:forum/src/config/screen_args.dart';
import 'package:forum/src/core/app.dart';
import 'package:forum/src/core/constants/app_assets.dart';
import 'package:forum/src/core/constants/app_colors.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/constants/media_query_values.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/functions/build_toast.dart';
import 'package:forum/src/core/widgets/posts/post_view.dart';
import 'package:forum/src/features/home/presentation/widgets/home/home_app_bar_actions.dart';
import 'package:forum/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:forum/src/features/post/presentation/widgets/button/comment/comment_navigate_field.dart';
import 'package:forum/src/features/post/presentation/widgets/comment/comment_card.dart';

class ViewPostScreen extends StatefulWidget {
  final PostScreensArgs postScreensArgs;

  ViewPostScreen({super.key, required this.postScreensArgs});

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= tabletBreakpoint;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.jupiter),
        actions: [
          HomeActions(
            user: widget.postScreensArgs.personInfo,
            filterIcon: SvgPicture.asset(
              AppIcons.poll,
              height: isTablet ? 30 : 20.0,
              width: 20.0,
              colorFilter: const ColorFilter.mode(
                AppColors.jupiter,
                BlendMode.srcIn,
              ),
            ),
            dropIcon: Icon(
              Icons.more_vert_sharp,
              size: isTablet ? 36 : 25,
              color: AppColors.gray,
            ),
          ),
        ],
      ),
      endDrawer: Drawer(),
      body: Stack(
        children: [
          BlocProvider(
            create: (context) => sl<PostBloc>()
              ..add(GetPost(postId: widget.postScreensArgs.post.id!)),
            child: BlocConsumer<PostBloc, PostState>(
              buildWhen: (previous, current) {
                return current is PostLoadingSuccess || current is PostLoading;
              },
              listener: (context, state) {
                if (state is PostLoadingFailed) {
                  buildToast(toastType: ToastType.error, msg: state.message);
                }
              },
              builder: (context, state) {
                if (state is PostLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      color: AppColors.white,
                      animating: true,
                    ),
                  );
                }
                if (state is PostCommentedSuccess ||
                    state is CommentRepliedSuccess) {
                  setState(() {
                    sl<PostBloc>()
                        .add(GetPost(postId: widget.postScreensArgs.post.id!));
                  });
                }
                if (state is PostLoadingSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: PostView(
                            screensArgs: PostScreensArgs(
                              post: state.post,
                              personInfo: widget.postScreensArgs.personInfo,
                            ),
                            details: true,
                          ),
                        ),
                        if (state.post.comments != null)
                          ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              List<Comment> reversedComments =
                                  List.from(state.post.comments!)
                                      .reversed
                                      .toList()
                                      .cast<Comment>();
                              Comment comment = reversedComments[index];
                              return CommentCard(
                                comment: comment,
                                postScreensArgs: widget.postScreensArgs,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: state.post.comments!.length,
                          ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 25),
                        )
                      ],
                    ),
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
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomCenter,
            child: CommentNavigateField(
              onPressed: () async {
                await Navigator.of(context).pushNamed(
                  AppRoutes.addComment,
                  arguments: widget.postScreensArgs,
                );
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushNamed(
                  AppRoutes.viewPost,
                  arguments: PostScreensArgs(
                    post: widget.postScreensArgs.post,
                    personInfo: widget.postScreensArgs.personInfo,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
