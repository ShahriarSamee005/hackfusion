// This is a generated file - do not edit.
//
// Generated from mesh.proto.

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

@$core.Deprecated('Use meshEnvelopeDescriptor instead')
const MeshEnvelope$json = {
  '1': 'MeshEnvelope',
  '2': [
    {'1': 'envelope_id', '3': 1, '4': 1, '5': 9, '10': 'envelopeId'},
    {'1': 'origin_id', '3': 2, '4': 1, '5': 9, '10': 'originId'},
    {'1': 'dest_id', '3': 3, '4': 1, '5': 9, '10': 'destId'},
    {'1': 'ttl', '3': 4, '4': 1, '5': 13, '10': 'ttl'},
    {'1': 'ciphertext', '3': 5, '4': 1, '5': 12, '10': 'ciphertext'},
    {'1': 'nonce', '3': 6, '4': 1, '5': 12, '10': 'nonce'},
    {'1': 'auth_tag', '3': 7, '4': 1, '5': 12, '10': 'authTag'},
    {'1': 'sender_sig', '3': 8, '4': 1, '5': 12, '10': 'senderSig'},
    {'1': 'hops', '3': 9, '4': 3, '5': 9, '10': 'hops'},
  ],
};

/// Descriptor for `MeshEnvelope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List meshEnvelopeDescriptor = $convert.base64Decode(
    'CgxNZXNoRW52ZWxvcGUSHwoLZW52ZWxvcGVfaWQYASABKAlSCmVudmVsb3BlSWQSGwoJb3JpZ2'
    'luX2lkGAIgASgJUghvcmlnaW5JZBIXCgdkZXN0X2lkGAMgASgJUgZkZXN0SWQSEAoDdHRsGAQg'
    'ASgNUgN0dGwSHgoKY2lwaGVydGV4dBgFIAEoDFIKY2lwaGVydGV4dBIUCgVub25jZRgGIAEoDF'
    'IFbm9uY2USGQoIYXV0aF90YWcYByABKAxSB2F1dGhUYWcSHQoKc2VuZGVyX3NpZxgIIAEoDFIJ'
    'c2VuZGVyU2lnEhIKBGhvcHMYCSADKAlSBGhvcHM=');

@$core.Deprecated('Use syncRequestDescriptor instead')
const SyncRequest$json = {
  '1': 'SyncRequest',
  '2': [
    {'1': 'requester_id', '3': 1, '4': 1, '5': 9, '10': 'requesterId'},
    {
      '1': 'have',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.delta.v1.VectorClock',
      '10': 'have'
    },
    {'1': 'shards', '3': 3, '4': 3, '5': 9, '10': 'shards'},
  ],
};

/// Descriptor for `SyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncRequestDescriptor = $convert.base64Decode(
    'CgtTeW5jUmVxdWVzdBIhCgxyZXF1ZXN0ZXJfaWQYASABKAlSC3JlcXVlc3RlcklkEikKBGhhdm'
    'UYAiABKAsyFS5kZWx0YS52MS5WZWN0b3JDbG9ja1IEaGF2ZRIWCgZzaGFyZHMYAyADKAlSBnNo'
    'YXJkcw==');

@$core.Deprecated('Use syncResponseDescriptor instead')
const SyncResponse$json = {
  '1': 'SyncResponse',
  '2': [
    {
      '1': 'inventory',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.delta.v1.InventoryState',
      '10': 'inventory'
    },
    {
      '1': 'pods',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.delta.v1.ProofOfDelivery',
      '10': 'pods'
    },
    {
      '1': 'clock',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.delta.v1.VectorClock',
      '10': 'clock'
    },
  ],
};

/// Descriptor for `SyncResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncResponseDescriptor = $convert.base64Decode(
    'CgxTeW5jUmVzcG9uc2USNgoJaW52ZW50b3J5GAEgASgLMhguZGVsdGEudjEuSW52ZW50b3J5U3'
    'RhdGVSCWludmVudG9yeRItCgRwb2RzGAIgAygLMhkuZGVsdGEudjEuUHJvb2ZPZkRlbGl2ZXJ5'
    'UgRwb2RzEisKBWNsb2NrGAMgASgLMhUuZGVsdGEudjEuVmVjdG9yQ2xvY2tSBWNsb2Nr');

@$core.Deprecated('Use ackEnvelopeDescriptor instead')
const AckEnvelope$json = {
  '1': 'AckEnvelope',
  '2': [
    {'1': 'envelope_id', '3': 1, '4': 1, '5': 9, '10': 'envelopeId'},
    {'1': 'accepted', '3': 2, '4': 1, '5': 8, '10': 'accepted'},
  ],
};

/// Descriptor for `AckEnvelope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ackEnvelopeDescriptor = $convert.base64Decode(
    'CgtBY2tFbnZlbG9wZRIfCgtlbnZlbG9wZV9pZBgBIAEoCVIKZW52ZWxvcGVJZBIaCghhY2NlcH'
    'RlZBgCIAEoCFIIYWNjZXB0ZWQ=');
