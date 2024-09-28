import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewFriendState {
  final String url;
  final Set<String> characters;
  final String name;
  final String signature;

  NewFriendState({
    this.url = "",
    this.characters = const {},
    this.name = "",
    this.signature = "",
  });

  NewFriendState copyWith({
    String? url,
    Set<String>? characters,
    String? name,
    String? signature,
  }) {
    return NewFriendState(
      url: url ?? this.url,
      characters: characters ?? this.characters,
      name: name ?? this.name,
      signature: signature ?? this.signature,
    );
  }
}

class NewFriendNotifier extends Notifier<NewFriendState> {
  @override
  NewFriendState build() {
    return NewFriendState();
  }

  changeUrl(String url) {
    state = state.copyWith(url: url);
  }

  addOrRemoveCharacter(String character) {
    if (state.characters.contains(character)) {
      state = state.copyWith(
          characters: Set.from(state.characters)..remove(character));
    } else {
      state = state.copyWith(
          characters: Set.from(state.characters)..add(character));
    }
  }

  changeName(String name) {
    state = state.copyWith(name: name);
  }

  changeSignature(String signature) {
    state = state.copyWith(signature: signature);
  }
}

final newFriendProvider =
    NotifierProvider<NewFriendNotifier, NewFriendState>(() {
  return NewFriendNotifier();
});
