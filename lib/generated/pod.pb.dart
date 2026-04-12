// This is a generated file - do not edit.
//
// Generated from pod.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'inventory.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GeoPoint extends $pb.GeneratedMessage {
  factory GeoPoint({
    $core.double? lat,
    $core.double? lng,
    $core.double? alt,
  }) {
    final result = create();
    if (lat != null) result.lat = lat;
    if (lng != null) result.lng = lng;
    if (alt != null) result.alt = alt;
    return result;
  }

  GeoPoint._();

  factory GeoPoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GeoPoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GeoPoint',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'lat')
    ..aD(2, _omitFieldNames ? '' : 'lng')
    ..aD(3, _omitFieldNames ? '' : 'alt', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeoPoint clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeoPoint copyWith(void Function(GeoPoint) updates) =>
      super.copyWith((message) => updates(message as GeoPoint)) as GeoPoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeoPoint create() => GeoPoint._();
  @$core.override
  GeoPoint createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GeoPoint getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GeoPoint>(create);
  static GeoPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get lat => $_getN(0);
  @$pb.TagNumber(1)
  set lat($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLat() => $_has(0);
  @$pb.TagNumber(1)
  void clearLat() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get lng => $_getN(1);
  @$pb.TagNumber(2)
  set lng($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLng() => $_has(1);
  @$pb.TagNumber(2)
  void clearLng() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get alt => $_getN(2);
  @$pb.TagNumber(3)
  set alt($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAlt() => $_has(2);
  @$pb.TagNumber(3)
  void clearAlt() => $_clearField(3);
}

class ProofOfDelivery extends $pb.GeneratedMessage {
  factory ProofOfDelivery({
    $core.String? podId,
    $core.String? routeId,
    $core.String? senderId,
    $core.String? receiverId,
    $core.Iterable<$0.SupplyItem>? items,
    GeoPoint? location,
    $core.String? deliveredAt,
    $core.String? totpChallenge,
    $core.String? totpResponse,
    $core.List<$core.int>? senderSig,
    $core.List<$core.int>? receiverSig,
    $core.List<$core.int>? payloadHash,
  }) {
    final result = create();
    if (podId != null) result.podId = podId;
    if (routeId != null) result.routeId = routeId;
    if (senderId != null) result.senderId = senderId;
    if (receiverId != null) result.receiverId = receiverId;
    if (items != null) result.items.addAll(items);
    if (location != null) result.location = location;
    if (deliveredAt != null) result.deliveredAt = deliveredAt;
    if (totpChallenge != null) result.totpChallenge = totpChallenge;
    if (totpResponse != null) result.totpResponse = totpResponse;
    if (senderSig != null) result.senderSig = senderSig;
    if (receiverSig != null) result.receiverSig = receiverSig;
    if (payloadHash != null) result.payloadHash = payloadHash;
    return result;
  }

  ProofOfDelivery._();

  factory ProofOfDelivery.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProofOfDelivery.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProofOfDelivery',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'podId')
    ..aOS(2, _omitFieldNames ? '' : 'routeId')
    ..aOS(3, _omitFieldNames ? '' : 'senderId')
    ..aOS(4, _omitFieldNames ? '' : 'receiverId')
    ..pPM<$0.SupplyItem>(5, _omitFieldNames ? '' : 'items',
        subBuilder: $0.SupplyItem.create)
    ..aOM<GeoPoint>(6, _omitFieldNames ? '' : 'location',
        subBuilder: GeoPoint.create)
    ..aOS(7, _omitFieldNames ? '' : 'deliveredAt')
    ..aOS(8, _omitFieldNames ? '' : 'totpChallenge')
    ..aOS(9, _omitFieldNames ? '' : 'totpResponse')
    ..a<$core.List<$core.int>>(
        10, _omitFieldNames ? '' : 'senderSig', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        11, _omitFieldNames ? '' : 'receiverSig', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        12, _omitFieldNames ? '' : 'payloadHash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProofOfDelivery clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProofOfDelivery copyWith(void Function(ProofOfDelivery) updates) =>
      super.copyWith((message) => updates(message as ProofOfDelivery))
          as ProofOfDelivery;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProofOfDelivery create() => ProofOfDelivery._();
  @$core.override
  ProofOfDelivery createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ProofOfDelivery getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProofOfDelivery>(create);
  static ProofOfDelivery? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get podId => $_getSZ(0);
  @$pb.TagNumber(1)
  set podId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPodId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPodId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get routeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set routeId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRouteId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRouteId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get receiverId => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiverId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReceiverId() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverId() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$0.SupplyItem> get items => $_getList(4);

  @$pb.TagNumber(6)
  GeoPoint get location => $_getN(5);
  @$pb.TagNumber(6)
  set location(GeoPoint value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLocation() => $_has(5);
  @$pb.TagNumber(6)
  void clearLocation() => $_clearField(6);
  @$pb.TagNumber(6)
  GeoPoint ensureLocation() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.String get deliveredAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set deliveredAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDeliveredAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeliveredAt() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get totpChallenge => $_getSZ(7);
  @$pb.TagNumber(8)
  set totpChallenge($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotpChallenge() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotpChallenge() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get totpResponse => $_getSZ(8);
  @$pb.TagNumber(9)
  set totpResponse($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTotpResponse() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotpResponse() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.int> get senderSig => $_getN(9);
  @$pb.TagNumber(10)
  set senderSig($core.List<$core.int> value) => $_setBytes(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSenderSig() => $_has(9);
  @$pb.TagNumber(10)
  void clearSenderSig() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.int> get receiverSig => $_getN(10);
  @$pb.TagNumber(11)
  set receiverSig($core.List<$core.int> value) => $_setBytes(10, value);
  @$pb.TagNumber(11)
  $core.bool hasReceiverSig() => $_has(10);
  @$pb.TagNumber(11)
  void clearReceiverSig() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.List<$core.int> get payloadHash => $_getN(11);
  @$pb.TagNumber(12)
  set payloadHash($core.List<$core.int> value) => $_setBytes(11, value);
  @$pb.TagNumber(12)
  $core.bool hasPayloadHash() => $_has(11);
  @$pb.TagNumber(12)
  void clearPayloadHash() => $_clearField(12);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
