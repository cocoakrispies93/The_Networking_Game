import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LinkedInShareWidget extends StatefulWidget {
  final String shareText;
  final String? shareArticleUrl;

  const LinkedInShareWidget({
    super.key,
    required this.shareText,
    this.shareArticleUrl,
  });

  @override
  _LinkedInShareWidgetState createState() => _LinkedInShareWidgetState();
}

class _LinkedInShareWidgetState extends State<LinkedInShareWidget> {
  String? _uploadedImageUrl;

  var $mediaArtifact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Share on LinkedIn',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            await _shareContent();
          },
          child: const Text('Share'),
        ),
      ],
    );
  }

  Future<void> _shareContent() async {
    final accessToken = 'your_access_token_here';

    // Register the upload request
    final uploadUrlResponse = await http.post(
      'https://api.linkedin.com/v2/assets?action=registerUpload' as Uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode({
        'registerUploadRequest': {
          'recipes': ['urn:li:digitalmediaRecipe:feedshare-image'],
          'owner': 'urn:li:person:8675309',
          'serviceRelationships': [
            {
              'relationshipType': 'OWNER',
              'identifier': 'urn:li:userGeneratedContent'
            }
          ]
        }
      }),
    );

    final uploadUrlResponseJson = json.decode(uploadUrlResponse.body);
    final uploadUrl = uploadUrlResponseJson['value']['uploadMechanism']
            ['com.linkedin.digitalmedia.uploading.MediaUploadHttpRequest']
        ['uploadUrl'];

    final asset = uploadUrlResponseJson['value']['asset'];
    final mediaArtifact = uploadUrlResponseJson['value']['mediaArtifact']
        .replaceAll('(', '')
        .replaceAll(')', '')
        .split(',')[1];

    // Upload the image
    final fileBytes =
        await _getFileBytes(); // Method that returns the bytes of your image file
    final uploadResponse = await http.put(
      uploadUrl as Uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'image/jpeg',
      },
      body: fileBytes,
    );

    if (uploadResponse.statusCode != 200) {
      // Error uploading the image
      return;
    }

    // Get the uploaded image URL
    final getUploadedImageResponse = await http.get(
      'https://api.linkedin.com/v2/assets/$asset?fields=mediaArtifact' as Uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );

    final getUploadedImageResponseJson =
        json.decode(getUploadedImageResponse.body);
    _uploadedImageUrl = getUploadedImageResponseJson['mediaArtifact']
            [$mediaArtifact]['artifact']['fileProperties']['progressiveUrl']
        .toString();

    // Share the content
    final shareResponse = await http.post(
      'https://api.linkedin.com/v2/ugcPosts' as Uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode({
        'author': 'urn:li:person:8675309',
        'lifecycleState': 'PUBLISHED',
        'specificContent': {
          'com.linkedin.ugc.ShareContent': {
            'shareComment': widget.shareText,
            'shareMediaCategory': 'IMAGE',
            'media': [
              {
                'status': 'READY',
                'description': {'text': 'Shared from my Flutter app'},
                'media': _uploadedImageUrl ?? '',
              }
            ],
            'visibility': {
              'com.linkedin.ugc.MemberNetworkVisibility': 'PUBLIC'
            },
          },
        },
      }),
    );

    if (shareResponse.statusCode != 201) {
      // Error sharing the content
      return;
    }

// Success!
// Do something here, like show a success dialog or navigate to a success page.
  }

  Future<List<int>> _getFileBytes() async {
// Method that returns the bytes of your image file
    var ImageSource;
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    return file.readAsBytes() as Future<List<int>>;
  }
}

// CCOMPLETE =======================================================================================
class ImagePicker {
  getImage({required source}) {}
}
