import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class DetailProduct extends StatefulWidget {
  final ProductoLineaModel producto;

  const DetailProduct({Key key, @required this.producto}) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: ScreenUtil().setHeight(300),
            width: double.infinity,
            child: SvgPicture.asset(
              'assets/svg/back_detail_product.svg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(85),
            right: ScreenUtil().setWidth(10),
            child: SafeArea(
              child: Container(
                height: ScreenUtil().setHeight(45),
                width: ScreenUtil().setWidth(45),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/food_svg/delete_food.svg',
                ),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(25),
            right: ScreenUtil().setWidth(10),
            child: SafeArea(
              child: Container(
                height: ScreenUtil().setHeight(45),
                width: ScreenUtil().setWidth(45),
                child: SvgPicture.asset(
                  'assets/food_svg/edit_food.svg',
                ),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(25),
            left: ScreenUtil().setWidth(10),
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: ScreenUtil().setHeight(45),
                  width: ScreenUtil().setWidth(45),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/food_svg/backButton.svg',
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(200),
            ),
            /* padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(130),
            ), */
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(130),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.producto.productoNombre}',
                        style: TextStyle(
                          color: Color(0XFF585858),
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'S/. ${widget.producto.productoPrecio}',
                        style: TextStyle(
                          color: Color(0XFF585858),
                          fontSize: ScreenUtil().setSp(30),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(32),
                    ),
                    Text(
                      'Descripción',
                      style: TextStyle(
                        color: Color(0XFF585858),
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Text(
                      '${widget.producto.productoDescripcion} ',
                      style: TextStyle(
                        color: Color(0XFF585858),
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(100),
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0XFFEEEEEE),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(88, 88, 88, 0.3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.producto.idProducto,
                    child: Container(
                      height: ScreenUtil().setHeight(200),
                      width: ScreenUtil().setWidth(200),
                      decoration: BoxDecoration(
                        color: Color(0XFFEEEEEE),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(-1, -1),
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: SvgPicture.asset('assets/food_svg/food.svg'),
                        ),
                        errorWidget: (context, url, error) => Container(
                          child: Container(
                            child: SvgPicture.asset(
                              'assets/food_svg/food.svg',
                            ),
                          ),
                        ),
                        imageUrl: '$apiBaseURL/${widget.producto.productoFoto}',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(24),
                vertical: ScreenUtil().setWidth(12),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Disponible',
                    style: TextStyle(
                      color: Color(0XFF585858),
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Switch.adaptive(
                    value: true,
                    onChanged: (valor) {},
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
