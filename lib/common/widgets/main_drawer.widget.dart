import 'package:emptio/common/widgets/user_avatar.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/stores/connectivity.store.dart';
import 'package:emptio/views/login/login.view.dart';
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
      if (_authStore.isLogged)
        return Container(
          child: ListTile(
            leading: Icon(
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
          ),
        );

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
        child: ListView(
          children: [
            Observer(builder: (_) {
              return ListTile(
                enabled: _authStore.isLogged,
                onTap: () {},
                title: Text("Notificações"),
                leading: Icon(
                  Icons.notifications_none_outlined,
                ),
                trailing: Icon(Icons.chevron_right_rounded),
              );
            }),
            Divider(color: AppColors.lightGrey, height: 1),
            Observer(builder: (_) {
              return ListTile(
                enabled: _authStore.isLogged,
                onTap: () {},
                title: Text("Seguidores"),
                leading: Icon(
                  Icons.group_rounded,
                ),
                trailing: Icon(Icons.chevron_right_rounded),
              );
            }),
            Divider(color: AppColors.lightGrey, height: 1),
            Observer(builder: (_) {
              return ListTile(
                enabled: _authStore.isLogged,
                onTap: () {},
                title: Text("Configurações"),
                leading: Icon(
                  Icons.settings,
                ),
                trailing: Icon(Icons.chevron_right_rounded),
              );
            }),
            Divider(color: AppColors.lightGrey, height: 1),
          ],
        ),
      ),
    );
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
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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

                  if (!_authStore.isLogged) {
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
          ),
        ),
      ),
    );
  }
}
