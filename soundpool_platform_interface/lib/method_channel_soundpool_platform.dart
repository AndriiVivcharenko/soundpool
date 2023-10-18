import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:soundpool_platform_interface/soundpool_platform_interface.dart';

class MethodChannelSoundpoolPlatform extends SoundpoolPlatform {
  static const MethodChannel _channel =
      const MethodChannel('pl.ukaszapps/soundpool');

  @override
  Future<int> init(int streamType, int maxStreams,
          Map<String, dynamic> platformOptions) async =>
      (await _channel.invokeMethod(
          "initSoundpool",
          <String, dynamic>{"maxStreams": maxStreams, "streamType": streamType}
            ..addAll(platformOptions)))!;

  @override
  Future<int> loadUri(int poolId, String uri, int priority) async =>
      (await _channel.invokeMethod(
          "loadUri", {"poolId": poolId, "uri": uri, "priority": priority}))!;

  @override
  Future<double> getDuration(int sourceId) async =>
      (await _channel.invokeMethod("getDuration", {"sourceId": sourceId})) ?? 0;

  @override
  Future<int> loadUint8List(
          int poolId, Uint8List rawSound, int priority) async =>
      (await _channel.invokeMethod("load",
          {"poolId": poolId, "rawSound": rawSound, "priority": priority}))!;

  @override
  Future<int> play(int poolId, int soundId, int repeat, double rate, double offset) async =>
      (await _channel.invokeMethod("play", {
        "poolId": poolId,
        "soundId": soundId,
        "repeat": repeat,
        "rate": rate,
        "offset": offset
      }))!;

  @override
  Future<void> stop(int poolId, int streamId) => _channel.invokeMethod("stop", {
        "poolId": poolId,
        "streamId": streamId,
      });

  @override
  Future<void> pause(int poolId, int streamId) =>
      _channel.invokeMethod("pause", {
        "poolId": poolId,
        "streamId": streamId,
      });

  @override
  Future<bool> resume(int poolId, int streamId) async =>
      (await _channel.invokeMethod("resume", {
        "poolId": poolId,
        "streamId": streamId,
      })) ?? false;

  @override
  Future<void> setVolume(int poolId, int? soundId, int? streamId,
          double? volumeLeft, double? volumeRight) =>
      _channel.invokeMethod("setVolume", {
        "poolId": poolId,
        "soundId": soundId,
        "streamId": streamId,
        "volumeLeft": volumeLeft,
        "volumeRight": volumeRight,
      });

  @override
  Future<void> setRate(int poolId, int streamId, double playbackRate) =>
      _channel.invokeMethod("setRate", {
        "poolId": poolId,
        "streamId": streamId,
        "rate": playbackRate,
      });

  @override
  Future<void> dispose(int poolId) => _channel.invokeMethod("dispose", {
        "poolId": poolId,
      });

  @override
  Future<void> release(int poolId) =>
      _channel.invokeMethod("release", {"poolId": poolId});
}
