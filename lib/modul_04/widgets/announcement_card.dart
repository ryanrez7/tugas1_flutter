import 'package:flutter/material.dart';

import '../models/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.announcement,
    required this.onTap,
  });

  final Announcement announcement;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(announcement.category),
                    backgroundColor: warna.primaryContainer,
                    labelStyle: TextStyle(
                      color: warna.onPrimaryContainer,
                      fontSize: 12,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  Text(
                    announcement.date,
                    style: TextStyle(color: warna.outline, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                announcement.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                announcement.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: warna.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
