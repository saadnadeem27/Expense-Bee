import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/theme/app_theme.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  String _currency = 'USD';
  String _language = 'English';
  String _userName = 'John Doe';
  String _userEmail = 'john.doe@example.com';
  String _userPhone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      const SizedBox(height: 20),
                      _buildProfileHeader(),
                      const SizedBox(height: 24),
                      _buildQuickStats(),
                      const SizedBox(height: 24),
                      _buildSettingsSection(),
                      const SizedBox(height: 24),
                      _buildAccountSection(),
                      const SizedBox(height: 24),
                      _buildSupportSection(),
                      const SizedBox(height: 100), // Bottom padding for nav bar
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.darkBlue.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppTheme.darkBlue,
            size: 20,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () => _showSettingsDialog(),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkBlue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.settings,
                color: AppTheme.darkBlue,
                size: 20,
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Row(
              children: [
                const SizedBox(width: 40), // Space for back button
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Profile',
                        style: AppTheme.headingLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage your account and preferences',
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40), // Space for settings button
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: AppTheme.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _showEditProfileDialog(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.success,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _userName,
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _userEmail,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.softGray,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: AppTheme.goldGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Premium Member',
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total Transactions',
              '247',
              Icons.receipt_long,
              AppTheme.primaryBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'This Month',
              '\$2,340',
              Icons.trending_up,
              AppTheme.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Savings Goal',
              '68%',
              Icons.savings,
              AppTheme.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTheme.headingSmall.copyWith(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.softGray,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Preferences',
              style: AppTheme.headingMedium.copyWith(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildSettingsItem(
            'Dark Mode',
            'Switch to dark theme',
            Icons.dark_mode,
            AppTheme.darkBlue,
            Switch(
              value: _darkMode,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
              activeColor: AppTheme.primaryBlue,
            ),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'Notifications',
            'Enable push notifications',
            Icons.notifications,
            AppTheme.warning,
            Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: AppTheme.primaryBlue,
            ),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'Biometric Lock',
            'Use fingerprint or face ID',
            Icons.fingerprint,
            AppTheme.success,
            Switch(
              value: _biometricEnabled,
              onChanged: (value) {
                setState(() {
                  _biometricEnabled = value;
                });
              },
              activeColor: AppTheme.primaryBlue,
            ),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'Currency',
            _currency,
            Icons.attach_money,
            AppTheme.primaryBlue,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showCurrencyDialog(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'Language',
            _language,
            Icons.language,
            AppTheme.primaryBlue,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showLanguageDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Account',
              style: AppTheme.headingMedium.copyWith(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildSettingsItem(
            'Export Data',
            'Download your transaction data',
            Icons.download,
            AppTheme.primaryBlue,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showExportDialog(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'Backup & Sync',
            'Cloud backup settings',
            Icons.cloud_sync,
            AppTheme.success,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showBackupDialog(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'Privacy Settings',
            'Manage your privacy',
            Icons.privacy_tip,
            AppTheme.warning,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showPrivacyDialog(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'Delete Account',
            'Permanently delete your account',
            Icons.delete_forever,
            AppTheme.error,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showDeleteAccountDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkBlue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Support',
              style: AppTheme.headingMedium.copyWith(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildSettingsItem(
            'Help & FAQ',
            'Get help and find answers',
            Icons.help_outline,
            AppTheme.primaryBlue,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showHelpDialog(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'Contact Support',
            'Get in touch with our team',
            Icons.support_agent,
            AppTheme.success,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showContactDialog(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'Rate App',
            'Rate us on the app store',
            Icons.star_rate,
            AppTheme.warning,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showRateDialog(),
          ),
          _buildDivider(),
          _buildSettingsItem(
            'About',
            'Version 1.0.0',
            Icons.info_outline,
            AppTheme.softGray,
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.softGray,
              size: 16,
            ),
            onTap: () => _showAboutDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    Widget trailing, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.darkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.softGray,
                    ),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppTheme.lightGray.withOpacity(0.5),
      height: 1,
      indent: 56,
      endIndent: 20,
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        'Settings',
        'Advanced settings will be available soon!',
        'OK',
      ),
    );
  }

  void _editProfile() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          currentName: _userName,
          currentEmail: _userEmail,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _userName = result['name'] ?? _userName;
        _userEmail = result['email'] ?? _userEmail;
        _userPhone = result['phone'] ?? _userPhone;
      });
    }
  }

  void _showEditProfileDialog() {
    _editProfile();
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        'Currency Settings',
        'Currency selection feature will be available soon!',
        'OK',
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        'Language Settings',
        'Language selection feature will be available soon!',
        'OK',
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        'Export Data',
        'Data export feature will be available soon!',
        'OK',
      ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        'Backup & Sync',
        'Cloud backup feature will be available soon!',
        'OK',
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        'Privacy Settings',
        'Privacy settings will be available soon!',
        'OK',
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Delete Account',
          style: AppTheme.headingMedium.copyWith(
            color: AppTheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to permanently delete your account? This action cannot be undone.',
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.softGray,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.softGray,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Show confirmation that account deletion is not implemented
              showDialog(
                context: context,
                builder: (context) => _buildDialog(
                  'Account Deletion',
                  'Account deletion feature will be available soon!',
                  'OK',
                ),
              );
            },
            child: Text(
              'Delete',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        'Help & FAQ',
        'Help center will be available soon!',
        'OK',
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        'Contact Support',
        'Support contact feature will be available soon!',
        'OK',
      ),
    );
  }

  void _showRateDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        'Rate App',
        'App rating feature will be available soon!',
        'OK',
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'About Expense Bee',
          style: AppTheme.headingMedium.copyWith(
            color: AppTheme.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense Bee v1.0.0',
              style: AppTheme.bodyLarge.copyWith(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A premium expense management app built with Flutter.',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.softGray,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '© 2024 Expense Bee. All rights reserved.',
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.softGray,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialog(String title, String content, String buttonText) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: AppTheme.headingMedium.copyWith(
          color: AppTheme.darkBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: AppTheme.bodyMedium.copyWith(
          color: AppTheme.softGray,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            buttonText,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.primaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
