main(List<String> args) {
  out(printOutLoud);
}

printOutLoud(String message) {
  print(message.toUpperCase());
}

out(void inner(String message)) {
  inner('Message from inner function');
}
