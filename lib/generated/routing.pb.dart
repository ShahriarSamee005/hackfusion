// This is a generated file - do not edit.
//
// Generated from routing.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'inventory.pb.dart' as $0;
import 'routing.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'routing.pbenum.dart';

class RouteEdge extends $pb.GeneratedMessage {
  factory RouteEdge({
    $core.String? fromNodeId,
    $core.String? toNodeId,
    $core.double? baseWeight,
    $core.double? decayWeight,
    $core.bool? passable,
    $core.double? floodDepthM,
  }) {
    final result = create();
    if (fromNodeId != null) result.fromNodeId = fromNodeId;
    if (toNodeId != null) result.toNodeId = toNodeId;
    if (baseWeight != null) result.baseWeight = baseWeight;
    if (decayWeight != null) result.decayWeight = decayWeight;
    if (passable != null) result.passable = passable;
    if (floodDepthM != null) result.floodDepthM = floodDepthM;
    return result;
  }

  RouteEdge._();

  factory RouteEdge.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RouteEdge.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RouteEdge',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromNodeId')
    ..aOS(2, _omitFieldNames ? '' : 'toNodeId')
    ..aD(3, _omitFieldNames ? '' : 'baseWeight', fieldType: $pb.PbFieldType.OF)
    ..aD(4, _omitFieldNames ? '' : 'decayWeight', fieldType: $pb.PbFieldType.OF)
    ..aOB(5, _omitFieldNames ? '' : 'passable')
    ..aD(6, _omitFieldNames ? '' : 'floodDepthM', fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteEdge clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteEdge copyWith(void Function(RouteEdge) updates) =>
      super.copyWith((message) => updates(message as RouteEdge)) as RouteEdge;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteEdge create() => RouteEdge._();
  @$core.override
  RouteEdge createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RouteEdge getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteEdge>(create);
  static RouteEdge? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromNodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromNodeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromNodeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set toNodeId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearToNodeId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get baseWeight => $_getN(2);
  @$pb.TagNumber(3)
  set baseWeight($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBaseWeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearBaseWeight() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get decayWeight => $_getN(3);
  @$pb.TagNumber(4)
  set decayWeight($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDecayWeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearDecayWeight() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get passable => $_getBF(4);
  @$pb.TagNumber(5)
  set passable($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPassable() => $_has(4);
  @$pb.TagNumber(5)
  void clearPassable() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get floodDepthM => $_getN(5);
  @$pb.TagNumber(6)
  set floodDepthM($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFloodDepthM() => $_has(5);
  @$pb.TagNumber(6)
  void clearFloodDepthM() => $_clearField(6);
}

class RouteRequest extends $pb.GeneratedMessage {
  factory RouteRequest({
    $core.String? originId,
    $core.String? destinationId,
    $core.Iterable<$core.String>? waypointIds,
    RouteRequest_VehicleConstraint? vehicle,
    RouteRequest_Priority? cargoPriority,
  }) {
    final result = create();
    if (originId != null) result.originId = originId;
    if (destinationId != null) result.destinationId = destinationId;
    if (waypointIds != null) result.waypointIds.addAll(waypointIds);
    if (vehicle != null) result.vehicle = vehicle;
    if (cargoPriority != null) result.cargoPriority = cargoPriority;
    return result;
  }

  RouteRequest._();

  factory RouteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RouteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RouteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'originId')
    ..aOS(2, _omitFieldNames ? '' : 'destinationId')
    ..pPS(3, _omitFieldNames ? '' : 'waypointIds')
    ..aE<RouteRequest_VehicleConstraint>(4, _omitFieldNames ? '' : 'vehicle',
        enumValues: RouteRequest_VehicleConstraint.values)
    ..aE<RouteRequest_Priority>(5, _omitFieldNames ? '' : 'cargoPriority',
        enumValues: RouteRequest_Priority.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteRequest copyWith(void Function(RouteRequest) updates) =>
      super.copyWith((message) => updates(message as RouteRequest))
          as RouteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteRequest create() => RouteRequest._();
  @$core.override
  RouteRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RouteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RouteRequest>(create);
  static RouteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get originId => $_getSZ(0);
  @$pb.TagNumber(1)
  set originId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOriginId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOriginId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get destinationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set destinationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDestinationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDestinationId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get waypointIds => $_getList(2);

  @$pb.TagNumber(4)
  RouteRequest_VehicleConstraint get vehicle => $_getN(3);
  @$pb.TagNumber(4)
  set vehicle(RouteRequest_VehicleConstraint value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVehicle() => $_has(3);
  @$pb.TagNumber(4)
  void clearVehicle() => $_clearField(4);

  @$pb.TagNumber(5)
  RouteRequest_Priority get cargoPriority => $_getN(4);
  @$pb.TagNumber(5)
  set cargoPriority(RouteRequest_Priority value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCargoPriority() => $_has(4);
  @$pb.TagNumber(5)
  void clearCargoPriority() => $_clearField(5);
}

class RouteResponse extends $pb.GeneratedMessage {
  factory RouteResponse({
    $core.Iterable<$core.String>? nodeIds,
    $core.double? totalCost,
    $core.double? etaMinutes,
    $core.double? decayRisk,
    $core.Iterable<RouteEdge>? edges,
    $0.VectorClock? clock,
  }) {
    final result = create();
    if (nodeIds != null) result.nodeIds.addAll(nodeIds);
    if (totalCost != null) result.totalCost = totalCost;
    if (etaMinutes != null) result.etaMinutes = etaMinutes;
    if (decayRisk != null) result.decayRisk = decayRisk;
    if (edges != null) result.edges.addAll(edges);
    if (clock != null) result.clock = clock;
    return result;
  }

  RouteResponse._();

  factory RouteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RouteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RouteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'delta.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'nodeIds')
    ..aD(2, _omitFieldNames ? '' : 'totalCost', fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'etaMinutes', fieldType: $pb.PbFieldType.OF)
    ..aD(4, _omitFieldNames ? '' : 'decayRisk', fieldType: $pb.PbFieldType.OF)
    ..pPM<RouteEdge>(5, _omitFieldNames ? '' : 'edges',
        subBuilder: RouteEdge.create)
    ..aOM<$0.VectorClock>(6, _omitFieldNames ? '' : 'clock',
        subBuilder: $0.VectorClock.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RouteResponse copyWith(void Function(RouteResponse) updates) =>
      super.copyWith((message) => updates(message as RouteResponse))
          as RouteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteResponse create() => RouteResponse._();
  @$core.override
  RouteResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RouteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RouteResponse>(create);
  static RouteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get nodeIds => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalCost => $_getN(1);
  @$pb.TagNumber(2)
  set totalCost($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCost() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCost() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get etaMinutes => $_getN(2);
  @$pb.TagNumber(3)
  set etaMinutes($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEtaMinutes() => $_has(2);
  @$pb.TagNumber(3)
  void clearEtaMinutes() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get decayRisk => $_getN(3);
  @$pb.TagNumber(4)
  set decayRisk($core.double value) => $_setFloat(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDecayRisk() => $_has(3);
  @$pb.TagNumber(4)
  void clearDecayRisk() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<RouteEdge> get edges => $_getList(4);

  @$pb.TagNumber(6)
  $0.VectorClock get clock => $_getN(5);
  @$pb.TagNumber(6)
  set clock($0.VectorClock value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasClock() => $_has(5);
  @$pb.TagNumber(6)
  void clearClock() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.VectorClock ensureClock() => $_ensure(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
