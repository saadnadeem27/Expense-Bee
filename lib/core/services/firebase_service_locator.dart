import 'firebase_auth_service.dart';
import 'firestore_service.dart';
import 'firebase_storage_service.dart';
import 'firebase_analytics_service.dart';
import 'firebase_messaging_service.dart';

/// Firebase Service Locator
/// Manages dependency injection and service initialization for Firebase services
class FirebaseServiceLocator {
  static FirebaseServiceLocator? _instance;
  static FirebaseServiceLocator get instance => _instance ??= FirebaseServiceLocator._();

  FirebaseServiceLocator._();

  // Service instances
  FirebaseAuthService? _authService;
  FirestoreService? _firestoreService;
  FirebaseStorageService? _storageService;
  FirebaseAnalyticsService? _analyticsService;
  FirebaseMessagingService? _messagingService;

  /// Initialize all Firebase services
  Future<void> initialize() async {
    try {
      print('🔥 Initializing Firebase services...');

      // Initialize Firebase Core first (would be done in main.dart)
      // await Firebase.initializeApp(
      //   options: FirebaseConfig.currentPlatform,
      // );

      // Initialize individual services
      _authService = FirebaseAuthService();
      _firestoreService = FirestoreService();
      _storageService = FirebaseStorageService();
      _analyticsService = FirebaseAnalyticsService();
      _messagingService = FirebaseMessagingService();

      // Initialize messaging service
      await _messagingService?.initialize();

      print('✅ Firebase services initialized successfully');
    } catch (e) {
      print('❌ Failed to initialize Firebase services: ${e.toString()}');
      rethrow;
    }
  }

  /// Get Authentication Service
  FirebaseAuthService get auth {
    if (_authService == null) {
      throw Exception('Firebase Auth Service not initialized. Call initialize() first.');
    }
    return _authService!;
  }

  /// Get Firestore Service
  FirestoreService get firestore {
    if (_firestoreService == null) {
      throw Exception('Firestore Service not initialized. Call initialize() first.');
    }
    return _firestoreService!;
  }

  /// Get Storage Service
  FirebaseStorageService get storage {
    if (_storageService == null) {
      throw Exception('Firebase Storage Service not initialized. Call initialize() first.');
    }
    return _storageService!;
  }

  /// Get Analytics Service
  FirebaseAnalyticsService get analytics {
    if (_analyticsService == null) {
      throw Exception('Firebase Analytics Service not initialized. Call initialize() first.');
    }
    return _analyticsService!;
  }

  /// Get Messaging Service
  FirebaseMessagingService get messaging {
    if (_messagingService == null) {
      throw Exception('Firebase Messaging Service not initialized. Call initialize() first.');
    }
    return _messagingService!;
  }

  /// Dispose all services
  void dispose() {
    _authService = null;
    _firestoreService = null;
    _storageService = null;
    _analyticsService = null;
    _messagingService = null;
    print('🧹 Firebase services disposed');
  }

  /// Check if services are initialized
  bool get isInitialized {
    return _authService != null &&
           _firestoreService != null &&
           _storageService != null &&
           _analyticsService != null &&
           _messagingService != null;
  }

  /// Get service initialization status
  Map<String, bool> get serviceStatus {
    return {
      'auth': _authService != null,
      'firestore': _firestoreService != null,
      'storage': _storageService != null,
      'analytics': _analyticsService != null,
      'messaging': _messagingService != null,
    };
  }

  /// Reinitialize services (useful for testing or error recovery)
  Future<void> reinitialize() async {
    dispose();
    await initialize();
  }
}

/// Global service locator instance for easy access
final firebaseServices = FirebaseServiceLocator.instance;