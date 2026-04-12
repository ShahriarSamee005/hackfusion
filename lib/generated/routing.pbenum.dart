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

class RouteRequest_Priority extends $pb.ProtobufEnum {
  static const RouteRequest_Priority P0 =
      RouteRequest_Priority._(0, _omitEnumNames ? '' : 'P0');
  static const RouteRequest_Priority P1 =
      RouteRequest_Priority._(1, _omitEnumNames ? '' : 'P1');
  static const RouteRequest_Priority P2 =
      RouteRequest_Priority._(2, _omitEnumNames ? '' : 'P2');
  static const RouteRequest_Priority P3 =
      RouteRequest_Priority._(3, _omitEnumNames ? '' : 'P3');

  static const $core.List<RouteRequest_Priority> values =
      <RouteRequest_Priority>[
    P0,
    P1,
    P2,
    P3,
  ];

  static final $core.List<RouteRequest_Priority?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RouteRequest_Priority? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RouteRequest_Priority._(super.value, super.name);
}

class RouteRequest_VehicleConstraint extends $pb.ProtobufEnum {
  static const RouteRequest_VehicleConstraint ANY =
      RouteRequest_VehicleConstraint._(0, _omitEnumNames ? '' : 'ANY');
  static const RouteRequest_VehicleConstraint BOAT_ONLY =
      RouteRequest_VehicleConstraint._(1, _omitEnumNames ? '' : 'BOAT_ONLY');
  static const RouteRequest_VehicleConstraint DRONE_ONLY =
      RouteRequest_VehicleConstraint._(2, _omitEnumNames ? '' : 'DRONE_ONLY');
  static const RouteRequest_VehicleConstraint FOOT =
      RouteRequest_VehicleConstraint._(3, _omitEnumNames ? '' : 'FOOT');

  static const $core.List<RouteRequest_VehicleConstraint> values =
      <RouteRequest_VehicleConstraint>[
    ANY,
    BOAT_ONLY,
    DRONE_ONLY,
    FOOT,
  ];

  static final $core.List<RouteRequest_VehicleConstraint?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RouteRequest_VehicleConstraint? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RouteRequest_VehicleConstraint._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
