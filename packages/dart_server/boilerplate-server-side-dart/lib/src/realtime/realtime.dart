import 'package:boilerplate_server_side_dart/src/auth/middleware/check_autorization.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:pedantic/pedantic.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Realtime {
  DbCollection store;

  Realtime({this.store});

  Handler get router {
    final router = Router();

    void fallback(Parameters parameters) => print('fallback: ${parameters.value}');

    Future<void> onMessage(Peer peer, String username, Parameters parameters) async {
      final filteredPeers = [peer, peer];
      print('////////////////////////////////////////////');
      print(username); 
      print('////////////////////////////////////////////');
      for (final peer in filteredPeers) {
        unawaited(peer.sendRequest('onMessage', {
          ...parameters.asMap,
          'sender': username,
        }));
      }
    }


    void _onNewWebsocket(Request request, WebSocketChannel webSocket) {
      final peer =  Peer(webSocket.cast<String>());
      peer.registerFallback(fallback);
      peer.registerMethod(
        'onMessage',
        (parameters) => onMessage(peer, 'Tray', parameters),
      );
       unawaited(peer.listen());
      //final account = request.context['account'] as MapEntry<String, String>;
    }
    router.get('/ws', (Request request) => webSocketHandler((WebSocketChannel webSocket)
            =>_onNewWebsocket(request, webSocket))(request));

    var handler =
        const Pipeline()
        //.addMiddleware(checkAuthorization())
        .addHandler(router);
    return handler;
  }
}
