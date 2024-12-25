import 'package:ticker_tape/ticker_tape.dart' as ticker_tape;

void main(List<String> arguments) {
  var ticker = ticker_tape.Ticker();
  ticker.start();
  for (int i = 0; i < 1000000; i++) {
    ticker.moveNext();
  }
  print(ticker);
}
