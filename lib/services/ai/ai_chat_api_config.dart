class AiChatApiConfig {
  static const defaultEndpoint = String.fromEnvironment(
    'AI_CHAT_ENDPOINT',
    defaultValue: '',
  );

  final Uri? endpoint;
  final Duration timeout;

  const AiChatApiConfig({
    this.endpoint,
    this.timeout = const Duration(seconds: 60),
  });

  factory AiChatApiConfig.fromEnvironment() {
    final value = defaultEndpoint.trim();
    return AiChatApiConfig(endpoint: value.isEmpty ? null : Uri.parse(value));
  }

  bool get isConfigured => endpoint != null;
}
