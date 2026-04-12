// This is a generated file - do not edit.
//
// Generated from mesh.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'inventory.pb.dart' as $1;
import 'pod.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class MeshEnvelope extends $pb.GeneratedMessage {
  factory MeshEnvelope({
    $core.String? envelopeId,
    $core.String? originId,
    $core.String? destId,
    $core.int? ttl,
    $core.List<$core.int>? ciphertext,
    $core.List<$core.int>? nonce,
    $core.List<$core.int>? authTag,
    $core.List<$core.int>? senderSig,
    $core.Iterable<$core.String>? hops,
  }) {
    final result = create();
    if (envelopeId != null) result.envelopeId = envelopeId;
    if (originId != null) result.originId = originId;
    if (destId != null) result.destId = destId;
    if (ttl != null) result.ttl = ttl;
    if (ciphertext != null) result.ciphertext = ciphertext;
    if (nonce != null) result.nonce = nonce;
    if (authTag != null) result.authTag = authTag;
    if (senderSig != null) result.senderSig = senderSig;
    if (hops != null) result.hops.addAll(hops);
    return result;
  }

  MeshEnvelope._();

  factory MeshEnvelope.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MeshEnvelope.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MeshEnvelope',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'envelopeId')
    ..aOS(2, _omitFieldNames ? '' : 'originId')
    ..aOS(3, _omitFieldNames ? '' : 'destId')
    ..aI(4, _omitFieldNames ? '' : 'ttl', fieldType: $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'ciphertext', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        6, _omitFieldNames ? '' : 'nonce', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'authTag', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        8, _omitFieldNames ? '' : 'senderSig', $pb.PbFieldType.OY)
    ..pPS(9, _omitFieldNames ? '' : 'hops')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MeshEnvelope clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MeshEnvelope copyWith(void Function(MeshEnvelope) updates) =>
      super.copyWith((message) => updates(message as MeshEnvelope))
          as MeshEnvelope;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MeshEnvelope create() => MeshEnvelope._();
  @$core.override
  MeshEnvelope createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MeshEnvelope getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MeshEnvelope>(create);
  static MeshEnvelope? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get envelopeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set envelopeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEnvelopeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnvelopeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get originId => $_getSZ(1);
  @$pb.TagNumber(2)
  set originId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOriginId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOriginId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get destId => $_getSZ(2);
  @$pb.TagNumber(3)
  set destId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDestId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDestId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get ttl => $_getIZ(3);
  @$pb.TagNumber(4)
  set ttl($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTtl() => $_has(3);
  @$pb.TagNumber(4)
  void clearTtl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get ciphertext => $_getN(4);
  @$pb.TagNumber(5)
  set ciphertext($core.List<$core.int> value) => $_setBytes(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCiphertext() => $_has(4);
  @$pb.TagNumber(5)
  void clearCiphertext() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get nonce => $_getN(5);
  @$pb.TagNumber(6)
  set nonce($core.List<$core.int> value) => $_setBytes(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNonce() => $_has(5);
  @$pb.TagNumber(6)
  void clearNonce() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.int> get authTag => $_getN(6);
  @$pb.TagNumber(7)
  set authTag($core.List<$core.int> value) => $_setBytes(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAuthTag() => $_has(6);
  @$pb.TagNumber(7)
  void clearAuthTag() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.int> get senderSig => $_getN(7);
  @$pb.TagNumber(8)
  set senderSig($core.List<$core.int> value) => $_setBytes(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSenderSig() => $_has(7);
  @$pb.TagNumber(8)
  void clearSenderSig() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get hops => $_getList(8);
}

class SyncRequest extends $pb.GeneratedMessage {
  factory SyncRequest({
    $core.String? requesterId,
    $1.VectorClock? have,
    $core.Iterable<$core.String>? shards,
  }) {
    final result = create();
    if (requesterId != null) result.requesterId = requesterId;
    if (have != null) result.have = have;
    if (shards != null) result.shards.addAll(shards);
    return result;
  }

  SyncRequest._();

  factory SyncRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requesterId')
    ..aOM<$1.VectorClock>(2, _omitFieldNames ? '' : 'have',
        subBuilder: $1.VectorClock.create)
    ..pPS(3, _omitFieldNames ? '' : 'shards')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncRequest copyWith(void Function(SyncRequest) updates) =>
      super.copyWith((message) => updates(message as SyncRequest))
          as SyncRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncRequest create() => SyncRequest._();
  @$core.override
  SyncRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SyncRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncRequest>(create);
  static SyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requesterId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requesterId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequesterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequesterId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.VectorClock get have => $_getN(1);
  @$pb.TagNumber(2)
  set have($1.VectorClock value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasHave() => $_has(1);
  @$pb.TagNumber(2)
  void clearHave() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.VectorClock ensureHave() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get shards => $_getList(2);
}

class SyncResponse extends $pb.GeneratedMessage {
  factory SyncResponse({
    $1.InventoryState? inventory,
    $core.Iterable<$2.ProofOfDelivery>? pods,
    $1.VectorClock? clock,
  }) {
    final result = create();
    if (inventory != null) result.inventory = inventory;
    if (pods != null) result.pods.addAll(pods);
    if (clock != null) result.clock = clock;
    return result;
  }

  SyncResponse._();

  factory SyncResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aOM<$1.InventoryState>(1, _omitFieldNames ? '' : 'inventory',
        subBuilder: $1.InventoryState.create)
    ..pPM<$2.ProofOfDelivery>(2, _omitFieldNames ? '' : 'pods',
        subBuilder: $2.ProofOfDelivery.create)
    ..aOM<$1.VectorClock>(3, _omitFieldNames ? '' : 'clock',
        subBuilder: $1.VectorClock.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncResponse copyWith(void Function(SyncResponse) updates) =>
      super.copyWith((message) => updates(message as SyncResponse))
          as SyncResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncResponse create() => SyncResponse._();
  @$core.override
  SyncResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SyncResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncResponse>(create);
  static SyncResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $1.InventoryState get inventory => $_getN(0);
  @$pb.TagNumber(1)
  set inventory($1.InventoryState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInventory() => $_has(0);
  @$pb.TagNumber(1)
  void clearInventory() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.InventoryState ensureInventory() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$2.ProofOfDelivery> get pods => $_getList(1);

  @$pb.TagNumber(3)
  $1.VectorClock get clock => $_getN(2);
  @$pb.TagNumber(3)
  set clock($1.VectorClock value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasClock() => $_has(2);
  @$pb.TagNumber(3)
  void clearClock() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.VectorClock ensureClock() => $_ensure(2);
}

class AckEnvelope extends $pb.GeneratedMessage {
  factory AckEnvelope({
    $core.String? envelopeId,
    $core.bool? accepted,
  }) {
    final result = create();
    if (envelopeId != null) result.envelopeId = envelopeId;
    if (accepted != null) result.accepted = accepted;
    return result;
  }

  AckEnvelope._();

  factory AckEnvelope.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AckEnvelope.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AckEnvelope',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'envelopeId')
    ..aOB(2, _omitFieldNames ? '' : 'accepted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AckEnvelope clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AckEnvelope copyWith(void Function(AckEnvelope) updates) =>
      super.copyWith((message) => updates(message as AckEnvelope))
          as AckEnvelope;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AckEnvelope create() => AckEnvelope._();
  @$core.override
  AckEnvelope createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AckEnvelope getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AckEnvelope>(create);
  static AckEnvelope? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get envelopeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set envelopeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEnvelopeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnvelopeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get accepted => $_getBF(1);
  @$pb.TagNumber(2)
  set accepted($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccepted() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccepted() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
