import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/profile_avatar.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/post.model.dart';
import 'package:emptio/models/post_data.model.dart';
import 'package:emptio/views/feed/store/post_widget.store.dart';
import 'package:emptio/views/post_purchase_details/post_purchase_details.view.dart';
import 'package:emptio/views/profile/profile.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';
import 'package:mobx/mobx.dart';

class PostWidget extends StatefulWidget {
  final PostWidgetStore _store;
  final bool canDelete;
  final Function()? onDelete;

  PostWidget({
    Key? key,
    required PostModel post,
    this.onDelete,
    this.canDelete = false,
  })  : _store = PostWidgetStore(post),
        super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  void initState() {
    super.initState();

    reaction((_) => widget._store.shouldDelete, (bool shouldDelete) {
      if (shouldDelete && widget.onDelete != null) {
        widget.onDelete!();
      }
    });
  }

  @override
  void dispose() {
    widget._store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(25),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(context),
          buildBody(context),
          Divider(height: 1, color: AppColors.lightGrey),
          buildBottom(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => navigateToUserProfile(context),
              child: Observer(builder: (context) {
                return ProfileAvatar(
                  image: widget._store.post.user.photo,
                  radius: 16,
                  iconSize: 18,
                  backgroundColor: AppColors.orange,
                );
              }),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => navigateToUserProfile(context),
                        child: Observer(builder: (context) {
                          return Text(
                            widget._store.post.user.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          );
                        }),
                      ),
                      Observer(builder: (context) {
                        return Text(
                          publicationTime(widget._store.post.createdAt),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        );
                      }),
                    ],
                  ),
                  if (widget.canDelete && widget.onDelete != null)
                    IconButton(
                      onPressed: () => confirmDelete(context),
                      icon: Icon(
                        Icons.delete_forever,
                        color: AppColors.grey,
                      ),
                      splashRadius: 26,
                      iconSize: 22,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    if (widget._store.hasError) {
      return buildBodyError(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Observer(
          builder: (context) {
            switch (widget._store.type) {
              case PostDataTypes.purchase:
                return buildPostDataPurchase(context);

              case PostDataTypes.productMarket:
                return buildPostDataProductMarket(context);

              default:
                return buildBodyError(context);
            }
          },
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            widget._store.post.description,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBodyError(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Text(
        "Não foi possível carregar a publicação.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.grey,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget buildPostDataPurchase(BuildContext context) {
    return Observer(builder: (context) {
      final purchase = widget._store.post.data.purchase!;

      return InkWell(
        onTap: () => navigateToPurchaseDetails(context, purchase),
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      purchase.name,
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.double_arrow_rounded,
                    color: AppColors.grey,
                    size: 14,
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.grey,
                    size: 14,
                  ),
                  SizedBox(width: 5),
                  RichText(
                    text: TextSpan(
                      text: "${purchase.items.length}",
                      style: TextStyle(
                        color: AppColors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text:
                              " produto${purchase.items.length == 1 ? "" : "s"}",
                          style: TextStyle(
                            color: AppColors.orange,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget buildPostDataProductMarket(BuildContext context) {
    return Observer(builder: (context) {
      final productMarket = widget._store.post.data.productMarket!;

      return Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                children: [
                  ImageBuilder.fromString(
                    productMarket.market.image,
                    size: 45,
                    iconSize: 18,
                    borderRadius: 25,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    productMarket.market.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          buildProduct(context),
          SizedBox(height: 10),
        ],
      );
    });
  }

  Widget buildProduct(BuildContext context) {
    return Observer(
      builder: (context) {
        final productMarket = widget._store.post.data.productMarket!;
        final product = productMarket.product;
        final price = productMarket.price;
        final updatedAt = product.updatedAt;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              ImageBuilder.fromString(
                product.image,
                size: 55,
                iconSize: 22,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            product.getCombinedName(),
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              SubtitleItem(
                                icon: Icons.business_rounded,
                                text: product.brand,
                                iconSize: 10,
                                textSize: 10,
                              ),
                              SubtitleItem(
                                icon: Icons.straighten_rounded,
                                text: product.weight.toString(),
                                iconSize: 10,
                                textSize: 10,
                              ),
                              SubtitleItem(
                                icon: Icons.event,
                                text: updatedAt.formatDate(),
                                iconSize: 10,
                                textSize: 10,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "R\$",
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.lightGrey,
                              ),
                            ),
                            Text(
                              price.formatMoney(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildBottom(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Observer(
              builder: (context) => buildRateButton(
                context,
                text: widget._store.dislikes.toString(),
                icon: Icons.thumb_down_outlined,
                selectedIcon: Icons.thumb_down,
                selected: widget._store.isDislikeSelected,
                onTap: widget._store.toggleDislike,
              ),
            ),
          ),
          VerticalDivider(
            color: AppColors.lightGrey,
            width: 1,
          ),
          Expanded(
            child: Observer(
              builder: (context) => buildRateButton(
                context,
                text: widget._store.likes.toString(),
                icon: Icons.thumb_up_outlined,
                selectedIcon: Icons.thumb_up,
                selected: widget._store.isLikeSelected,
                onTap: widget._store.toggleLike,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRateButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required IconData selectedIcon,
    required Function() onTap,
    bool selected = false,
  }) {
    final foregroundColor = selected ? AppColors.blue : AppColors.grey;
    final fontWeight = selected ? FontWeight.w600 : FontWeight.w400;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 14,
                  fontWeight: fontWeight,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                selected ? selectedIcon : icon,
                color: foregroundColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String publicationTime(String createdAt) {
    final createdAtDate = createdAt.toDate();
    final now = DateTime.now();

    final difference = now.difference(createdAtDate);

    if (difference.inDays > 0) {
      return "Há ${difference.inDays} dia${difference.inDays == 1 ? "" : "s"}";
    } else if (difference.inHours > 0) {
      return "Há ${difference.inHours} hora${difference.inHours == 1 ? "" : "s"}";
    } else if (difference.inMinutes > 0) {
      return "Há ${difference.inMinutes} minuto${difference.inMinutes == 1 ? "" : "s"}";
    } else {
      return "Há ${difference.inSeconds} segundo${difference.inSeconds == 1 ? "" : "s"}";
    }
  }

  void navigateToUserProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileView(userId: widget._store.post.user.sId),
      ),
    );
  }

  Future<void> confirmDelete(BuildContext context) async {
    final response = await showDialog<bool>(
      context: context,
      builder: (context) => SimpleConfirmDialog(
        title: "Deletar Publicação?",
        content: "Tem certeza que deseja deletar esta publicação?",
        acceptText: "deletar",
        rejectText: "cancelar",
      ),
    );

    if (response == true && widget.onDelete != null) {
      await widget._store.delete(widget._store.post.sId);
      widget.onDelete!();
    }
  }

  void navigateToPurchaseDetails(
      BuildContext context, BasePurchaseModel purchase) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostPurchaseDetailsView(purchase: purchase),
      ),
    );
  }
}
