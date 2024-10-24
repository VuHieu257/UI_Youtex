import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:const Icon(Icons.arrow_back,color: Styles.nearPrimary,),
        title: Column(
          children: [
            Text('Quản lý đơn hàng',style: context.theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Styles.nearPrimary
            ),),
            Divider(indent: context.width*0.15,endIndent: context.width*0.15,),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm đơn hàng',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                  ,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const FilterModal();
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 4
                          )
                        ],
                        borderRadius: BorderRadius.circular(18),color: const Color(0xffF3F3F3)),
                    child:const Icon(Icons.filter_alt_outlined),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Replace with dynamic list length
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    color: Styles.nearBlue,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: context.width*0.25,
                                height: context.width*0.25,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(19)),
                                    image: DecorationImage(image: AssetImage(
                                      Asset.bgImageProduct, // Replace with actual image
                                    ),fit: BoxFit.cover,
                                    )
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    infoOrder(context,'Mã đơn hàng','356106AHB8'),
                                    infoOrder(context,'Người đặt','Nguyễn Văn A'),
                                    infoOrder(context,'Ngày tạo',' 16:10  10/10/2024'),
                                    infoOrder(context,'Tình trạng đơn hàng','Chờ vận chuyển'),
                                    infoOrder(context,'Phương thức thanh toán','TKNH/TTD'),
                                    infoOrder(context,'Tổng giá trị đơn hàng ','1.987.000đ',color:0xff113A71),

                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.local_shipping_outlined,  color: Styles.nearPrimary),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("Quản lý đơn hàng",style: context.theme.textTheme.titleSmall?.copyWith(
                                  color: Styles.nearPrimary
                              ),),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                decoration: BoxDecoration(
                                    color: const Color(0xffC14141),
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child:Text("Hủy",style: context.theme.textTheme.titleMedium?.copyWith(
                                    color: Styles.light,
                                    fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Padding infoOrder(BuildContext context,String textTitle,String textContent,{int? color}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
              textTitle,
              style:context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color:const Color(0xff4E4E4E).withOpacity(0.8)
              )
          ),
          const Spacer(),
          Text(
              textContent,
              style:context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight:color==null?FontWeight.bold:FontWeight.w500,
                  color:Color(color??0xff4E4E4E)
              )
          ),

        ],
      ),
    );

  }
}
class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  String? orderStatus = 'Chờ xác nhận';
  String? paymentMethod = 'COD';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFD2EAFE),
            Color(0xff326BB7),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Theo tình trạng đơn hàng',style: context.theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold
          ),),
          Container(
            margin: const EdgeInsets.only(bottom: 10,top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 4),
                      blurRadius: 6
                  )
                ]
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  title: Text('Chờ xác nhận',style: context.theme.textTheme.headlineSmall?.copyWith( ),),
                  value: 'Chờ xác nhận',
                  groupValue: orderStatus,
                  onChanged: (String? value) {
                    setState(() {
                      orderStatus = value;
                    });
                  },
                ),
                const Divider(height: 0,),
                RadioListTile<String>(
                  title:  Text('Chờ vận chuyển',style: context.theme.textTheme.headlineSmall?.copyWith( ),),
                  value: 'Chờ vận chuyển',
                  groupValue: orderStatus,
                  onChanged: (String? value) {
                    setState(() {
                      orderStatus = value;
                    });
                  },
                ),
                const Divider(height: 0,),
                RadioListTile<String>(
                  title:  Text('Đã giao',style: context.theme.textTheme.headlineSmall?.copyWith( ),),
                  value: 'Đã giao',
                  groupValue: orderStatus,
                  onChanged: (String? value) {
                    setState(() {
                      orderStatus = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Text('Theo phương thức thanh toán',style: context.theme.textTheme.headlineMedium?.copyWith( fontWeight: FontWeight.bold),),
          Container(
            margin: const EdgeInsets.only(bottom: 10,top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 4),
                      blurRadius: 6
                  )
                ]
            ),
            child: Column(
              children: [
                RadioListTile<String>(
                  title: const Text('COD'),
                  value: 'COD',
                  groupValue: paymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      paymentMethod = value;
                    });
                  },
                ),
                const Divider(height: 0,),
                RadioListTile<String>(
                  title: Text('Tài khoản ngân hàng/Thẻ tín dụng',style: context.theme.textTheme.headlineSmall?.copyWith( fontWeight: FontWeight.bold),),
                  value: 'Tài khoản ngân hàng/Thẻ tín dụng',
                  groupValue: paymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      paymentMethod = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff326BB7),
                    Color(0xFF3EB0FF),
                  ],
                ),
              ),
              child: Text('Lọc',style: context.theme.textTheme.headlineMedium?.copyWith( fontWeight: FontWeight.bold,color: Colors.white),),

            ),
          ),
        ],
      ),
    );
  }
}