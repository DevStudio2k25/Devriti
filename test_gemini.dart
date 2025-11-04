// Quick test script to verify Gemini API
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  const apiKey = 'AIzaSyBm4g99em2hOMm7pD4MGAzUiLNm-nlg_fE';

  print('Testing Gemini API with key: ${apiKey.substring(0, 15)}...\n');

  // Try gemini-1.5-pro
  try {
    print('Trying model: gemini-1.5-pro');
    final model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);

    final response = await model.generateContent([
      Content.text('Say "Hello from Gemini!"'),
    ]);

    print('✅ SUCCESS with gemini-1.5-pro!');
    print('Response: ${response.text}\n');
    return;
  } catch (e) {
    print('❌ gemini-1.5-pro failed: $e\n');
  }

  // Try gemini-pro
  try {
    print('Trying model: gemini-pro');
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

    final response = await model.generateContent([
      Content.text('Say "Hello from Gemini!"'),
    ]);

    print('✅ SUCCESS with gemini-pro!');
    print('Response: ${response.text}\n');
    return;
  } catch (e) {
    print('❌ gemini-pro failed: $e\n');
  }

  print('\n❌ All models failed!');
  print('\nTroubleshooting:');
  print(
    '1. Check if API key is enabled at: https://makersuite.google.com/app/apikey',
  );
  print('2. Make sure "Generative Language API" is enabled');
  print('3. Check internet connection');
  print('4. Try generating a new API key');
}
