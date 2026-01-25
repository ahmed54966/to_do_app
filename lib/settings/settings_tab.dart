import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ليأخذ الـ Bottom Sheet حجم المحتوى فقط
            children: [
              // العنوان
              Text(
                'change_language'.tr(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              // خيار اللغة العربية
              _buildLanguageOption(
                context,
                title: 'arabic'.tr(),
                locale: const Locale('ar'),
                isSelected: context.locale == const Locale('ar'),
              ),
              
              // خيار اللغة الإنجليزية
              _buildLanguageOption(
                context,
                title: 'english'.tr(),
                locale: const Locale('en'),
                isSelected: context.locale == const Locale('en'),
              ),
            ],
          ),
        );
      },
    );
  }

  // widget مساعد لبناء خيار اللغة
  Widget _buildLanguageOption(BuildContext context, {required String title, required Locale locale, required bool isSelected}) {
    return ListTile(
      leading: Icon(Icons.language, color: isSelected ? AppColors.primaryColor : AppColors.grayColor),
      title: Text(title, style: TextStyle(color: isSelected ? AppColors.primaryColor : AppColors.blackLightColor)),
      trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.blue) : null,
      onTap: () async {
        // تغيير اللغة وإغلاق الـ Bottom Sheet
        await context.setLocale(locale);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () => _showLanguagePicker(context),

              style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor),
              
              child: Text('change_language'.tr() ,
              style: Theme.of(context).textTheme.bodyMedium,)
            ),
          ],
        ),
      ),
    );
  }
}