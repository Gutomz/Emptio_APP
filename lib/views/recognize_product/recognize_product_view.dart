import 'package:emptio/common/delegates/product_search/product_search.dart';
import 'package:emptio/common/widgets/market_indicator.widget.dart';
import 'package:emptio/common/widgets/product_tile.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/helpers/logger.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/views/recognize_product/store/recognize_product.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:camera/camera.dart';

class RecognizeProductView extends StatefulWidget {
  final MarketModel? connectedMarket;
  final String purchaseId;
  final String basePurchaseId;
  final bool isFavorite;

  const RecognizeProductView({
    Key? key,
    this.connectedMarket,
    this.purchaseId = "",
    this.basePurchaseId = "",
    this.isFavorite = false,
  }) : super(key: key);

  @override
  _RecognizeProductViewState createState() => _RecognizeProductViewState();
}

class _RecognizeProductViewState extends State<RecognizeProductView>
    with WidgetsBindingObserver {
  late RecognizeProductStore _store;

  CameraController? _controller;
  Future<void>? _initController;
  bool isCameraReady = false;

  @override
  void initState() {
    super.initState();
    _store = RecognizeProductStore(
      purchaseId: widget.purchaseId,
      basePurchaseId: widget.basePurchaseId,
      isFavorite: widget.isFavorite,
    );
    initCamera();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initController = _controller != null ? _controller!.initialize() : null;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      isCameraReady = true;
    });
  }

  void close(ProductSearchResponse? response) {
    Navigator.of(context).pop(response);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Reconhecer Produto"),
          actions: [
            if (_store.loaded)
              Tooltip(
                message: "Abrir Camera",
                child: IconButton(
                  onPressed: _store.reset,
                  icon: Icon(Icons.camera_alt_rounded),
                ),
              ),
            if (_store.hasReset && !_store.loaded)
              Tooltip(
                message: "Cancelar",
                child: IconButton(
                  onPressed: _store.restore,
                  icon: Icon(Icons.close_outlined),
                ),
              ),
          ],
          bottom: widget.connectedMarket == null
              ? null
              : PreferredSize(
                  preferredSize: Size.fromHeight(65),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 15),
                    child: MarketIndicator(market: widget.connectedMarket!),
                  ),
                ),
        ),
        body: FutureBuilder(
          future: _initController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Observer(
                builder: (context) => buildBody(context),
              );
            }

            return Center(
              child: CircularProgressIndicator(
                color: AppColors.darkOrange,
                strokeWidth: 2,
              ),
            );
          },
        ),
      );
    });
  }

  Widget buildBody(BuildContext context) {
    if (_store.loading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_store.imageBytes != null) buildLoadingPicture(context),
          CircularProgressIndicator(
            color: AppColors.darkOrange,
            strokeWidth: 2,
          ),
        ],
      );
    }

    if (_store.loaded) {
      return buildList(context);
    }

    return buildCamera(context);
  }

  Widget buildCamera(BuildContext context) {
    final camera = _controller!.value;
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    return Stack(
      children: [
        Transform.scale(
          scale: scale,
          child: Center(
            child: Stack(
              children: [
                CameraPreview(
                  _controller!,
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                ClipPath(
                  clipper: CameraClip(
                      widthRatio: 0.2, heightRatio: 0.25, radius: 25),
                  child: CameraPreview(_controller!),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: size.height * 0.15,
            width: size.width * 0.45,
            child: Center(
              child: Text(
                "Ajuste o produto no centro da área",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: size.height * 0.15,
            child: Center(
              child: FloatingActionButton(
                onPressed: _takePicture,
                child: Icon(
                  Icons.camera,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPicturePreview(
    BuildContext context, {
    required double height,
    required double width,
    required double radius,
  }) {
    return Hero(
      tag: "picture-preview",
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(radius),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: SizedBox(
            height: height,
            width: width,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.memory(_store.imageBytes!),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoadingPicture(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;

        final width = size.width * 0.55;
        final height = size.height * 0.35;
        const radius = 15.0;

        return SizedBox(
          width: size.width,
          child: Column(
            children: [
              buildPicturePreview(
                context,
                height: height,
                width: width,
                radius: radius,
              ),
              SizedBox(height: 25),
              SizedBox(
                width: size.width * 0.75,
                child: Text(
                  "Aguarde um instante, estamos analisando a imagem!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget buildList(BuildContext context) {
    if (_store.list.isEmpty) {
      final size = MediaQuery.of(context).size;

      final width = size.width * 0.55;
      final height = size.height * 0.35;
      const radius = 15.0;

      return Column(
        children: [
          AddProductTile(
            title: 'Adicionar novo produto',
            onTap: () {
              close(ProductSearchResponse(addNew: true));
            },
          ),
          Divider(height: 1, color: AppColors.lightGrey),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildPicturePreview(
                      context,
                      height: height,
                      width: width,
                      radius: radius,
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      width: size.width * 0.75,
                      child: Text(
                        'Não foi possível identificar nenhum produto nessa imagem.',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: _store.reset,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.red),
                      ),
                      child: Text("Tentar Novamente!"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      itemCount: _store.itemsCount + 1,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: AppColors.lightGrey,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return AddProductTile(
            title: 'Adicionar novo produto',
            onTap: () {
              close(ProductSearchResponse(addNew: true));
            },
          );
        }

        final realIndex = index - 1;

        final product = _store.list[realIndex];

        return ProductTile(
          product,
          onTap: () {
            close(ProductSearchResponse(product: product));
          },
          hidePrice: widget.connectedMarket == null,
        );
      },
    );
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
      enableAudio: false,
    );
    _initController = _controller!.initialize();

    if (!mounted) {
      return;
    }

    setState(() {
      isCameraReady = true;
    });
  }

  Future<void> _takePicture() async {
    if (_controller == null) {
      return;
    }

    try {
      _controller!.setFlashMode(FlashMode.off);
      final image = await _controller!.takePicture();
      final bytes = await image.readAsBytes();
      _store.recognizeProduct(bytes);
    } catch (error, stack) {
      Logger.error("RecognizeProductView", '_takePicture', error, stack);
    }
  }
}

class CameraClip extends CustomClipper<Path> {
  final double widthRatio;
  final double heightRatio;

  final double radius;

  final double yOffset;
  final double xOffset;

  CameraClip({
    required this.widthRatio,
    required this.heightRatio,
    required this.radius,
    this.yOffset = 0,
    this.xOffset = 0,
  });

  @override
  Path getClip(Size size) {
    final x1 = (size.width * widthRatio) - xOffset;
    final y1 = (size.height * heightRatio) - yOffset;

    final x2 = (size.width * (1 - widthRatio)) - xOffset;
    final y2 = (size.height * (1 - heightRatio)) - yOffset;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTRB(x1, y1, x2, y2), Radius.circular(radius)));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
