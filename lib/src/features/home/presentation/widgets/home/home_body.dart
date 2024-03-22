import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:forum/src/features/home/presentation/widgets/post/post_builder.dart';
import 'package:forum/src/features/post/presentation/bloc/post_bloc.dart';

class HomeBody extends StatelessWidget {
  final User user;
  const HomeBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostUploadingSuccess) {
          context.read<HomeBloc>().add(HomeLoadPosts());
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(HomeLoadPosts());
          },
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              PostBuilder(
                userInfo: user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
