// This is a generated file - do not edit.
//
// Generated from mesh.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'mesh.pb.dart' as $0;

export 'mesh.pb.dart';

@$pb.GrpcServiceName('delta.v1.MeshSync')
class MeshSyncClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  MeshSyncClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.SyncResponse> sync(
    $0.SyncRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sync, request, options: options);
  }

  $grpc.ResponseFuture<$0.AckEnvelope> pushEnvelope(
    $0.MeshEnvelope request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$pushEnvelope, request, options: options);
  }

  $grpc.ResponseStream<$0.MeshEnvelope> streamUpdates(
    $0.SyncRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$streamUpdates, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$sync = $grpc.ClientMethod<$0.SyncRequest, $0.SyncResponse>(
      '/delta.v1.MeshSync/Sync',
      ($0.SyncRequest value) => value.writeToBuffer(),
      $0.SyncResponse.fromBuffer);
  static final _$pushEnvelope =
      $grpc.ClientMethod<$0.MeshEnvelope, $0.AckEnvelope>(
          '/delta.v1.MeshSync/PushEnvelope',
          ($0.MeshEnvelope value) => value.writeToBuffer(),
          $0.AckEnvelope.fromBuffer);
  static final _$streamUpdates =
      $grpc.ClientMethod<$0.SyncRequest, $0.MeshEnvelope>(
          '/delta.v1.MeshSync/StreamUpdates',
          ($0.SyncRequest value) => value.writeToBuffer(),
          $0.MeshEnvelope.fromBuffer);
}

@$pb.GrpcServiceName('delta.v1.MeshSync')
abstract class MeshSyncServiceBase extends $grpc.Service {
  $core.String get $name => 'delta.v1.MeshSync';

  MeshSyncServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SyncRequest, $0.SyncResponse>(
        'Sync',
        sync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SyncRequest.fromBuffer(value),
        ($0.SyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MeshEnvelope, $0.AckEnvelope>(
        'PushEnvelope',
        pushEnvelope_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MeshEnvelope.fromBuffer(value),
        ($0.AckEnvelope value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SyncRequest, $0.MeshEnvelope>(
        'StreamUpdates',
        streamUpdates_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.SyncRequest.fromBuffer(value),
        ($0.MeshEnvelope value) => value.writeToBuffer()));
  }

  $async.Future<$0.SyncResponse> sync_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.SyncRequest> $request) async {
    return sync($call, await $request);
  }

  $async.Future<$0.SyncResponse> sync(
      $grpc.ServiceCall call, $0.SyncRequest request);

  $async.Future<$0.AckEnvelope> pushEnvelope_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.MeshEnvelope> $request) async {
    return pushEnvelope($call, await $request);
  }

  $async.Future<$0.AckEnvelope> pushEnvelope(
      $grpc.ServiceCall call, $0.MeshEnvelope request);

  $async.Stream<$0.MeshEnvelope> streamUpdates_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.SyncRequest> $request) async* {
    yield* streamUpdates($call, await $request);
  }

  $async.Stream<$0.MeshEnvelope> streamUpdates(
      $grpc.ServiceCall call, $0.SyncRequest request);
}
