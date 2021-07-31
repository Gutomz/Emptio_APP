import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/configurations/store/configurations.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ConfigurationsView extends StatelessWidget {
  final ConfigurationsStore _store = ConfigurationsStore();

  ConfigurationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Observer(
        builder: (context) => ListView(
          children: [
            Observer(
              builder: (context) => _buildSwitchTile(
                title: "Modo offline",
                value: _store.offlineMode,
                onChanged: _store.triggerOfflineMode,
                tooltip:
                    "Utilize o modo offline para acessar os dados locais do dispositivo",
              ),
            ),
            if (_store.isLogged)
              Observer(
                builder: (context) => _buildSwitchTile(
                  title: "Receber notificações",
                  value: _store.canNotify,
                  onChanged: _store.triggerCanNotify,
                  tooltip: "Ative ou desative suas notificações.",
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
    String? tooltip,
  }) {
    return Tooltip(
      message: tooltip ?? "Aperte no botão para ativar e desativar essa opção.",
      child: Column(
        children: [
          SwitchListTile(
            value: value,
            onChanged: onChanged,
            title: Text(title),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          Divider(height: 1, color: AppColors.lightGrey),
        ],
      ),
    );
  }
}
