class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // For Andriod
  static const String baseUrl = "http://10.0.2.2:5000/api";
  // For iOS
  // static const String baseUrl = "http://localhost:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  static const String resetPassword = "$baseUrl/auth/resetPassword";

  // ====================== User Routes ======================
  static const String fetchUserByID = "$baseUrl/user/id/";
  static const String updateStatus = "$baseUrl/user/status/";
  static const String updateUser = "$baseUrl/user/update/";

  // ====================== OTP Routes ======================
  static const String verifyAccount = "$baseUrl/verify/";
  static const String sendResetOtp = "$baseUrl/verify/generateToken/";

  // ====================== Post Routes ======================
  static const String loadPosts = "$baseUrl/post/posts";
  static const String getPost = "$baseUrl/post/";
  static const String forumPost = "$baseUrl/post/forum/";
  static const String userPost = "$baseUrl/post/user/";

  // ====================== Comment Routes ======================
  static const String getCommentById = "$baseUrl/comment/";
  static const String addComment = "$baseUrl/comment/new";
  static const String addReply = "$baseUrl/comment/reply";

  // ====================== Votes Routes ======================
  static const String upvote = "$baseUrl/post/upvote";
  static const String downvote = "$baseUrl/post/downvote";
  static const String upvoteComment = "$baseUrl/comment/upvote";
  static const String downvoteComment = "$baseUrl/comment/downvote";

  // ====================== Topic Routes ======================
  static const String loadTopics = "$baseUrl/topic/topics";

  // ====================== Forum Routes ======================
  static const String loadUserForums = "$baseUrl/forum/user/";
  static const String fetchForumById = "$baseUrl/forum/";
  static const String loadForums = "$baseUrl/forum/forums";
  static const String topicForums = "$baseUrl/forum/topic/";
  static const String createForum = "$baseUrl/forum/create";
  static const String join = "$baseUrl/forum/join";
}
