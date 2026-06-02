class AiChatApiConfig {
  final Uri? endpoint;
  final Duration timeout;
  final String installationIdStorageKey;

  const AiChatApiConfig({
    this.endpoint,
    this.timeout = const Duration(seconds: 60),
    this.installationIdStorageKey = 'ai_chat_kit/installation_id',
  });

  bool get isConfigured => endpoint != null;
}
