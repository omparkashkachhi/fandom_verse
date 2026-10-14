import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'widgets/quick_prompt_chip.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final List<Map<String, String>> _messages = [
    {
      'sender': 'ai',
      'text':
      'Hello! I am your Fandom AI Assistant. Ask me anything about your favorite shows, lore, merchandise, or trivia!'
    }
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isTyping = false;
  int _selectedPromptIndex = -1;

  final List<Map<String, dynamic>> _quickPrompts = const [
    {'label': 'Top Anime Gear', 'icon': Icons.local_fire_department_rounded},
    {'label': 'Lore & Trivia', 'icon': Icons.auto_stories_rounded},
    {'label': 'Upcoming Drops', 'icon': Icons.calendar_today_rounded},
    {'label': 'Order Tracking', 'icon': Icons.local_shipping_rounded},
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage({String? customText}) {
    final textToSend = customText ?? _controller.text.trim();
    if (textToSend.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': textToSend});
      if (customText == null) _controller.clear();
      _isTyping = true;
      _selectedPromptIndex = -1;
    });

    _scrollToBottom();

    // Simulated / Integrated Smart AI Response Delay
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;

      String aiResponse =
          'That sounds awesome! I searched the Fandom database for "$textToSend" and found exciting merchandise and community insights!';

      if (textToSend.toLowerCase().contains('gear') ||
          textToSend.toLowerCase().contains('anime')) {
        aiResponse =
        'Check out our trending Galaxy Hoodies and Custom Gaming Shirts in the Fandom Store!';
      } else if (textToSend.toLowerCase().contains('order') ||
          textToSend.toLowerCase().contains('tracking')) {
        aiResponse =
        'You can track your active fandom orders directly in your Profile > Order History section.';
      } else if (textToSend.toLowerCase().contains('lore') ||
          textToSend.toLowerCase().contains('trivia')) {
        aiResponse =
        'Did you know? The Fandom Universe started as a small community hub before expanding into multi-platform gaming and collectibles!';
      }

      setState(() {
        _isTyping = false;
        _messages.add({'sender': 'ai', 'text': aiResponse});
      });

      _scrollToBottom();
    });
  }

  /// Handles incoming responses from the Advanced QuickPromptChip
  void _handleAIResponseFromChip(String responseText, String promptLabel) {
    setState(() {
      _messages.add({'sender': 'user', 'text': promptLabel});
      _messages.add({'sender': 'ai', 'text': responseText});
    });
    _scrollToBottom();
  }

  void _clearChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.white12),
        ),
        title: const Text(
          'Clear Conversation?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'This will remove all current messages from your session history.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC4899),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              setState(() {
                _messages.clear();
                _messages.add({
                  'sender': 'ai',
                  'text': 'Chat cleared! How else can I assist you today?'
                });
              });
              Navigator.pop(context);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.background,

        // ================= APP BAR =================
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.18),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.cyan.withOpacity(0.4)),
                ),
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: Colors.cyan,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fandom AI Helper',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: Color(0xFF10B981),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Online',
                        style: TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Clear Chat',
              onPressed: _clearChat,
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.white70,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),

        // ================= BODY =================
        body: SafeArea(
          child: Column(
            children: [
              // Chat List Section
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message['sender'] == 'user';

                    return Align(
                      alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.78,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isUser
                              ? const Color(0xFF8B5CF6)
                              : AppColors.cardBg,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isUser ? 16 : 4),
                            bottomRight: Radius.circular(isUser ? 4 : 16),
                          ),
                          border: Border.all(
                            color: isUser
                                ? const Color(0xFF8B5CF6)
                                : Colors.white12,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isUser
                                  ? const Color(0xFF8B5CF6).withOpacity(0.25)
                                  : Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          message['text']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.35,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Dynamic Typing Indicator Animation
              if (_isTyping)
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.cyan,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'AI is typing...',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 6),

              // ================= QUICK PROMPT CHIPS (Advanced Integrated) =================
              SizedBox(
                height: 42,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _quickPrompts.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final item = _quickPrompts[index];
                    final label = item['label'] as String;

                    return QuickPromptChip(
                      label: label,
                      icon: item['icon'],
                      isSelected: _selectedPromptIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedPromptIndex = index;
                        });
                      },
                      onAIResponseReceived: (aiResponse) {
                        _handleAIResponseFromChip(aiResponse, label);
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // ================= INPUT BAR =================
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  top: 4,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 14),
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                        decoration: InputDecoration(
                          hintText: 'Ask Fandom AI...',
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          filled: true,
                          fillColor: AppColors.cardBg,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.cyan),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.cyan,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyanAccent,
                            blurRadius: 10,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () => _sendMessage(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}