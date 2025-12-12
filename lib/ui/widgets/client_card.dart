import 'package:eye_clinic/models/client.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final Client client;

  const ClientCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    // 1. Use LayoutBuilder to check the width of the CARD itself
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define breakpoints for hiding columns
        bool showDate = constraints.maxWidth > 800;
        bool showPhone = constraints.maxWidth > 600;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {}, // Handle click
              hoverColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Avatar with Initials
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          client.name.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Name and Diagnosis (Always Visible, takes remaining space)
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            client.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Prevents overflow
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              client.lensesType,
                              style: const TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis, // Prevents overflow
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Phone (Hidden on small screens)
                    if (showPhone) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Icon(Icons.phone_rounded, size: 18, color: Colors.grey[500]),
                            const SizedBox(width: 8),
                            // Flexible text to prevent crash
                            Flexible(
                              child: Text(
                                client.phone,
                                style: TextStyle(color: Colors.grey[700], fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Last Visit (Hidden on medium screens)
                    if (showDate) ...[
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اخر زيارة",
                              style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              client.lastVisit,
                              style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Action Button
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      color: Colors.grey[400],
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}