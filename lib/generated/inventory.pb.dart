// This is a generated file - do not edit.
//
// Generated from inventory.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'inventory.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'inventory.pbenum.dart';

class VectorClock extends $pb.GeneratedMessage {
  factory VectorClock({
    $core.Iterable<$core.MapEntry<$core.String, $fixnum.Int64>>? clocks,
  }) {
    final result = create();
    if (clocks != null) result.clocks.addEntries(clocks);
    return result;
  }

  VectorClock._();

  factory VectorClock.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VectorClock.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VectorClock',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..m<$core.String, $fixnum.Int64>(1, _omitFieldNames ? '' : 'clocks',
        entryClassName: 'VectorClock.ClocksEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OU6,
        packageName: const $pb.PackageName('delta.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorClock clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorClock copyWith(void Function(VectorClock) updates) =>
      super.copyWith((message) => updates(message as VectorClock))
          as VectorClock;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VectorClock create() => VectorClock._();
  @$core.override
  VectorClock createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VectorClock getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VectorClock>(create);
  static VectorClock? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $fixnum.Int64> get clocks => $_getMap(0);
}

class NodeIdentity extends $pb.GeneratedMessage {
  factory NodeIdentity({
    $core.String? nodeId,
    $core.String? region,
    NodeIdentity_NodeType? type,
    $core.List<$core.int>? pubkeyDer,
  }) {
    final result = create();
    if (nodeId != null) result.nodeId = nodeId;
    if (region != null) result.region = region;
    if (type != null) result.type = type;
    if (pubkeyDer != null) result.pubkeyDer = pubkeyDer;
    return result;
  }

  NodeIdentity._();

