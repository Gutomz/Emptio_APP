import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/input_price_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';

class PurchaseDetailsEndDrawer extends StatelessWidget {
  const PurchaseDetailsEndDrawer({
    Key? key,
    required PurchaseDetailsStore store,
  })  : _store = store,
        super(key: key);

  // ignore: unused_field
  final PurchaseDetailsStore _store;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(100)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: Column(
            children: [
              _buildHeader(context),
              _buildDetails(context),
              _buildBottom(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Material(
      color: AppColors.orange,
      child: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Observer(
            builder: (context) {
              return InkWell(
                onTap: _store.isMarketConnected
                    ? () => _navigateToMarketDetails(context)
                    : null,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Observer(builder: (_) {
                    final market = _store.purchase.market;

                    return Column(
                      children: [
                        ImageBuilder.fromString(
                          market?.image,
                          icon: Icons.remove_shopping_cart_outlined,
                          borderWidth: 3,
                          foregroundColor: AppColors.grey,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          _store.isMarketConnected
                              ? market!.name
                              : "Nenhum mercado conectado",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Flexible(
      child: Material(
        color: AppColors.blue,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              Observer(
                builder: (context) {
                  return _buildDetailsTile(
                    title: 'Produtos pendentes',
                    subtitle:
                        "${_store.items.length} produto${_store.items.isEmpty || _store.items.length > 1 ? 's' : ''}",
                    tooltip: 'Quantidade de produtos pendentes',
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return _buildDetailsTile(
                    title: 'Produtos concluídos',
                    subtitle:
                        "${_store.checkedItems.length} produto${_store.checkedItems.isEmpty || _store.checkedItems.length > 1 ? 's' : ''}",
                    tooltip: 'Quantidade de produtos concluídos',
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return _buildDetailsTile(
                    title: 'Limite de preço',
                    subtitle: _store.purchase.limit > 0
                        ? _store.purchase.limit.formatMoney(symbol: "R\$")
                        : 'Nenhum limite aplicado',
                    tooltip: 'Limite de custo final da compra',
                    trailing: _store.isClosed
                        ? null
                        : IconButton(
                            onPressed: () => _changeLimitInput(context),
                            icon: Icon(
                              Icons.edit_rounded,
                              color: Colors.white,
                            ),
                          ),
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return _buildDetailsTile(
                    title: 'Preço estimado',
                    subtitle: _store.purchase.estimatedCost
                        .formatMoney(symbol: "R\$"),
                    tooltip:
                        'Soma de preços da lista de Pendentes + Concluídos',
                    subtitleColor: _store.purchase.limit > 0 &&
                            _store.purchase.estimatedCost >
                                _store.purchase.limit
                        ? AppColors.red
                        : null,
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return _buildDetailsTile(
                    title: 'Preço calculado',
                    subtitle: _store.purchase.cost.formatMoney(symbol: "R\$"),
                    tooltip: 'Preço final da compra.',
                    subtitleColor: _store.purchase.limit > 0 &&
                            _store.purchase.cost > _store.purchase.limit
                        ? AppColors.red
                        : null,
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return _buildDetailsTile(
                    title: 'Criado em',
                    subtitle: _store.purchase.createdAt.formatDate(),
                    tooltip: 'Data da criação.',
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return _buildDetailsTile(
                    title: 'Atualizado em',
                    subtitle: _store.purchase.updatedAt.formatDate(),
                    tooltip: 'Data da última modificação.',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsTile({
    required String title,
    required String subtitle,
    required String tooltip,
    Color? subtitleColor,
    Widget? trailing,
  }) {
    return Tooltip(
      message: tooltip,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: subtitleColor ?? AppColors.orange,
          ),
        ),
        trailing: trailing,
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Observer(builder: (context) {
      if (!_store.isClosed) {
        return ListTile(
          tileColor: AppColors.blue,
          trailing: _store.loading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                    strokeWidth: 1.5,
                  ),
                )
              : Icon(
                  Icons.check_rounded,
                  color: AppColors.green,
                ),
          horizontalTitleGap: 36,
          title: Text(
            "Concluir compra",
            textAlign: TextAlign.end,
            style: TextStyle(
              color: AppColors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () => _onTapClose(context),
        );
      }

      return Container();
    });
  }

  Future<void> _onTapClose(BuildContext context) async {
    if (!_store.canClose) {
      return _showCantCompleteError(context);
    }

    final accepted = await _confirmClosePurchase(context);

    if (accepted != null && accepted) {
      await _store.complete();
      Navigator.of(context).pop();
    }
  }

  Future<void> _changeLimitInput(BuildContext context) async {
    final limit = await showDialog<double>(
      context: context,
      builder: (context) {
        return InputPriceConfirmDialog(
          title: 'Alterar preço limite',
          initialPrice: _store.purchase.limit,
        );
      },
    );

    if (limit != null && limit != _store.purchase.limit) {
      _store.updateLimit(limit);
    }
  }

  Future<bool?> _confirmClosePurchase(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return SimpleConfirmDialog(
            title: "Concluir compra?",
            content: "Tem certeza que deseja concluir essa compra?",
            acceptText: "sim",
            rejectText: "cancelar",
          );
        });
  }

  void _showCantCompleteError(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text('Alerta!', style: TextStyle(fontWeight: FontWeight.w600)),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('ok'),
              )
            ],
            content: SizedBox(
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Não é possível concluir essa compra, revise as seguintes condições:",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "• Ter pelo menos 1 produto na lista.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _store.conditionProductsCount
                          ? AppColors.green
                          : AppColors.red,
                      decoration: _store.conditionProductsCount
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "• Não ter produtos pendentes.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _store.conditionItemsEmpty
                          ? AppColors.green
                          : AppColors.red,
                      decoration: _store.conditionItemsEmpty
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _navigateToMarketDetails(BuildContext context) {
    // TODO - Navigate to market details
  }
}
