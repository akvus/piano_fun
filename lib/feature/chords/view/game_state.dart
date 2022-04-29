import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

enum CurrentResult { none, success, failure }

@freezed
class GameState with _$GameState {
  const factory GameState({
    required int gamesCount,
    required int successCount,
    required CurrentResult currentResult,
  }) = _GameState;

  const GameState._();

  factory GameState.newGame() => const GameState(
        gamesCount: 0,
        successCount: 0,
        currentResult: CurrentResult.none,
      );

  double get successRate =>
      gamesCount == 0 ? 100 : successCount * 100 / gamesCount;

  GameState addSuccess() => GameState(
        gamesCount: gamesCount + 1,
        successCount: successCount + 1,
        currentResult: CurrentResult.success,
      );

  GameState addFailure() => GameState(
        gamesCount: gamesCount + 1,
        successCount: successCount,
        currentResult: CurrentResult.failure,
      );
}
