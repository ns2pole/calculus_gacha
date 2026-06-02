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
  void Function(String status)? _onStatus;

  bool get isListening => _isListening;
  bool get isAvailable => _speech.isAvailable;

  Future<bool> initialize() async {
    if (_initialized) return _speech.isAvailable;
    _initialized = await _speech.initialize(
      onError: (error) => debugPrint('[VoiceInput] error: $error'),
      onStatus: (status) {
        debugPrint('[VoiceInput] status: $status');
        _onStatus?.call(status);
      },
    );
    return _initialized && _speech.isAvailable;
  }

  Future<bool> ensureMicrophonePermission() async {
    if (kIsWeb) return true;

    var micStatus = await Permission.microphone.status;
    if (!micStatus.isGranted) {
      micStatus = await Permission.microphone.request();
    }
    if (!micStatus.isGranted) return false;

    // speech_to_text on Apple platforms also needs speech recognition permission.
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      var speechStatus = await Permission.speech.status;
      if (!speechStatus.isGranted) {
        speechStatus = await Permission.speech.request();
      }
      if (!speechStatus.isGranted) return false;
    }

    return true;
  }

  /// Stops recognition and clears accumulated transcript for a fresh session.
  Future<void> resetSession() async {
    _isListening = false;
    await _speech.cancel();
  }

  static const Duration defaultPauseFor = Duration(milliseconds: 2500);
  static const Duration defaultListenFor = Duration(seconds: 60);

  Future<void> startListening({
    required void Function(String text, bool isFinal) onResult,
    void Function(String status)? onStatus,
    String? localeId,
    Duration? pauseFor,
    Duration? listenFor,
  }) async {
    final ready = await initialize();
    if (!ready) return;

    final permitted = await ensureMicrophonePermission();
    if (!permitted) return;

    await resetSession();

    _onStatus = onStatus;
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
        pauseFor: pauseFor ?? defaultPauseFor,
        listenFor: listenFor ?? defaultListenFor,
      ),
    );
  }

  Future<void> stopListening() async {
    if (!_isListening) return;
    _isListening = false;
    await _speech.stop();
  }

  Future<void> dispose() async {
    await resetSession();
  }
}
