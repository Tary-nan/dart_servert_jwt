import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:pedantic/pedantic.dart';
import 'package:web_socket_channel/io.dart';

void main()async{
  final socket = IOWebSocketChannel.connect(
      Uri.parse('ws://localhost:8090/realtime/ws'));
    void fallback(Parameters parameters) => print('fallback: ${parameters.value}');

    final peer = Peer(socket.cast<String>());
    peer.registerFallback(fallback);
    peer.registerMethod('onMessage', () => null);
    unawaited(peer.listen());

    await peer.sendRequest('onMessage', {'msg': 'Hello youss'});
    //await peer.close();
}