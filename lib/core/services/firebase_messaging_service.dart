import 'dart:convert';

// Firebase Messaging would be imported here:
// import 'package:firebase_messaging/firebase_messaging.dart';

/// Firebase Cloud Messaging Service
/// Handles push notifications, background messages, and notification scheduling
class FirebaseMessagingService {
  // final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Initialize FCM and request permissions
  Future<void> initialize() async {
    try {
      // Request permission for notifications
      // final settings = await _messaging.requestPermission(
      //   alert: true,
      //   announcement: false,
      //   badge: true,
      //   carPlay: false,
      //   criticalAlert: false,
      //   provisional: false,
      //   sound: true,
      // );

      // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //   print('User granted permission');
      // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      //   print('User granted provisional permission');
      // } else {
      //   print('User declined or has not accepted permission');
      // }

      // Set up message handlers
      // setupMessageHandlers();

      // Placeholder implementation
      await Future.delayed(const Duration(milliseconds: 500));
      print('FCM: Service initialized');
    } catch (e) {
      print('Failed to initialize FCM: ${e.toString()}');
    }
  }

  /// Get FCM token
  Future<String?> getToken() async {
    try {
      // final token = await _messaging.getToken();
      // return token;

      // Placeholder implementation
      await Future.delayed(const Duration(milliseconds: 300));
      return 'fcm_token_placeholder_${DateTime.now().millisecondsSinceEpoch}';
    } catch (e) {
      print('Failed to get FCM token: ${e.toString()}');
      return null;
    }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      // await _messaging.subscribeToTopic(topic);

      // Placeholder implementation
      await Future.delayed(const Duration(milliseconds: 200));
      print('FCM: Subscribed to topic: $topic');
    } catch (e) {
      print('Failed to subscribe to topic: ${e.toString()}');
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      // await _messaging.unsubscribeFromTopic(topic);

      // Placeholder implementation
      await Future.delayed(const Duration(milliseconds: 200));
      print('FCM: Unsubscribed from topic: $topic');
    } catch (e) {
      print('Failed to unsubscribe from topic: ${e.toString()}');
    }
  }

  /// Setup message handlers
  void setupMessageHandlers() {
    // Handle messages when app is in foreground
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Received foreground message: ${message.messageId}');
    //   _handleMessage(message);
    // });

    // Handle messages when app is opened from background
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('Message opened app: ${message.messageId}');
    //   _handleMessageOpenedApp(message);
    // });

    // Handle background messages
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    print('FCM: Message handlers setup complete');
  }

  /// Handle foreground messages
  void _handleMessage(Map<String, dynamic> message) {
    final notification = NotificationData.fromMap(message);

    switch (notification.type) {
      case NotificationType.budgetAlert:
        _handleBudgetAlert(notification);
        break;
      case NotificationType.goalReminder:
        _handleGoalReminder(notification);
        break;
      case NotificationType.transactionReminder:
        _handleTransactionReminder(notification);
        break;
      case NotificationType.monthlyReport:
        _handleMonthlyReport(notification);
        break;
      case NotificationType.general:
        _handleGeneralNotification(notification);
        break;
    }
  }

  /// Handle message when app is opened from notification
  void _handleMessageOpenedApp(Map<String, dynamic> message) {
    final notification = NotificationData.fromMap(message);

    // Navigate to appropriate screen based on notification type
    switch (notification.type) {
      case NotificationType.budgetAlert:
        // Navigate to budget screen
        print('Navigate to budget screen');
        break;
      case NotificationType.goalReminder:
        // Navigate to goals screen
        print('Navigate to goals screen');
        break;
      case NotificationType.transactionReminder:
        // Navigate to add transaction screen
        print('Navigate to add transaction screen');
        break;
      case NotificationType.monthlyReport:
        // Navigate to analytics screen
        print('Navigate to analytics screen');
        break;
      case NotificationType.general:
        // Navigate to main screen
        print('Navigate to main screen');
        break;
    }
  }

  /// Send local notification for budget alerts
  void _handleBudgetAlert(NotificationData notification) {
    print('Budget Alert: ${notification.title} - ${notification.body}');
    // Show local notification
    // LocalNotificationService.show(
    //   title: notification.title,
    //   body: notification.body,
    //   payload: notification.data,
    // );
  }

  /// Handle goal reminder notifications
  void _handleGoalReminder(NotificationData notification) {
    print('Goal Reminder: ${notification.title} - ${notification.body}');
    // Show local notification with action buttons
    // LocalNotificationService.showWithActions(
    //   title: notification.title,
    //   body: notification.body,
    //   actions: ['View Goal', 'Add Money'],
    //   payload: notification.data,
    // );
  }

  /// Handle transaction reminder notifications
  void _handleTransactionReminder(NotificationData notification) {
    print('Transaction Reminder: ${notification.title} - ${notification.body}');
    // Show local notification
    // LocalNotificationService.show(
    //   title: notification.title,
    //   body: notification.body,
    //   payload: notification.data,
    // );
  }

  /// Handle monthly report notifications
  void _handleMonthlyReport(NotificationData notification) {
    print('Monthly Report: ${notification.title} - ${notification.body}');
    // Show rich notification with image
    // LocalNotificationService.showWithImage(
    //   title: notification.title,
    //   body: notification.body,
    //   imagePath: notification.imageUrl,
    //   payload: notification.data,
    // );
  }

  /// Handle general notifications
  void _handleGeneralNotification(NotificationData notification) {
    print('General Notification: ${notification.title} - ${notification.body}');
    // Show simple notification
    // LocalNotificationService.show(
    //   title: notification.title,
    //   body: notification.body,
    //   payload: notification.data,
    // );
  }

  /// Send notification to server for processing
  Future<bool> sendNotificationToUser(
    String userId,
    String title,
    String body,
    NotificationType type, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final payload = {
        'userId': userId,
        'title': title,
        'body': body,
        'type': type.name,
        'data': data ?? {},
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Send to your backend API which will use FCM Admin SDK
      // final response = await http.post(
      //   Uri.parse('${AppConfig.apiBaseUrl}/notifications/send'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: json.encode(payload),
      // );

      // return response.statusCode == 200;

      // Placeholder implementation
      await Future.delayed(const Duration(milliseconds: 500));
      print('Notification sent to user $userId: $title');
      return true;
    } catch (e) {
      print('Failed to send notification: ${e.toString()}');
      return false;
    }
  }

  /// Schedule budget alerts
  Future<void> scheduleBudgetAlerts(String userId) async {
    try {
      // This would typically be done on your backend
      await sendNotificationToUser(
        userId,
        'Budget Alert',
        'You are approaching your monthly budget limit',
        NotificationType.budgetAlert,
        data: {'category': 'Food', 'percentage': 85},
      );
    } catch (e) {
      print('Failed to schedule budget alerts: ${e.toString()}');
    }
  }

  /// Schedule goal reminders
  Future<void> scheduleGoalReminders(String userId) async {
    try {
      await sendNotificationToUser(
        userId,
        'Goal Reminder',
        'Keep saving! You are 70% towards your Emergency Fund goal',
        NotificationType.goalReminder,
        data: {'goalId': 'goal_123', 'progress': 70},
      );
    } catch (e) {
      print('Failed to schedule goal reminders: ${e.toString()}');
    }
  }

  /// Clear all notifications
  Future<void> clearAllNotifications() async {
    try {
      // Clear FCM notifications
      // await _messaging.deleteToken();

      // Placeholder implementation
      await Future.delayed(const Duration(milliseconds: 200));
      print('FCM: All notifications cleared');
    } catch (e) {
      print('Failed to clear notifications: ${e.toString()}');
    }
  }
}

/// Background message handler (must be top-level function)
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('Handling background message: ${message.messageId}');
//   // Handle background message processing here
// }

/// Notification data model
class NotificationData {
  final String title;
  final String body;
  final NotificationType type;
  final String? imageUrl;
  final Map<String, dynamic> data;

  NotificationData({
    required this.title,
    required this.body,
    required this.type,
    this.imageUrl,
    this.data = const {},
  });

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      title: map['notification']?['title'] ?? '',
      body: map['notification']?['body'] ?? '',
      type: NotificationType.values.firstWhere(
        (e) => e.name == map['data']?['type'],
        orElse: () => NotificationType.general,
      ),
      imageUrl: map['notification']?['image'],
      data: Map<String, dynamic>.from(map['data'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notification': {
        'title': title,
        'body': body,
        'image': imageUrl,
      },
      'data': {
        'type': type.name,
        ...data,
      },
    };
  }
}

/// Notification types enum
enum NotificationType {
  budgetAlert,
  goalReminder,
  transactionReminder,
  monthlyReport,
  general,
}
