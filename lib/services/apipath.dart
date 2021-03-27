class APIPath {
  static String user(String uid) => 'Users/$uid';
  static String userget()=>'User';
  static String post()=>'Posts';
  static String postadd(String postid)=>'Posts/$postid';
  static String setHire(String id)=>'Hiring/$id';
  static String createChatRoom(String chatRoomId)=>'ChatRoom/$chatRoomId';
  static String chatStream(String chatRoomId)=>'ChatRoom/$chatRoomId/chats';
  static String addchats(String chatRoomId,String date)=>'ChatRoom/$chatRoomId/chats/$date';
  static String chatRoomStream()=>'ChatRoom';
  static String addbookings(String orderid)=>'Booking/$orderid';
  static String bookingstream()=>'Booking'; 
  static String hiringstream()=>'Hiring';
}
