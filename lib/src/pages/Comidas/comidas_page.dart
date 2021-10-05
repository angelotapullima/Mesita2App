import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/models/categorias_model.dart';
import 'package:mesita_aplication_2/src/models/food_model.dart';
import 'package:mesita_aplication_2/src/pages/Comidas/modals_food.dart';

class ComidasPage extends StatefulWidget {
  const ComidasPage({Key key}) : super(key: key);

  @override
  _ComidasPageState createState() => _ComidasPageState();
}

class _ComidasPageState extends State<ComidasPage> {
  final _controller = CategoryController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0XFFE5E5E5),
        leading: InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            width: ScreenUtil().setWidth(24),
            height: ScreenUtil().setHeight(17),
            child: SvgPicture.asset('assets/food_svg/menu_icon.svg'),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              addModal(context);
            },
            child: Container(
              width: ScreenUtil().setWidth(20),
              height: ScreenUtil().setHeight(20),
              child: SvgPicture.asset('assets/food_svg/add_food.svg'),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
          Container(
            width: ScreenUtil().setWidth(32),
            height: ScreenUtil().setHeight(32),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
        ],
        elevation: 0,
        title: Text(
          'Comidas',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(40),
            child: ListView.builder(
              itemCount: categoriasList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return AnimatedBuilder(
                    animation: _controller,
                    builder: (_, s) {
                      return InkWell(
                        onTap: () {
                          _controller.changeIdSelect(categoriasList[index].id);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(28),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: (categoriasList[index].id == _controller.idSelec) ? Color(0XFFFF0036) : Color(0XFFE5E5E5),
                              boxShadow: [
                                BoxShadow(
                                  color: (categoriasList[index].id == _controller.idSelec) ? Color.fromRGBO(255, 0, 54, 0.5) : Colors.transparent,
                                )
                              ]),
                          child: Center(
                              child: Text(
                            categoriasList[index].categoria,
                            style: TextStyle(
                              color: (categoriasList[index].id == _controller.idSelec) ? Colors.white : Color(0xFF585858),
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.16,
                            ),
                          )),
                        ),
                      );
                    });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: listSopas.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return itemFood(listSopas[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget itemFood(FoodModel food) {
    String disponible = 'Disponible';
    Color color = Colors.green;
    if (food.disponible == '0') {
      disponible = 'Agotado';
      color = Colors.red;
    }
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: ScreenUtil().setHeight(100),
            width: ScreenUtil().setWidth(100),
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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: ScreenUtil().setHeight(80),
                      width: ScreenUtil().setWidth(80),
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
                      child: SvgPicture.asset('assets/food_svg/food.svg')),
                ),
              ],
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(12),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${food.food}',
                  style: TextStyle(
                    color: Color(0XFF585858),
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.16,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                Text(
                  '$disponible',
                  style: TextStyle(
                    color: color,
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.16,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                Text(
                  '${food.precio}',
                  style: TextStyle(
                    color: Color(0XFF3A3A3A),
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.16,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Icon(
              Icons.arrow_forward_ios,
              size: ScreenUtil().setHeight(12),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryController extends ChangeNotifier {
  String idSelec = '1';
  void changeIdSelect(String id) {
    idSelec = id;
    notifyListeners();
  }
}
