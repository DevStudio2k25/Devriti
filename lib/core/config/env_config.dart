/// Environment configuration for different build variants
enum Environment { development, staging, production }

class EnvConfig {
  final Environment environment;
  final String apiBaseUrl;
  final String apiKey;
  final bool enableLogging;
  final bool enableAnalytics;

  const EnvConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.apiKey,
    required this.enableLogging,
    required this.enableAnalytics,
  });

  /// Gemini AI API Key
  static const String geminiApiKey = 'AIzaSyCmtXahWW-k_oheIr9E5AsY8MKwtsaEKB8';

  /// Development configuration
  static const EnvConfig development = EnvConfig(
    environment: Environment.development,
    apiBaseUrl: 'https://dev-api.sukoon.app',
    apiKey: 'dev_api_key',
    enableLogging: true,
    enableAnalytics: false,
  );

  /// Staging configuration
  static const EnvConfig staging = EnvConfig(
    environment: Environment.staging,
    apiBaseUrl: 'https://staging-api.sukoon.app',
    apiKey: 'staging_api_key',
    enableLogging: true,
    enableAnalytics: true,
  );

  /// Production configuration
  static const EnvConfig production = EnvConfig(
    environment: Environment.production,
    apiBaseUrl: 'https://api.sukoon.app',
    apiKey: 'prod_api_key',
    enableLogging: false,
    enableAnalytics: true,
  );

  /// Current environment (default to development)
  static const EnvConfig current = development;

  bool get isDevelopment => environment == Environment.development;
  bool get isStaging => environment == Environment.staging;
  bool get isProduction => environment == Environment.production;
}
