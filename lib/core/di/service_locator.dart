/// Service Locator for Dependency Injection
/// Simple implementation without external packages
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, dynamic> _services = {};
  final Map<Type, Function> _factories = {};

  /// Register a singleton service
  void registerSingleton<T>(T service) {
    _services[T] = service;
  }

  /// Register a factory for lazy initialization
  void registerFactory<T>(T Function() factory) {
    _factories[T] = factory;
  }

  /// Get a service instance
  T get<T>() {
    // Check if singleton exists
    if (_services.containsKey(T)) {
      return _services[T] as T;
    }

    // Check if factory exists
    if (_factories.containsKey(T)) {
      final service = _factories[T]!() as T;
      _services[T] = service; // Cache the instance
      return service;
    }

    throw Exception('Service of type $T is not registered');
  }

  /// Check if a service is registered
  bool isRegistered<T>() {
    return _services.containsKey(T) || _factories.containsKey(T);
  }

  /// Remove a service
  void unregister<T>() {
    _services.remove(T);
    _factories.remove(T);
  }

  /// Clear all services
  void reset() {
    _services.clear();
    _factories.clear();
  }
}

// Global instance
final serviceLocator = ServiceLocator();
