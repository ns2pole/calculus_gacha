import '../../integrations/ai_chat/joymath_ai_chat_config.dart';

/// Joymath build-time endpoint configuration (used by entitlement sync, etc.).
class AiChatApiConfig {
  final Uri? endpoint;
  final Uri? entitlementSyncEndpoint;
  final Uri? accountDeletionEndpoint;
  final Duration timeout;

  const AiChatApiConfig({
    this.endpoint,
    this.entitlementSyncEndpoint,
    this.accountDeletionEndpoint,
    this.timeout = const Duration(seconds: 60),
  });

  factory AiChatApiConfig.fromEnvironment() {
    final api = JoymathAiChatConfig.apiConfigFromEnvironment();
    return AiChatApiConfig(
      endpoint: api.endpoint,
      entitlementSyncEndpoint:
          JoymathAiChatConfig.entitlementSyncEndpointFromEnvironment(),
      accountDeletionEndpoint:
          JoymathAiChatConfig.accountDeletionEndpointFromEnvironment(),
      timeout: api.timeout,
    );
  }

  bool get isConfigured => endpoint != null;
}
