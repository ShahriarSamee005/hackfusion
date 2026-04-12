// This is a generated file - do not edit.
//
// Generated from pod.proto.

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

@$core.Deprecated('Use geoPointDescriptor instead')
const GeoPoint$json = {
  '1': 'GeoPoint',
  '2': [
    {'1': 'lat', '3': 1, '4': 1, '5': 1, '10': 'lat'},
    {'1': 'lng', '3': 2, '4': 1, '5': 1, '10': 'lng'},
    {'1': 'alt', '3': 3, '4': 1, '5': 2, '10': 'alt'},
  ],
};

/// Descriptor for `GeoPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List geoPointDescriptor = $convert.base64Decode(
    'CghHZW9Qb2ludBIQCgNsYXQYASABKAFSA2xhdBIQCgNsbmcYAiABKAFSA2xuZxIQCgNhbHQYAy'
    'ABKAJSA2FsdA==');

@$core.Deprecated('Use proofOfDeliveryDescriptor instead')
const ProofOfDelivery$json = {
  '1': 'ProofOfDelivery',
  '2': [
    {'1': 'pod_id', '3': 1, '4': 1, '5': 9, '10': 'podId'},
    {'1': 'route_id', '3': 2, '4': 1, '5': 9, '10': 'routeId'},
    {'1': 'sender_id', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'receiver_id', '3': 4, '4': 1, '5': 9, '10': 'receiverId'},
    {
      '1': 'items',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.delta.v1.SupplyItem',
      '10': 'items'
    },
    {
      '1': 'location',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.delta.v1.GeoPoint',
      '10': 'location'
    },
    {'1': 'delivered_at', '3': 7, '4': 1, '5': 9, '10': 'deliveredAt'},
    {'1': 'totp_challenge', '3': 8, '4': 1, '5': 9, '10': 'totpChallenge'},
    {'1': 'totp_response', '3': 9, '4': 1, '5': 9, '10': 'totpResponse'},
    {'1': 'sender_sig', '3': 10, '4': 1, '5': 12, '10': 'senderSig'},
    {'1': 'receiver_sig', '3': 11, '4': 1, '5': 12, '10': 'receiverSig'},
    {'1': 'payload_hash', '3': 12, '4': 1, '5': 12, '10': 'payloadHash'},
  ],
};

/// Descriptor for `ProofOfDelivery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List proofOfDeliveryDescriptor = $convert.base64Decode(
    'Cg9Qcm9vZk9mRGVsaXZlcnkSFQoGcG9kX2lkGAEgASgJUgVwb2RJZBIZCghyb3V0ZV9pZBgCIA'
    'EoCVIHcm91dGVJZBIbCglzZW5kZXJfaWQYAyABKAlSCHNlbmRlcklkEh8KC3JlY2VpdmVyX2lk'
    'GAQgASgJUgpyZWNlaXZlcklkEioKBWl0ZW1zGAUgAygLMhQuZGVsdGEudjEuU3VwcGx5SXRlbV'
    'IFaXRlbXMSLgoIbG9jYXRpb24YBiABKAsyEi5kZWx0YS52MS5HZW9Qb2ludFIIbG9jYXRpb24S'
    'IQoMZGVsaXZlcmVkX2F0GAcgASgJUgtkZWxpdmVyZWRBdBIlCg50b3RwX2NoYWxsZW5nZRgIIA'
    'EoCVINdG90cENoYWxsZW5nZRIjCg10b3RwX3Jlc3BvbnNlGAkgASgJUgx0b3RwUmVzcG9uc2US'
    'HQoKc2VuZGVyX3NpZxgKIAEoDFIJc2VuZGVyU2lnEiEKDHJlY2VpdmVyX3NpZxgLIAEoDFILcm'
    'VjZWl2ZXJTaWcSIQoMcGF5bG9hZF9oYXNoGAwgASgMUgtwYXlsb2FkSGFzaA==');
