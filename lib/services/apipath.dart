class APIPath {
  static String user(String uid) => 'Users/$uid';
  static String post()=>'Posts';
  static String setHire(String id)=>'Hiring/$id';
  static String createChatRoom(String chatRoomId)=>'ChatRoom/$chatRoomId';
}
