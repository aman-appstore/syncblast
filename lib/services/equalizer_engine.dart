enum AudioProfile { party, bassBoost, vocalClear, flat }

class EqualizerEngine {
  // Profiles ka configuration (Gain values in dB)
  static Map<String, double> getProfileSettings(AudioProfile profile) {
    switch (profile) {
      case AudioProfile.bassBoost:
        return {'low': 1.5, 'mid': 1.0, 'high': 0.8};
      case AudioProfile.vocalClear:
        return {'low': 0.7, 'mid': 1.5, 'high': 1.2};
      case AudioProfile.party:
        return {'low': 1.3, 'mid': 0.9, 'high': 1.4};
      case AudioProfile.flat:
        return {'low': 1.0, 'mid': 1.0, 'high': 1.0};
      // Default ko hata diya kyunki enum poora cover ho gaya hai
    }
  }

  // AI Logic: Agar phone ka speaker chota hai, toh auto-treble boost karna
  static AudioProfile suggestProfile(String deviceModel) {
    final model = deviceModel
        .toLowerCase(); // Ek baar lowercase karke check karna fast hota hai
    if (model.contains("tablet") || model.contains("pad")) {
      return AudioProfile.bassBoost;
    }
    return AudioProfile.vocalClear;
  }
}
