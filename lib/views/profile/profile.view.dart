import 'package:emptio/common/widgets/profile_avatar.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/profile.model.dart';
import 'package:emptio/models/profile_user.model.dart';
import 'package:emptio/views/edit_profile/edit_profile.view.dart';
import 'package:emptio/views/followers/followers.view.dart';
import 'package:emptio/views/profile/store/profile.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileView extends StatefulWidget {
  final String userId;

  ProfileView({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileStore _store = ProfileStore();

  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

  void _loadProfile() {
    _store.loadProfile(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          Observer(
            builder: (context) {
              if (_store.profile != null && !_store.profile!.isMe) {
                final profile = _store.profile!;
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    onPressed: () => profile.isFollowing
                        ? _onPressUnfollow(context)
                        : _onPressFollow(context),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppColors.orange),
                      side: MaterialStateProperty.all(
                          BorderSide(color: AppColors.orange)),
                      overlayColor: MaterialStateProperty.all<Color>(
                          AppColors.orange.withOpacity(0.1)),
                    ),
                    child: Text(profile.friendshipStatus),
                  ),
                );
              }

              return Container();
            },
          ),
        ],
      ),
      body: Observer(builder: (context) {
        if (_store.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (_store.hasError) {
          return Center(
            child: Text(_store.error),
          );
        }

        if (_store.profile == null) {
          return Center(
            child: Text("Ocorreu um erro!"),
          );
        }

        final profile = _store.profile!;

        return Padding(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildHeader(context, profile),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: _buildDetails(profile),
              ),
              if (profile.isMe)
                OutlinedButton(
                  onPressed: () => _onPressEditProfile(context, profile.user),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(AppColors.orange),
                    side: MaterialStateProperty.all(
                        BorderSide(color: AppColors.orange)),
                    overlayColor: MaterialStateProperty.all<Color>(
                        AppColors.orange.withOpacity(0.1)),
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(
                        double.infinity,
                        50,
                      ),
                    ),
                  ),
                  child: Text("Editar Perfil"),
                ),
            ],
          ),
        );
      }),
    );
  }

  SizedBox _buildDetails(ProfileModel profile) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile.user.name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.blue,
            ),
          ),
          Text(
            profile.user.email,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: AppColors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              profile.user.description,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildHeader(BuildContext context, ProfileModel profile) {
    return Row(
      children: [
        Hero(
          tag: profile.user.sId,
          child: Material(
            elevation: 5,
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.12),
            child: ProfileAvatar(
              image: profile.user.photo,
              radius: MediaQuery.of(context).size.width * 0.12,
              borderGap: 5,
              iconSize: 52,
              backgroundColor: AppColors.orange,
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildUserInfosColumn(
                value: profile.postsCount.toString(),
                title: "Publicações",
              ),
              _buildUserInfosColumn(
                onTap: () => _onTapFollowers(context, profile.user.name),
                value: profile.followersCount.toString(),
                title: "Seguidores",
              ),
              _buildUserInfosColumn(
                onTap: () => _onTapFollowing(context, profile.user.name),
                value: profile.followingCount.toString(),
                title: "Seguindo",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfosColumn({
    required String value,
    required String title,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.blue,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressEditProfile(
      BuildContext context, ProfileUserModel profileUser) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfileView(
          profileUser: profileUser,
        ),
      ),
    );

    _store.loadProfile(widget.userId);
  }

  void _onPressFollow(BuildContext context) {}

  void _onPressUnfollow(BuildContext context) {}

  void _onTapFollowers(BuildContext context, String userName) {
    _navigateToFollowersScreen(title: userName);
  }

  void _onTapFollowing(BuildContext context, String userName) {
    _navigateToFollowersScreen(title: userName, initialIndex: 1);
  }

  Future<T?> _navigateToFollowersScreen<T>(
      {required String title, int initialIndex = 0}) async {
    final data = await Navigator.of(context).push<T>(
      MaterialPageRoute(
        builder: (context) => FollowersView(
          userId: widget.userId,
          title: title,
          initialIndex: initialIndex,
        ),
      ),
    );

    _store.loadProfile(widget.userId);

    return data;
  }
}
