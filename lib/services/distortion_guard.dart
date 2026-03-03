class DistortionGuard {
  // AI Logic: Speaker protection
  static double calculateSafeVolume(
    double currentVolume,
    double speakerHealth,
  ) {
    // Agar speaker health low hai (AI detected), toh volume limit karo
    if (speakerHealth < 0.6 && currentVolume > 0.8) {
      return 0.75; // Auto-cap at 75% to prevent distortion
    }
    return currentVolume;
  }

  // Frequency analysis to check if sound is "shaking" too much
  static bool isDistorting(List<int> pcmData) {
    // Simple peak detection algorithm
    int peaks = pcmData.where((sample) => sample > 250 || sample < 5).length;
    return peaks >
        (pcmData.length *
            0.1); // 10% samples clipping matlab awaaz fat rahi hai
  }
}
