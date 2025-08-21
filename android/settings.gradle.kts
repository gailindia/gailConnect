pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
<<<<<<< HEAD
    id("org.jetbrains.kotlin.android") version "2.0.0" apply false
=======
    id("org.jetbrains.kotlin.android") version "1.8.10" apply false
>>>>>>> 00afc09a34e8f9dcdaf780dd358aecf5e32c21f4
}

include(":app")
