// This is a generated file - do not edit.
//
// Generated from inventory.proto.

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

@$core.Deprecated('Use vectorClockDescriptor instead')
const VectorClock$json = {
  '1': 'VectorClock',
  '2': [
    {
      '1': 'clocks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.delta.v1.VectorClock.ClocksEntry',
      '10': 'clocks'
    },
  ],
  '3': [VectorClock_ClocksEntry$json],
};

@$core.Deprecated('Use vectorClockDescriptor instead')
const VectorClock_ClocksEntry$json = {
  '1': 'ClocksEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 4, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `VectorClock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vectorClockDescriptor = $convert.base64Decode(
    'CgtWZWN0b3JDbG9jaxI5CgZjbG9ja3MYASADKAsyIS5kZWx0YS52MS5WZWN0b3JDbG9jay5DbG'
    '9ja3NFbnRyeVIGY2xvY2tzGjkKC0Nsb2Nrc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZh'
    'bHVlGAIgASgEUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use nodeIdentityDescriptor instead')
const NodeIdentity$json = {
  '1': 'NodeIdentity',
  '2': [
    {'1': 'node_id', '3': 1, '4': 1, '5': 9, '10': 'nodeId'},
    {'1': 'region', '3': 2, '4': 1, '5': 9, '10': 'region'},
    {
      '1': 'type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.delta.v1.NodeIdentity.NodeType',
      '10': 'type'
    },
    {'1': 'pubkey_der', '3': 4, '4': 1, '5': 12, '10': 'pubkeyDer'},
  ],
  '4': [NodeIdentity_NodeType$json],
};

@$core.Deprecated('Use nodeIdentityDescriptor instead')
const NodeIdentity_NodeType$json = {
  '1': 'NodeType',
  '2': [
    {'1': 'VOLUNTEER', '2': 0},
    {'1': 'BOAT', '2': 1},
    {'1': 'DRONE', '2': 2},
    {'1': 'BASE_CAMP', '2': 3},
  ],
};

/// Descriptor for `NodeIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeIdentityDescriptor = $convert.base64Decode(
    'CgxOb2RlSWRlbnRpdHkSFwoHbm9kZV9pZBgBIAEoCVIGbm9kZUlkEhYKBnJlZ2lvbhgCIAEoCV'
    'IGcmVnaW9uEjMKBHR5cGUYAyABKA4yHy5kZWx0YS52MS5Ob2RlSWRlbnRpdHkuTm9kZVR5cGVS'
    'BHR5cGUSHQoKcHVia2V5X2RlchgEIAEoDFIJcHVia2V5RGVyIj0KCE5vZGVUeXBlEg0KCVZPTF'
    'VOVEVFUhAAEggKBEJPQVQQARIJCgVEUk9ORRACEg0KCUJBU0VfQ0FNUBAD');

@$core.Deprecated('Use supplyItemDescriptor instead')
const SupplyItem$json = {
  '1': 'SupplyItem',
  '2': [
    {'1': 'item_id', '3': 1, '4': 1, '5': 9, '10': 'itemId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 5, '10': 'quantity'},
    {'1': 'unit', '3': 4, '4': 1, '5': 9, '10': 'unit'},
    {'1': 'location_id', '3': 5, '4': 1, '5': 9, '10': 'locationId'},
    {'1': 'last_modified', '3': 6, '4': 1, '5': 9, '10': 'lastModified'},
    {'1': 'modified_by', '3': 7, '4': 1, '5': 9, '10': 'modifiedBy'},
    {
      '1': 'clock',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.delta.v1.VectorClock',
      '10': 'clock'
    },
    {'1': 'signature', '3': 9, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `SupplyItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List supplyItemDescriptor = $convert.base64Decode(
    'CgpTdXBwbHlJdGVtEhcKB2l0ZW1faWQYASABKAlSBml0ZW1JZBISCgRuYW1lGAIgASgJUgRuYW'
    '1lEhoKCHF1YW50aXR5GAMgASgFUghxdWFudGl0eRISCgR1bml0GAQgASgJUgR1bml0Eh8KC2xv'
    'Y2F0aW9uX2lkGAUgASgJUgpsb2NhdGlvbklkEiMKDWxhc3RfbW9kaWZpZWQYBiABKAlSDGxhc3'
    'RNb2RpZmllZBIfCgttb2RpZmllZF9ieRgHIAEoCVIKbW9kaWZpZWRCeRIrCgVjbG9jaxgIIAEo'
    'CzIVLmRlbHRhLnYxLlZlY3RvckNsb2NrUgVjbG9jaxIcCglzaWduYXR1cmUYCSABKAxSCXNpZ2'
    '5hdHVyZQ==');

@$core.Deprecated('Use inventoryStateDescriptor instead')
const InventoryState$json = {
  '1': 'InventoryState',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.delta.v1.SupplyItem',
      '10': 'items'
    },
    {'1': 'tombstone', '3': 2, '4': 3, '5': 9, '10': 'tombstone'},
    {
      '1': 'clock',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.delta.v1.VectorClock',
      '10': 'clock'
    },
    {'1': 'shard_id', '3': 4, '4': 1, '5': 9, '10': 'shardId'},
  ],
};

/// Descriptor for `InventoryState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inventoryStateDescriptor = $convert.base64Decode(
    'Cg5JbnZlbnRvcnlTdGF0ZRIqCgVpdGVtcxgBIAMoCzIULmRlbHRhLnYxLlN1cHBseUl0ZW1SBW'
    'l0ZW1zEhwKCXRvbWJzdG9uZRgCIAMoCVIJdG9tYnN0b25lEisKBWNsb2NrGAMgASgLMhUuZGVs'
    'dGEudjEuVmVjdG9yQ2xvY2tSBWNsb2NrEhkKCHNoYXJkX2lkGAQgASgJUgdzaGFyZElk');
