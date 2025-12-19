import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:store_web/config/store_app.dart';
import 'package:store_web/core/utils/functions/price.dart';
import 'package:store_web/utils/injector/injector.dart';

import '../../../../core/widgets/custom_cached_image.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, this.isBackButtonVisible = true});
  final bool isBackButtonVisible;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _receiverPhoneController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _receiverType = 'لنفسي'; // Default value

  @override
  void dispose() {
    _addressController.dispose();
    _noteController.dispose();
    _receiverPhoneController.dispose();
    super.dispose();
  }

  void _handleCheckout(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final address = _addressController.text.trim();
      final note = _noteController.text.trim();
      final receiverPhone = _receiverPhoneController.text.trim();
      final storeId = getIt<AuthCubit>().currentAuthData?.storeId ?? '';

      if (storeId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('خطأ: لم يتم العثور على معرف المتجر'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Submit cart
      await context.read<CartCubit>().submitCart(
        storeId: storeId,
        address: address,
        note: note.isEmpty ? 'طلب من التطبيق' : note,
        receiverNumber: receiverPhone,
        deliveryReceiverType: _receiverType,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء ملء جميع الحقول المطلوبة'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state.submitSuccess) {
          // Success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إرسال الطلب بنجاح! ✓'),
              backgroundColor: Colors.green,
            ),
          );

          // Clear the fields
          _addressController.clear();
          _noteController.clear();
          _receiverPhoneController.clear();

          // Navigate back or to home
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/');
          }
        } else if (state.errorMessage != null && !state.isSubmitting) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ: ${state.errorMessage}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) => Scaffold(
          body: Builder(
            builder: (context) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.items.isEmpty) {
                return _buildEmptyState(context);
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 350),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCartItems(context, state),
                    // _buildPromoCode(context),
                    _buildDeliveryAddress(context),
                  ],
                ),
              );
            },
          ),

          bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state.items.isEmpty) {
                return const SizedBox.shrink();
              }
              return _buildBottomSection(
                context,
                state,
                widget.isBackButtonVisible,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCartItems(BuildContext context, CartState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        children: state.items.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Product Image
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colorScheme.surfaceContainer,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomCachedImage(
                      imageUrl:
                          (item.product.baseUrl ?? "") +
                          (item.product.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4A5250),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.product.categoryName ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF8A9290),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<CartCubit>().removeFromCart(
                                item.product.id,
                              );
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFEFF0EF,
                                ).withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                size: 16,
                                color: Color(0xFF8A9290),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Quantity Controls
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<CartCubit>().decrementQuantity(
                                      item.product.id,
                                    );
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7F8F7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: Color(0xFF4A5250),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 32,
                                  child: Text(
                                    '${item.quantity}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4A5250),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.read<CartCubit>().incrementQuantity(
                                      item.product.id,
                                    );
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF005292),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Price
                          Text(
                            '${formatPrice(item.totalPrice)} د.ع',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF005292),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDeliveryAddress(BuildContext context) {
    return Form(
      key: _formKey,

      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'عنوان التوصيل',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5250),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFBFA),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E8E6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Color(0xFF005292),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      minLines: 1,

                      decoration: const InputDecoration(
                        hintText: 'أدخل عنوان التوصيل الكامل...',

                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'الرجاء إدخال عنوان التوصيل';
                        }
                        if (value.trim().length < 10) {
                          return 'العنوان قصير جداً';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // Receiver Type Dropdown
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFBFA),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E8E6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF005292),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _receiverType,
                      decoration: const InputDecoration(
                        hintText: 'اختر المستلم',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      items: const [
                        DropdownMenuItem(value: 'لنفسي', child: Text('لنفسي')),
                        DropdownMenuItem(
                          value: 'لشخص اخر',
                          child: Text('لصديق'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _receiverType = value ?? 'لنفسي';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFBFA),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E8E6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: PhosphorIcon(
                      textDirection: TextDirection.ltr,
                      PhosphorIcons.phone(PhosphorIconsStyle.duotone),
                      color: Color(0xFF005292),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _receiverPhoneController,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A5250),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'ادخل رقم هاتف المستلم...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8A9290),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'الرجاء إدخال رقم المستلم';
                        }
                        final phone = value.trim();
                        // Check if it's a valid number
                        if (int.tryParse(phone) == null) {
                          return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
                        }
                        // Check length (11 digits for Iraqi numbers)
                        if (phone.length != 11) {
                          return 'رقم الهاتف يجب أن يكون 11 رقم';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFBFA),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E8E6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.note_outlined,
                      color: Color(0xFF005292),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _noteController,
                      maxLines: 3,
                      minLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A5250),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'ملاحظات إضافية (اختياري)...',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF8A9290),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(
    BuildContext context,
    CartState state,
    bool isBackButtonVisible,
  ) {
    final cartCubit = context.read<CartCubit>();
    final subtotal = cartCubit.totalAmount;

    final total = subtotal;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F7),
        border: const Border(top: BorderSide(color: Color(0xFFE5E8E6))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            isBackButtonVisible ? 24 : 0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSummaryRow(
                'المجموع الفرعي (${cartCubit.itemCount} منتجات)',
                '${formatPrice(subtotal)} د.ع',
                false,
              ),
              const SizedBox(height: 12),
              _buildSummaryRow('رسوم التوصيل', 'مجاني', false),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: Color(0xFFE5E8E6), height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('الإجمالي', style: textTheme.titleLarge),
                  Text(
                    '${formatPrice(total)} د.ع',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF005292),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: state.isSubmitting
                    ? null
                    : () => _handleCheckout(context),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: state.isSubmitting
                        ? const Color(0xFF005292).withValues(alpha: 0.6)
                        : const Color(0xFF005292),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF005292).withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: state.isSubmitting
                      ? const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تأكيد الطلب',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    bool isBold, {
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isBold ? const Color(0xFF4A5250) : const Color(0xFF8A9290),
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDiscount
                ? const Color(0xFFC87A7A)
                : const Color(0xFF4A5250),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'سلة التسوق فارغة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'أضف منتجات لتظهر هنا',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => context.push('/orders'),
            icon: const Icon(Icons.history),
            label: const Text('عرض الطلبات السابقة'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),

          Spacer(),
        ],
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('مسح السلة'),
        content: const Text('هل تريد مسح جميع المنتجات من السلة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              context.read<CartCubit>().clearCart();
              Navigator.pop(dialogContext);
            },
            child: const Text('مسح', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
