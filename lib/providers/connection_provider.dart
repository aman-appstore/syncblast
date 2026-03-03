import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncblast/services/network_service.dart';

class ConnectionState {
  final bool isSearching;
  final List<Map<String, String>> discoveredTribes;

  ConnectionState({this.isSearching = false, this.discoveredTribes = const []});
}

class ConnectionNotifier extends StateNotifier<ConnectionState> {
  final NetworkService _networkService = NetworkService();

  ConnectionNotifier() : super(ConnectionState());

  // Master Mode
  void hostTribe(String name) {
    _networkService.startBroadcasting(name);
  }

  // Slave Mode
  void startSearching() {
    state = ConnectionState(isSearching: true, discoveredTribes: []);
    _networkService.lookForTribe((ip, name) {
      // Nayi Tribe mili
      final alreadyFound = state.discoveredTribes.any((t) => t['ip'] == ip);
      if (!alreadyFound) {
        state = ConnectionState(
          isSearching: true,
          discoveredTribes: [
            ...state.discoveredTribes,
            {'ip': ip, 'name': name},
          ],
        );
      }
    });
  }

  void stopAll() {
    _networkService.stop();
    state = ConnectionState(isSearching: false, discoveredTribes: []);
  }
}

final connectionProvider =
    StateNotifierProvider<ConnectionNotifier, ConnectionState>((ref) {
      return ConnectionNotifier();
    });