  factory NodeIdentity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NodeIdentity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NodeIdentity',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodeId')
    ..aOS(2, _omitFieldNames ? '' : 'region')
    ..aE<NodeIdentity_NodeType>(3, _omitFieldNames ? '' : 'type',
        enumValues: NodeIdentity_NodeType.values)
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'pubkeyDer', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NodeIdentity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NodeIdentity copyWith(void Function(NodeIdentity) updates) =>
      super.copyWith((message) => updates(message as NodeIdentity))
          as NodeIdentity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeIdentity create() => NodeIdentity._();
  @$core.override
  NodeIdentity createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NodeIdentity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NodeIdentity>(create);
  static NodeIdentity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get region => $_getSZ(1);
  @$pb.TagNumber(2)
  set region($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRegion() => $_has(1);
  @$pb.TagNumber(2)
  void clearRegion() => $_clearField(2);

  @$pb.TagNumber(3)
  NodeIdentity_NodeType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(NodeIdentity_NodeType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get pubkeyDer => $_getN(3);
  @$pb.TagNumber(4)
  set pubkeyDer($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPubkeyDer() => $_has(3);
  @$pb.TagNumber(4)
  void clearPubkeyDer() => $_clearField(4);
}

class SupplyItem extends $pb.GeneratedMessage {
  factory SupplyItem({
    $core.String? itemId,
    $core.String? name,
    $core.int? quantity,
    $core.String? unit,
    $core.String? locationId,
    $core.String? lastModified,
    $core.String? modifiedBy,
    VectorClock? clock,
    $core.List<$core.int>? signature,
  }) {
    final result = create();
    if (itemId != null) result.itemId = itemId;
    if (name != null) result.name = name;
    if (quantity != null) result.quantity = quantity;
    if (unit != null) result.unit = unit;
    if (locationId != null) result.locationId = locationId;
    if (lastModified != null) result.lastModified = lastModified;
    if (modifiedBy != null) result.modifiedBy = modifiedBy;
    if (clock != null) result.clock = clock;
    if (signature != null) result.signature = signature;
    return result;
  }

  SupplyItem._();

  factory SupplyItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SupplyItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SupplyItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'itemId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aI(3, _omitFieldNames ? '' : 'quantity')
    ..aOS(4, _omitFieldNames ? '' : 'unit')
    ..aOS(5, _omitFieldNames ? '' : 'locationId')
    ..aOS(6, _omitFieldNames ? '' : 'lastModified')
    ..aOS(7, _omitFieldNames ? '' : 'modifiedBy')
    ..aOM<VectorClock>(8, _omitFieldNames ? '' : 'clock',
        subBuilder: VectorClock.create)
    ..a<$core.List<$core.int>>(
        9, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupplyItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SupplyItem copyWith(void Function(SupplyItem) updates) =>
      super.copyWith((message) => updates(message as SupplyItem)) as SupplyItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SupplyItem create() => SupplyItem._();
  @$core.override
  SupplyItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SupplyItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SupplyItem>(create);
  static SupplyItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get itemId => $_getSZ(0);
  @$pb.TagNumber(1)
  set itemId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasItemId() => $_has(0);
  @$pb.TagNumber(1)
  void clearItemId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get quantity => $_getIZ(2);
  @$pb.TagNumber(3)
  set quantity($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get unit => $_getSZ(3);
  @$pb.TagNumber(4)
  set unit($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUnit() => $_has(3);
  @$pb.TagNumber(4)
  void clearUnit() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get locationId => $_getSZ(4);
  @$pb.TagNumber(5)
  set locationId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLocationId() => $_has(4);
  @$pb.TagNumber(5)
  void clearLocationId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get lastModified => $_getSZ(5);
  @$pb.TagNumber(6)
  set lastModified($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLastModified() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastModified() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get modifiedBy => $_getSZ(6);
  @$pb.TagNumber(7)
  set modifiedBy($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasModifiedBy() => $_has(6);
  @$pb.TagNumber(7)
  void clearModifiedBy() => $_clearField(7);

  @$pb.TagNumber(8)
  VectorClock get clock => $_getN(7);
  @$pb.TagNumber(8)
  set clock(VectorClock value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasClock() => $_has(7);
  @$pb.TagNumber(8)
  void clearClock() => $_clearField(8);
  @$pb.TagNumber(8)
  VectorClock ensureClock() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.List<$core.int> get signature => $_getN(8);
  @$pb.TagNumber(9)
  set signature($core.List<$core.int> value) => $_setBytes(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSignature() => $_has(8);
  @$pb.TagNumber(9)
  void clearSignature() => $_clearField(9);
}

class InventoryState extends $pb.GeneratedMessage {
  factory InventoryState({
    $core.Iterable<SupplyItem>? items,
    $core.Iterable<$core.String>? tombstone,
    VectorClock? clock,
    $core.String? shardId,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (tombstone != null) result.tombstone.addAll(tombstone);
    if (clock != null) result.clock = clock;
    if (shardId != null) result.shardId = shardId;
    return result;
  }

  InventoryState._();

  factory InventoryState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InventoryState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InventoryState',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..pPM<SupplyItem>(1, _omitFieldNames ? '' : 'items',
        subBuilder: SupplyItem.create)
    ..pPS(2, _omitFieldNames ? '' : 'tombstone')
    ..aOM<VectorClock>(3, _omitFieldNames ? '' : 'clock',
        subBuilder: VectorClock.create)
    ..aOS(4, _omitFieldNames ? '' : 'shardId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InventoryState copyWith(void Function(InventoryState) updates) =>
      super.copyWith((message) => updates(message as InventoryState))
          as InventoryState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InventoryState create() => InventoryState._();
  @$core.override
  InventoryState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InventoryState getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InventoryState>(create);
  static InventoryState? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SupplyItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get tombstone => $_getList(1);

  @$pb.TagNumber(3)
  VectorClock get clock => $_getN(2);
  @$pb.TagNumber(3)
  set clock(VectorClock value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasClock() => $_has(2);
  @$pb.TagNumber(3)
  void clearClock() => $_clearField(3);
  @$pb.TagNumber(3)
  VectorClock ensureClock() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get shardId => $_getSZ(3);
  @$pb.TagNumber(4)
  set shardId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasShardId() => $_has(3);
  @$pb.TagNumber(4)
  void clearShardId() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
