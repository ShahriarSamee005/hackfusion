// This is a generated file - do not edit.
//
// Generated from routing.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use routeEdgeDescriptor instead')
const RouteEdge$json = {
  '1': 'RouteEdge',
  '2': [
    {'1': 'from_node_id', '3': 1, '4': 1, '5': 9, '10': 'fromNodeId'},
    {'1': 'to_node_id', '3': 2, '4': 1, '5': 9, '10': 'toNodeId'},
    {'1': 'base_weight', '3': 3, '4': 1, '5': 2, '10': 'baseWeight'},
    {'1': 'decay_weight', '3': 4, '4': 1, '5': 2, '10': 'decayWeight'},
    {'1': 'passable', '3': 5, '4': 1, '5': 8, '10': 'passable'},
    {'1': 'flood_depth_m', '3': 6, '4': 1, '5': 2, '10': 'floodDepthM'},
  ],
};

/// Descriptor for `RouteEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeEdgeDescriptor = $convert.base64Decode(
    'CglSb3V0ZUVkZ2USIAoMZnJvbV9ub2RlX2lkGAEgASgJUgpmcm9tTm9kZUlkEhwKCnRvX25vZG'
    'VfaWQYAiABKAlSCHRvTm9kZUlkEh8KC2Jhc2Vfd2VpZ2h0GAMgASgCUgpiYXNlV2VpZ2h0EiEK'
    'DGRlY2F5X3dlaWdodBgEIAEoAlILZGVjYXlXZWlnaHQSGgoIcGFzc2FibGUYBSABKAhSCHBhc3'
    'NhYmxlEiIKDWZsb29kX2RlcHRoX20YBiABKAJSC2Zsb29kRGVwdGhN');

@$core.Deprecated('Use routeRequestDescriptor instead')
const RouteRequest$json = {
  '1': 'RouteRequest',
  '2': [
    {'1': 'origin_id', '3': 1, '4': 1, '5': 9, '10': 'originId'},
    {'1': 'destination_id', '3': 2, '4': 1, '5': 9, '10': 'destinationId'},
    {'1': 'waypoint_ids', '3': 3, '4': 3, '5': 9, '10': 'waypointIds'},
    {
      '1': 'vehicle',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.delta.v1.RouteRequest.VehicleConstraint',
      '10': 'vehicle'
    },
    {
      '1': 'cargo_priority',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.delta.v1.RouteRequest.Priority',
      '10': 'cargoPriority'
    },
  ],
  '4': [RouteRequest_Priority$json, RouteRequest_VehicleConstraint$json],
};

@$core.Deprecated('Use routeRequestDescriptor instead')
const RouteRequest_Priority$json = {
  '1': 'Priority',
  '2': [
    {'1': 'P0', '2': 0},
    {'1': 'P1', '2': 1},
    {'1': 'P2', '2': 2},
    {'1': 'P3', '2': 3},
  ],
};

@$core.Deprecated('Use routeRequestDescriptor instead')
const RouteRequest_VehicleConstraint$json = {
  '1': 'VehicleConstraint',
  '2': [
    {'1': 'ANY', '2': 0},
    {'1': 'BOAT_ONLY', '2': 1},
    {'1': 'DRONE_ONLY', '2': 2},
    {'1': 'FOOT', '2': 3},
  ],
};

/// Descriptor for `RouteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeRequestDescriptor = $convert.base64Decode(
    'CgxSb3V0ZVJlcXVlc3QSGwoJb3JpZ2luX2lkGAEgASgJUghvcmlnaW5JZBIlCg5kZXN0aW5hdG'
    'lvbl9pZBgCIAEoCVINZGVzdGluYXRpb25JZBIhCgx3YXlwb2ludF9pZHMYAyADKAlSC3dheXBv'
    'aW50SWRzEkIKB3ZlaGljbGUYBCABKA4yKC5kZWx0YS52MS5Sb3V0ZVJlcXVlc3QuVmVoaWNsZU'
    'NvbnN0cmFpbnRSB3ZlaGljbGUSRgoOY2FyZ29fcHJpb3JpdHkYBSABKA4yHy5kZWx0YS52MS5S'
    'b3V0ZVJlcXVlc3QuUHJpb3JpdHlSDWNhcmdvUHJpb3JpdHkiKgoIUHJpb3JpdHkSBgoCUDAQAB'
    'IGCgJQMRABEgYKAlAyEAISBgoCUDMQAyJFChFWZWhpY2xlQ29uc3RyYWludBIHCgNBTlkQABIN'
    'CglCT0FUX09OTFkQARIOCgpEUk9ORV9PTkxZEAISCAoERk9PVBAD');

@$core.Deprecated('Use routeResponseDescriptor instead')
const RouteResponse$json = {
  '1': 'RouteResponse',
  '2': [
    {'1': 'node_ids', '3': 1, '4': 3, '5': 9, '10': 'nodeIds'},
    {'1': 'total_cost', '3': 2, '4': 1, '5': 2, '10': 'totalCost'},
    {'1': 'eta_minutes', '3': 3, '4': 1, '5': 2, '10': 'etaMinutes'},
    {'1': 'decay_risk', '3': 4, '4': 1, '5': 2, '10': 'decayRisk'},
    {
      '1': 'edges',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.delta.v1.RouteEdge',
      '10': 'edges'
    },
    {
      '1': 'clock',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.delta.v1.VectorClock',
      '10': 'clock'
    },
  ],
};

/// Descriptor for `RouteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeResponseDescriptor = $convert.base64Decode(
    'Cg1Sb3V0ZVJlc3BvbnNlEhkKCG5vZGVfaWRzGAEgAygJUgdub2RlSWRzEh0KCnRvdGFsX2Nvc3'
    'QYAiABKAJSCXRvdGFsQ29zdBIfCgtldGFfbWludXRlcxgDIAEoAlIKZXRhTWludXRlcxIdCgpk'
    'ZWNheV9yaXNrGAQgASgCUglkZWNheVJpc2sSKQoFZWRnZXMYBSADKAsyEy5kZWx0YS52MS5Sb3'
    'V0ZUVkZ2VSBWVkZ2VzEisKBWNsb2NrGAYgASgLMhUuZGVsdGEudjEuVmVjdG9yQ2xvY2tSBWNs'
    'b2Nr');
