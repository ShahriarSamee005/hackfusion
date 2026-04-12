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

import 'package:protobuf/protobuf.dart' as $pb;

class NodeIdentity_NodeType extends $pb.ProtobufEnum {
  static const NodeIdentity_NodeType VOLUNTEER =
      NodeIdentity_NodeType._(0, _omitEnumNames ? '' : 'VOLUNTEER');
  static const NodeIdentity_NodeType BOAT =
      NodeIdentity_NodeType._(1, _omitEnumNames ? '' : 'BOAT');
  static const NodeIdentity_NodeType DRONE =
      NodeIdentity_NodeType._(2, _omitEnumNames ? '' : 'DRONE');
  static const NodeIdentity_NodeType BASE_CAMP =
      NodeIdentity_NodeType._(3, _omitEnumNames ? '' : 'BASE_CAMP');

  static const $core.List<NodeIdentity_NodeType> values =
      <NodeIdentity_NodeType>[
    VOLUNTEER,
    BOAT,
    DRONE,
    BASE_CAMP,
  ];

  static final $core.List<NodeIdentity_NodeType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static NodeIdentity_NodeType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const NodeIdentity_NodeType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
