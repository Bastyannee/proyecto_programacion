class NicknameManager {
  // Patrón Singleton para mantener la misma memoria en toda la app
  static final NicknameManager _instance = NicknameManager._internal();
  factory NicknameManager() => _instance;
  NicknameManager._internal();

  // Diccionario que asocia el nombre original con el apodo
  final Map _nicknames = {};

  void setNickname(String originalName, String nickname) {
    if (nickname.trim().isEmpty) {
      _nicknames.remove(originalName.toLowerCase());
    } else {
      _nicknames[originalName.toLowerCase()] = nickname;
    }
  }

  String getDisplayName(String originalName) {
    return _nicknames[originalName.toLowerCase()] ?? originalName;
  }
}