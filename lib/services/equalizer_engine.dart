enum AudioProfile { party, bassBoost, vocalClear, flat }

class EqualizerEngine {
  // Profiles ka configuration (Gain values in dB)
  static Map<String, double> getProfileSettings(AudioProfile profile) {
    switch (profile) {
      case AudioProfile.bassBoost:
        return {'low': 1.5, 'mid': 1.0, 'high': 0.8}; // High Bass, Low Treble
      case AudioProfile.vocalClear:
        return {'low': 0.7, 'mid': 1.5, 'high': 1.2}; // High Mid for clarity
      case AudioProfile.party:
        return {
          'low': 1.3,
          'mid': 0.9,
          'high': 1.4,
        }; // V-Shape (Bass + Sparkle)
      case AudioProfile.flat:
      default:
        return {'low': 1.0, 'mid': 1.0, 'high': 1.0};
    }
  }

  // AI Logic: Agar phone ka speaker chota hai, toh auto-treble boost karna
  static AudioProfile suggestProfile(String deviceModel) {
    if (deviceModel.toLowerCase().contains("tablet") ||
        deviceModel.toLowerCase().contains("pad")) {
      return AudioProfile.bassBoost; // Bade devices par bass achha lagta hai
    }
    return AudioProfile.vocalClear;
  }
}
