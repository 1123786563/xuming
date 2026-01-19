/// 全局字符串常量管理
/// 
/// 遵循 "大写下划线" 命名习惯的 key 对应 UI 显示的 "UPPERCASE" 风格文案
class AppStrings {
  const AppStrings._();

  static const String appName = "XuMing";

  // -- Dashboard --
  static const String dashboardTitle = "BIO-MONITOR";
  static const String bioStatusLabel = "BIO_STATUS";
  static const String bioStatusOptimal = "OPTIMAL";
  static const String bioStatusStable = "STABLE";
  static const String bioStatusWarning = "WARNING";
  static const String bioStatusCritical = "CRITICAL";
  static const String hpLabel = "HP";
  static const String coinsLabel = "COINS";
  static const String levelLabel = "LVL";
  
  // -- Navigation --
  static const String navHome = "MONITOR";
  static const String navShop = "SHOP";
  static const String navSocial = "NETWORK";
  static const String navProfile = "PROFILE";

  // -- Exercise Common --
  static const String procedureIdPrefix = "PROCEDURE_";
  static const String taskPrefix = "TASK: ";
  static const String skipProcedure = "SKIP_PROCEDURE";
  static const String bossMode = "BOSS MODE";
  static const String recoveryLevel = "RECOVERY_LEVEL";
  
  // -- Specific Exercises --
  // Bone Reset
  static const String boneResetTitle = "骨骼复位 [ASMR]";
  static const String boneResetTask = "音效同步: 骨骼复位";
  static const String boneResetQuote = "Close your eyes. Listen to the resonance of your own structure.";
  
  // Visual Neural
  static const String visualNeuralTitle = "视觉神经重置";
  static const String visualNeuralTask = "OCULAR_CALIBRATION_V1.0.4";
  static const String visualNeuralQuote = "Your eyes are frying from the blue light. Give them a break.";
  
  // -- Tech/Decorations --
  static const String sysCalibrating = "SYS_CALIBRATING";
  static const String latencyLabel = "LATENCY";
  static const String refreshLabel = "REFRESH";

  // -- Auth/Login --
  static const String appSlogan = "延缓报废 即刻续命";
  static const String mobileEntryLabel = "Mobile_Entry";
  static const String enterDigitsHint = "ENTER_DIGITS";
  static const String validationProtocolLabel = "Validation_Protocol";
  static const String codeHint = "6-DIGIT_CODE";
  static const String initializeLogin = "INITIALIZE_LOGIN";
  static const String userAuthPending = "USER_AUTH_PENDING";
  static const String otherLoginMethods = "其他方式注入生命值";
  static const String weChat = "WE_CHAT";
  static const String systemQQ = "SYSTEM_QQ";
  static const String biometric = "BIOMETRIC";
  static const String errorInvalidPhone = "请输入正确的手机号";
  static const String errorEmptyCredentials = "请输入凭证进行初始化";
}
