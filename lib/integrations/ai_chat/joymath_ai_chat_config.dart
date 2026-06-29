import 'package:ai_chat_kit/ai_chat_kit.dart';

class JoymathAiChatConfig {
  static const defaultEndpoint = String.fromEnvironment(
    'AI_CHAT_ENDPOINT',
    defaultValue: '',
  );

  static AiChatApiConfig apiConfigFromEnvironment() {
    final value = defaultEndpoint.trim();
    final endpoint = value.isEmpty ? null : Uri.parse(value);
    return AiChatApiConfig(
      endpoint: endpoint,
      installationIdStorageKey: 'joymath/ai_chat_installation_id',
    );
  }

  static Uri? entitlementSyncEndpointFromEnvironment() {
    const syncValue = String.fromEnvironment(
      'AI_TUTOR_ENTITLEMENT_SYNC_ENDPOINT',
      defaultValue: '',
    );
    if (syncValue.trim().isNotEmpty) return Uri.parse(syncValue.trim());

    final endpoint = apiConfigFromEnvironment().endpoint;
    return _deriveSiblingEndpoint(endpoint, 'syncAiTutorEntitlement');
  }

  static Uri? aiTutorUsageEndpointFromEnvironment() {
    const usageValue = String.fromEnvironment(
      'AI_TUTOR_USAGE_ENDPOINT',
      defaultValue: '',
    );
    if (usageValue.trim().isNotEmpty) return Uri.parse(usageValue.trim());

    final endpoint = apiConfigFromEnvironment().endpoint;
    return _deriveSiblingEndpoint(endpoint, 'aiTutorUsage');
  }

  static Uri? accountDeletionEndpointFromEnvironment() {
    const deletionValue = String.fromEnvironment(
      'ACCOUNT_DELETION_ENDPOINT',
      defaultValue: '',
    );
    if (deletionValue.trim().isNotEmpty) return Uri.parse(deletionValue.trim());

    final endpoint = apiConfigFromEnvironment().endpoint;
    return _deriveSiblingEndpoint(endpoint, 'deleteMyAccount');
  }

  static Uri? _deriveSiblingEndpoint(Uri? endpoint, String functionName) {
    if (endpoint == null) return null;

    final segments = endpoint.pathSegments;
    if (segments.isEmpty || segments.last != 'aiChat') return null;

    return endpoint.replace(
      pathSegments: [...segments.take(segments.length - 1), functionName],
    );
  }
}
