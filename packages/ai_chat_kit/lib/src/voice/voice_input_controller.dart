import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceInputController {
  VoiceInputController({SpeechToText? speechToText})
      : _speech = speechToText ?? SpeechToText();

  final SpeechToText _speech;
  bool _initialized = false;
  bool _isListening = false;

  bool get isListening => _isListening;
  bool get isAvailable => _speech.isAvailable;

  Future<bool> initialize() async {
    if (_initialized) return _speech.isAvailable;
    _initialized = await _speech.initialize(
      onError: (error) => debugPrint('[VoiceInput] error: $error'),
      onStatus: (status) => debugPrint('[VoiceInput] status: $status'),
    );
    return _initialized && _speech.isAvailable;
  }

  Future<bool> ensureMicrophonePermission() async {
    if (kIsWeb) return true;
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> startListening({
    required void Function(String text, bool isFinal) onResult,
    String? localeId,
  }) async {
    if (_isListening) return;

    final ready = await initialize();
    if (!ready) return;

    final permitted = await ensureMicrophonePermission();
    if (!permitted) return;

    _isListening = true;
    await _speech.listen(
      onResult: (SpeechRecognitionResult result) {
        onResult(result.recognizedWords, result.finalResult);
      },
      listenOptions: SpeechListenOptions(
        localeId: localeId,
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
        partialResults: true,
      ),
    );
  }

  Future<void> stopListening() async {
    if (!_isListening) return;
    _isListening = false;
    await _speech.stop();
  }

  Future<void> dispose() async {
    await stopListening();
    _speech.cancel();
  }
}
