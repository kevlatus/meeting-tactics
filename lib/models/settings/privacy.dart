class PrivacySettings {
  final bool allowUsageTracking;
  final bool isPrivacyInitialized;

  const PrivacySettings({
    this.allowUsageTracking = false,
    this.isPrivacyInitialized = false,
  });

  const PrivacySettings.allowAll()
      : allowUsageTracking = true,
        isPrivacyInitialized = true;

  PrivacySettings copyWith({
    bool allowUsageTracking,
    bool isPrivacyInitialized,
  }) =>
      PrivacySettings(
        allowUsageTracking: allowUsageTracking ?? this.allowUsageTracking,
        isPrivacyInitialized: isPrivacyInitialized ?? this.isPrivacyInitialized,
      );
}
