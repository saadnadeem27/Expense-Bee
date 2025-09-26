import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Premium Color Palette
  static const Color primaryGold = Color(0xFFFFD700);
  static const Color primaryBlue = Color(0xFF1E3A8A);
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color accentOrange = Color(0xFFFF6B35);
  static const Color accentTeal = Color(0xFF14B8A6);
  static const Color accentPink = Color(0xFFEC4899);
  
  // Neutral Colors
  static const Color darkBlue = Color(0xFF0F172A);
  static const Color mediumBlue = Color(0xFF1E293B);
  static const Color lightBlue = Color(0xFF334155);
  static const Color softGray = Color(0xFF64748B);
  static const Color lightGray = Color(0xFFF1F5F9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Success & Error Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Premium Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF667eea),
      Color(0xFF764ba2),
    ],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFD700),
      Color(0xFFFFA500),
    ],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4F46E5),
      Color(0xFF7C3AED),
    ],
  );

  static const LinearGradient tealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF06B6D4),
      Color(0xFF14B8A6),
    ],
  );

  static const LinearGradient pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFEC4899),
      Color(0xFFBE185D),
    ],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1E293B),
      Color(0xFF0F172A),
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF8FAFC),
    ],
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF334155),
      Color(0xFF1E293B),
    ],
  );

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.inter().fontFamily,
      scaffoldBackgroundColor: lightGray,
      
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: primaryGold,
        surface: white,
        background: lightGray,
        error: error,
        onPrimary: white,
        onSecondary: darkBlue,
        onSurface: darkBlue,
        onBackground: darkBlue,
        onError: white,
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkBlue,
        ),
        iconTheme: const IconThemeData(color: darkBlue),
      ),

      cardTheme: CardTheme(
        elevation: 8,
        shadowColor: darkBlue.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          shadowColor: primaryBlue.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightGray, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryBlue,
        unselectedItemColor: softGray,
        elevation: 20,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.inter().fontFamily,
      scaffoldBackgroundColor: darkBlue,
      
      colorScheme: const ColorScheme.dark(
        primary: primaryGold,
        secondary: primaryPurple,
        surface: mediumBlue,
        background: darkBlue,
        error: error,
        onPrimary: darkBlue,
        onSecondary: white,
        onSurface: white,
        onBackground: white,
        onError: white,
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: white,
        ),
        iconTheme: const IconThemeData(color: white),
      ),

      cardTheme: CardTheme(
        elevation: 8,
        shadowColor: black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: mediumBlue,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          shadowColor: primaryGold.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: mediumBlue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightBlue, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryGold, width: 2),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryGold,
        unselectedItemColor: softGray,
        elevation: 20,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // Text Styles
  static TextStyle get headingLarge => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
      );

  static TextStyle get headingMedium => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  static TextStyle get headingSmall => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
      );

  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.2,
      );
}