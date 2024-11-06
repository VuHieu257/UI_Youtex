import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/bloc_seller/seller_register_bankAccount_bloc/seller_register_bank_account_bloc_bloc.dart';

class RegisterMallinforbankingScreen extends StatefulWidget {
  const RegisterMallinforbankingScreen({super.key});

  @override
  State<RegisterMallinforbankingScreen> createState() =>
      _RegisterMallinforbankingScreenState();
}

class _RegisterMallinforbankingScreenState
    extends State<RegisterMallinforbankingScreen> {
  final _bankController = TextEditingController();
  final _branchController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  bool _isDefault = false;
  String? selectedBank;
  bool isEditable = true;

  @override
  void dispose() {
    _bankController.dispose();
    _branchController.dispose();
    _accountNumberController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellerRegisterBankAccountBloc(
        restfulApiProvider: RestfulApiProviderImpl(),
      )..add(LoadSellerRegisterBankAccountInfo()),
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: cusAppBarCircle(context, title: "Thông Tin Ngân Hàng"),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<SellerRegisterBankAccountBloc,
                      SellerRegisterBankAccountBlocState>(
                    builder: (context, state) {
                      if (state is SellerRegisterBankAccountLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SellerRegisterBankAccountLoaded) {
                        // Đọc dữ liệu từ cards array
                        final bankCard = state.bankAccountInfo.cards.isNotEmpty
                            ? state.bankAccountInfo.cards.first
                            : null;

                        // Cập nhật controllers và trạng thái chỉnh sửa nếu có dữ liệu
                        if (bankCard != null) {
                          selectedBank = bankCard.bank;
                          _accountNumberController.text = bankCard.number;
                          _isDefault = bankCard.isDefault == 1;
                          isEditable = false;
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              "Tên Ngân hàng",
                              style: context.theme.textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide.none),
                                  filled: true,
                                  fillColor: Styles.colorF9F9F9,
                                ),
                                dropdownColor: Styles.colorF9F9F9,
                                value: selectedBank ?? 'Sacombank',
                                isExpanded: true,
                                items:
                                ['Vietcombank', 'Vietinbank', 'Sacombank']
                                    .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ))
                                    .toList(),
                                onChanged: isEditable
                                    ? (value) {
                                  setState(() {
                                    selectedBank = value;
                                  });
                                }
                                    : null,
                                icon: const Icon(Icons.arrow_drop_down),
                              ),
                            ),
                            CustomTextFieldNoIcon(
                              controller: _branchController,
                              label: "Chi nhánh",
                              hintText: "Tân Phú",
                              enabled: isEditable,
                            ),
                            CustomTextFieldNoIcon(
                              controller: _accountNumberController,
                              label: "Số Tài khoản ngân hàng",
                              hintText: bankCard?.number ?? "Nhập số tài khoản",
                              enabled: isEditable,
                            ),
                            CustomTextFieldNoIcon(
                              controller: _cardHolderController,
                              label: "Tên Chủ tài khoản",
                              hintText: "Nhập tên chủ tài khoản",
                              enabled: isEditable,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _isDefault,
                                  onChanged: isEditable
                                      ? (value) {
                                    setState(() {
                                      _isDefault = value ?? false;
                                    });
                                  }
                                      : null,
                                ),
                                Text(
                                  "Đặt làm tài khoản mặc định",
                                  style: context.theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            if (isEditable) const SizedBox(height: 30),
                            if (isEditable)
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF218FF2),
                                            Color(0xFF13538C),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<
                                              SellerRegisterBankAccountBloc>()
                                              .add(
                                            SellerRegisterBankAccountButtonPressed(
                                              bankName: selectedBank ??
                                                  'Sacombank',
                                              branch:
                                              _branchController.text,
                                              accountNumber:
                                              _accountNumberController
                                                  .text,
                                              cardHolder:
                                              _cardHolderController
                                                  .text,
                                              isDefault: _isDefault,
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Text(
                                            'Lưu thay đổi',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        );
                      } else if (state is SellerRegisterBankAccountFailure) {
                        return Center(child: Text('Lỗi: ${state.error}'));
                      }
                      return const Center(child: Text('Không có dữ liệu'));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFieldNoIcon extends StatelessWidget {
  final String label;
  final String hintText;
  final int? line;
  final TextEditingController controller;
  final bool enabled;

  const CustomTextFieldNoIcon({
    super.key,
    required this.hintText,
    required this.label,
    this.line,
    required this.controller,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              maxLines: line ?? 1,
              enabled: enabled,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                hintText: hintText,
                filled: true,
                fillColor: Styles.colorF9F9F9,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
