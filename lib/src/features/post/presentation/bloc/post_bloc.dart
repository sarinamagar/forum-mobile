import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forum/src/core/constants/app_enums.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_votes/add_vote_request_dto.dart';
import 'package:forum/src/features/post/domain/usecases/add_comment_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/add_post_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/add_reply_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/downvote_comment_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/downvote_post_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/get_comment_by_id_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/get_post_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/upvote_comment_usecase.dart';
import 'package:forum/src/features/post/domain/usecases/upvote_post_usecase.dart';
import 'package:image_picker/image_picker.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostUsecase getPostUsecase;
  final AddPostUsecase addPostUsecase;
  final GetCommentByIdUsecase getCommentByIdUsecase;
  final AddCommentUseCase addCommentUseCase;
  final AddReplyUsecase addReplyUseCase;
  final UpvotePostUsecase upvotePostUsecase;
  final DownvotePostUsecase downvotePostUsecase;
  final UpvoteCommentUsecase upvoteCommentUsecase;
  final DownvoteCommentUsecase downvoteCommentUsecase;
  PostBloc({
    required this.getPostUsecase,
    required this.getCommentByIdUsecase,
    required this.addPostUsecase,
    required this.addCommentUseCase,
    required this.addReplyUseCase,
    required this.upvotePostUsecase,
    required this.downvotePostUsecase,
    required this.upvoteCommentUsecase,
    required this.downvoteCommentUsecase,
  }) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is UploadPost) {
        await _uploadPost(event, emit);
      }
      if (event is GetPost) {
        await _getPost(event, emit);
      }
      if (event is GetCommentById) {
        await _getCommentByID(event, emit);
      }
      if (event is AddComment) {
        await _addcomment(event, emit);
      }
      if (event is AddReply) {
        await _addReply(event, emit);
      }
      if (event is UpvotePost) {
        await _upvotePost(event, emit);
      }
      if (event is DownvotePost) {
        await _downvotePost(event, emit);
      }
      if (event is UpvoteComment) {
        await _upvoteComment(event, emit);
      }
      if (event is DownvoteComment) {
        await _downvoteComment(event, emit);
      }
    });
  }

  Future<void> _uploadPost(UploadPost event, Emitter<PostState> emit) async {
    emit(const PostUploading());
    final result = await addPostUsecase(event.dto);
    result.fold(
      (failure) => emit(PostUploadingFailed(failure.message)),
      (success) => emit(PostUploadingSuccess(post: success)),
    );
  }

  Future<void> _getPost(GetPost event, Emitter<PostState> emit) async {
    emit(const PostLoading());
    final result = await getPostUsecase(event.postId);
    result.fold(
      (failure) => emit(PostLoadingFailed(failure.message)),
      (success) => emit(PostLoadingSuccess(post: success)),
    );
  }

  Future<void> _getCommentByID(
      GetCommentById event, Emitter<PostState> emit) async {
    emit(const CommentLoading());
    final result = await getCommentByIdUsecase(event.commentID);
    result.fold(
      (failure) => emit(CommentLoadingFailed(failure.message)),
      (success) => emit(CommentLoadingSuccess(comment: success)),
    );
  }

  Future<void> _addcomment(AddComment event, Emitter<PostState> emit) async {
    emit(const PostAddingComment());
    final result = await addCommentUseCase(event.dto);
    result.fold(
      (failure) => emit(PostCommentedFailed(failure.message)),
      (success) => emit(PostCommentedSuccess(success)),
    );
  }

  Future<void> _addReply(AddReply event, Emitter<PostState> emit) async {
    emit(const CommentAddingReply());

    final result = await addReplyUseCase(event.dto);
    result.fold(
      (failure) => emit(CommentRepliedFailed(failure.message)),
      (success) => emit(CommentRepliedSuccess(success)),
    );
  }

  Future<void> _upvotePost(UpvotePost event, Emitter<PostState> emit) async {
    emit(UpvotingPost(event.dto.postID));
    final result = await upvotePostUsecase(event.dto);
    result.fold(
      (l) => emit(UpvotePostFailed(l.message)),
      (r) => emit(UpvotePostSuccess(hasVoted: r)),
    );
  }

  Future<void> _downvotePost(
      DownvotePost event, Emitter<PostState> emit) async {
    emit(DownvotingPost(event.dto.postID));
    final result = await downvotePostUsecase(event.dto);
    result.fold(
      (l) => emit(DownvotePostFailed(l.message)),
      (r) => emit(DownvotePostSuccess()),
    );
  }

  Future<void> _upvoteComment(
      UpvoteComment event, Emitter<PostState> emit) async {
    emit(UpvotingComment(event.dto.commentID));
    final result = await upvoteCommentUsecase(event.dto);
    result.fold(
      (l) => emit(UpvoteCommentFailed(l.message)),
      (r) => emit(UpvoteCommentSuccess(hasVoted: r)),
    );
  }

  Future<void> _downvoteComment(
      DownvoteComment event, Emitter<PostState> emit) async {
    emit(DownvotingComment(event.dto.commentID));
    final result = await downvoteCommentUsecase(event.dto);
    result.fold(
      (l) => emit(DownvoteCommentFailed(l.message)),
      (r) => emit(DownvoteCommentSuccess()),
    );
  }
}
