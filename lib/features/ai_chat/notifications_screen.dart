import 'package:flutter/material.dart';
import 'package:fintrack/core/theme/app_colors.dart';
import 'package:fintrack/core/theme/app_text_styles.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      NotificationItem(
        icon: Icons.account_balance_wallet_outlined,
        title: 'New Transaction',
        time: 'Today | 8:21 AM',
        description: 'You received a payment of \$50',
        isUnread: true,
      ),
      NotificationItem(
        icon: Icons.calendar_today_outlined,
        title: 'Bill Reminder',
        time: 'Today | 10:42 AM',
        description: 'Don\'t forget to pay your electricity bill by the end of the week',
        isUnread: true,
      ),
      NotificationItem(
        icon: Icons.bar_chart_outlined,
        title: 'Budget Alert',
        time: '1 day ago | 11:42 PM',
        description: 'You\'ve exceeded 90% of your monthly budget for "Groceries"',
        isUnread: true,
      ),
      NotificationItem(
        icon: Icons.receipt_long_outlined,
        title: 'Expense Alert',
        time: '2 days ago | 11:25 PM',
        description: 'Your recent grocery expense was higher than usual. Review your spending.',
        isUnread: false,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: AppTextStyles.body1.copyWith(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Mark all as read',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.main,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationCard(notification);
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.widget,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              notification.icon,
              color: AppColors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    
                    // Unread Indicator
                    if (notification.isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(top: 4, left: 8),
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                
                // Time
                Text(
                  notification.time,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.grey,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Description
                Text(
                  notification.description,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String time;
  final String description;
  final bool isUnread;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.time,
    required this.description,
    this.isUnread = false,
  });
}
