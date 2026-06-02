class AiChatApiConfig {
  static const defaultEndpoint = String.fromEnvironment(
    'AI_CHAT_ENDPOINT',
    defaultValue: '',
  );
  static const defaultEntitlementSyncEndpoint = String.fromEnvironment(
    'AI_TUTOR_ENTITLEMENT_SYNC_ENDPOINT',
    defaultValue: '',
  );
  static const defaultAccountDeletionEndpoint = String.fromEnvironment(
    'ACCOUNT_DELETION_ENDPOINT',
    defaultValue: '',
  );

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
    final value = defaultEndpoint.trim();
    final endpoint = value.isEmpty ? null : Uri.parse(value);
    final syncValue = defaultEntitlementSyncEndpoint.trim();
    final accountDeletionValue = defaultAccountDeletionEndpoint.trim();
    return AiChatApiConfig(
      endpoint: endpoint,
      entitlementSyncEndpoint: syncValue.isEmpty
          ? _deriveEntitlementSyncEndpoint(endpoint)
          : Uri.parse(syncValue),
      accountDeletionEndpoint: accountDeletionValue.isEmpty
          ? _deriveSiblingEndpoint(endpoint, 'deleteMyAccount')
          : Uri.parse(accountDeletionValue),
    );
  }

  bool get isConfigured => endpoint != null;

  static Uri? _deriveEntitlementSyncEndpoint(Uri? endpoint) {
    return _deriveSiblingEndpoint(endpoint, 'syncAiTutorEntitlement');
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
