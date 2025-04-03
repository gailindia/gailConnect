# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class io.flutter.plugins.firebase.** { *; }

# Prevent Firebase services from being stripped
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.firebase.auth.** { *; }

# Keep SQLCipher classes and their members intact
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.**
-keep class net.sqlcipher.** { *; }
-keepclassmembers class net.sqlcipher.database.SQLiteDatabase { *; }
-keepclassmembers class * extends net.sqlcipher.database.SQLiteDatabase { *; }
-dontwarn net.sqlcipher.**

#Flutter Wrapper
 -keep class com.shockwave.**
 -keep class io.flutter.app.** { *; }
 -keep class io.flutter.plugin.**  { *; }
 -keep class io.flutter.util.**  { *; }
 -keep class io.flutter.view.**  { *; }
 -keep class io.flutter.**  { *; }
 -keep class io.flutter.plugins.**  { *; }
