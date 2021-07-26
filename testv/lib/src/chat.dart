List<String> recv_msg = [
  "Hi",
  "I hope you are doing fine",
  "i know things havnt been so good for u in recent times",
  "but i promise u ",
  "everything will be fine soon",
  "wait for it",
  "there is nothing i can do for u dalwari"
];
List<String> send_msg = [
  "hello",
  "Yes i Understand",
  "you did realise?",
  "i hope soo ",
  "what else can i do",
  "i understand you sarah",
  "bye"
];

void main(List<String> args) {
  print(recv_msg[2]);
  recv_msg.forEach((element) {
    print("element=> $element");
  });
}
