import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/custom_cached_image.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../domain/entities/cart_entity.dart';
import '../cubit/order_history_cubit.dart';
import '../cubit/order_history_state.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final storeId = context.read<AuthCubit>().currentAuthData?.storeId ?? '';

    return BlocProvider(
      create: (context) =>
          OrderHistoryCubit(getMyCartOrdersUseCase: getIt(), storeId: storeId)
            ..loadOrders(),
      child: const _OrderHistoryContent(),
    );
  }
}

class _OrderHistoryContent extends StatelessWidget {
  const _OrderHistoryContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A5250)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'الطلبات السابقة',
          style: TextStyle(
            color: Color(0xFF4A5250),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF4A5250)),
            onPressed: () {
              context.read<OrderHistoryCubit>().refreshOrders();
            },
          ),
        ],
      ),
      body: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (orders) {
              if (orders.isEmpty) {
                return _buildEmptyState();
              }
              return RefreshIndicator(
                onRefresh: () =>
                    context.read<OrderHistoryCubit>().refreshOrders(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return _OrderCard(order: orders[index]);
                  },
                ),
              );
            },
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrderHistoryCubit>().loadOrders();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'لا توجد طلبات سابقة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'سيظهر سجل طلباتك هنا',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final CartOrder order;

  const _OrderCard({required this.order});

  String _formatPrice(double price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(price.round());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFA),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E8E6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFEFF0EF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'طلب #${order.id.substring(0, 8)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A5250),
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (order.createdAt != null)
                      Text(
                        DateFormat(
                          'MMM dd, yyyy - HH:mm',
                        ).format(order.createdAt!),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8A9290),
                        ),
                      ),
                  ],
                ),
                _buildStatusBadge(order.status),
              ],
            ),
          ),
          // Order Products
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: order.products.length,
            separatorBuilder: (context, index) => const Divider(height: 16),
            itemBuilder: (context, index) {
              final product = order.products[index];
              return _ProductItem(product: product);
            },
          ),
          // Order Footer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE5E8E6))),
            ),
            child: Column(
              children: [
                _buildInfoRow('طريقة الدفع', order.paymentMethod),
                const SizedBox(height: 8),
                _buildInfoRow('المستلم', order.receiverNumber),
                const SizedBox(height: 8),
                _buildInfoRow('العنوان', order.address),
                if (order.note != null && order.note!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow('ملاحظة', order.note!),
                ],
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'المبلغ الإجمالي',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A5250),
                      ),
                    ),
                    Text(
                      '${_formatPrice(_calculateTotal())} د.ع',
                      style: const TextStyle(
                        fontSize: 20,
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
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = const Color(0xFFFFF4E5);
        textColor = const Color(0xFFFF9800);
        displayText = 'قيد الانتظار';
        break;
      case 'accepted':
      case 'approved':
        backgroundColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF4CAF50);
        displayText = 'مقبول';
        break;
      case 'rejected':
      case 'refused':
        backgroundColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFF44336);
        displayText = 'مرفوض';
        break;
      case 'delivered':
        backgroundColor = const Color(0xFFE3F2FD);
        textColor = const Color(0xFF2196F3);
        displayText = 'تم التوصيل';
        break;
      default:
        backgroundColor = const Color(0xFFEFF0EF);
        textColor = const Color(0xFF8A9290);
        displayText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Color(0xFF8A9290)),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A5250),
            ),
          ),
        ),
      ],
    );
  }

  double _calculateTotal() {
    return order.products.fold(0.0, (sum, product) => sum + product.totalPrice);
  }
}

class _ProductItem extends StatelessWidget {
  final CartOrderProduct product;

  const _ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Product Image
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE5E8E6)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: product.image != null
                ? CustomCachedImage(imageUrl: product.image!, fit: BoxFit.cover)
                : const Icon(
                    Icons.image_outlined,
                    size: 32,
                    color: Color(0xFF8A9290),
                  ),
          ),
        ),
        const SizedBox(width: 12),
        // Product Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A5250),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                product.categoryName,
                style: const TextStyle(fontSize: 12, color: Color(0xFF8A9290)),
              ),
              const SizedBox(height: 4),
              Text(
                'الكمية: ${product.quantity}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF8A9290)),
              ),
            ],
          ),
        ),
        // Price
        Text(
          '\${_formatPrice(product.totalPrice)} د.ع',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF005292),
          ),
        ),
      ],
    );
  }
}
