import 'package:emptio/common/widgets/user_avatar.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/stores/connectivity.store.dart';
import 'package:emptio/views/configurations/configurations.view.dart';
import 'package:emptio/views/login/login.view.dart';
import 'package:emptio/views/notifications/notifications.view.dart';
import 'package:emptio/views/products_list/products_list.view.dart';
import 'package:emptio/views/profile/profile.view.dart';
import 'package:emptio/views/search_profile/profile_search.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(100)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: Column(
            children: [
              MainDrawerHeader(),
              MainDrawerActionList(),
              MainDrawerBottom()
            ],
          ),
        ),
      ),
    );
  }
}

class MainDrawerBottom extends StatelessWidget {
  MainDrawerBottom({
    Key? key,
  }) : super(key: key);

  final AuthStore _authStore = GetIt.I<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_authStore.isLogged) {
        return ListTile(
          leading: _authStore.loading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                    strokeWidth: 1.5,
                  ),
                )
              : Icon(
                  Icons.logout_rounded,
                  color: AppColors.red,
                ),
          title: Text(
            "Desconectar",
            style: TextStyle(
              color: AppColors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: _authStore.logout,
        );
      }

      return Container();
    });
  }
}

class MainDrawerActionList extends StatelessWidget {
  MainDrawerActionList({
    Key? key,
  }) : super(key: key);

  final AuthStore _authStore = GetIt.I<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Observer(builder: (context) {
          return ListView(
            children: [
              if (_authStore.isLogged)
                _buildTile(
                  onTap: () => _navigateToNotificationsView(context),
                  title: "Notificações",
                  icon: Icons.notifications_none_outlined,
                ),
              if (_authStore.isLogged)
                _buildTile(
                  onTap: () => _navigateToProfileSearchView(context),
                  title: "Usuários",
                  icon: Icons.group_add_outlined,
                ),
              if (!_authStore.isLogged)
                _buildTile(
                  onTap: () {/* TODO - list markets */},
                  title: "Mercados",
                  icon: Icons.store_outlined,
                ),
              if (!_authStore.isLogged)
                _buildTile(
                  onTap: () => _navigateToProductsListView(context),
                  title: "Produtos",
                  icon: Icons.fastfood_outlined,
                ),
              _buildTile(
                onTap: () => _navigateToConfigurationsView(context),
                title: "Configurações",
                icon: Icons.settings,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required Function() onTap,
    required IconData icon,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(title),
          leading: Icon(icon),
          trailing: Icon(Icons.chevron_right_rounded),
        ),
        Divider(color: AppColors.lightGrey, height: 1),
      ],
    );
  }

  void _navigateToNotificationsView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NotificationsView(),
    ));
  }

  void _navigateToProfileSearchView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProfileSearchView(),
    ));
  }

  void _navigateToConfigurationsView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ConfigurationsView(),
    ));
  }

  void _navigateToProductsListView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductsListView(),
    ));
  }
}

class MainDrawerHeader extends StatelessWidget {
  MainDrawerHeader({
    Key? key,
  }) : super(key: key);

  final AuthStore _authStore = GetIt.I<AuthStore>();
  final ConnectivityStore _connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.orange,
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Observer(builder: (context) {
            return InkWell(
              onTap:
                  _authStore.isLogged ? () => _onTapGoToProfile(context) : null,
              child: Column(
                children: [
                  UserAvatar(
                    radius: 40,
                    borderGap: 5,
                    iconSize: 50,
                    backgroundColor: AppColors.white,
                    iconColor: AppColors.black,
                  ),
                  SizedBox(height: 10),
                  Observer(builder: (_) {
                    if (!_connectivityStore.isConnected) {
                      return Text(
                        "Sem conexão com a internet!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      );
                    }

                    if (!_authStore.offlineLogged) {
                      return TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_ctx) => LoginView(),
                            ),
                          );
                        },
                        child: Text(
                          "Clique aqui para fazer o login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return Text(
                      _authStore.user!.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void _onTapGoToProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileView(
          userId: _authStore.user!.sId,
        ),
      ),
    );
  }
}
