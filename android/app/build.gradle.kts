    plugins {
        id("com.android.application")
        id("kotlin-android")
        id("dev.flutter.flutter-gradle-plugin")
        id("com.google.gms.google-services")
        id("com.google.firebase.crashlytics")
    }

    android {
        namespace = "com.gail.gailconnect"
        compileSdk = flutter.compileSdkVersion
        ndkVersion = "27.0.12077973"
        compileOptions {
            isCoreLibraryDesugaringEnabled = true
            sourceCompatibility = JavaVersion.VERSION_17
            targetCompatibility = JavaVersion.VERSION_17
        }
        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile> {
            kotlinOptions {
                jvmTarget = JavaVersion.VERSION_17.toString()  // Use Java 17 target to match Java 17
            }
        }

//        tasks.withType<com.android.build.gradle.tasks.ExtractDeepLinks> {
//            it.enabled = false // Disable the deep link extraction task
//        }



        defaultConfig {
            // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
            applicationId = "com.gail.gailconnect"
            // You can update the following values to match your application needs.
            // For more information, see: https://flutter.dev/to/review-gradle-config.
            minSdk = 26
            targetSdk = 34
            versionCode = flutter.versionCode
            versionName = flutter.versionName
        }

        signingConfigs {
            create("release") {
                storeFile = file("/Users/gailmacbook/StudioProjects/gailconnect/android/app/my-release-key.keystore")
                storePassword = "gail@123"
                keyAlias = "alias_name"
                keyPassword = "gail@123"
            }
         }

        buildTypes {
            getByName("debug") {
                signingConfig = signingConfigs.getByName("debug")  // Default debug keystore
            }
            getByName("release") {
                isMinifyEnabled = true
                isShrinkResources = false
                proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
                signingConfig = signingConfigs.getByName("release")
            }
        }
        lint {

        }
        dependencies {
            implementation("net.zetetic:android-database-sqlcipher:4.5.0")
            implementation ("com.google.firebase:firebase-crashlytics:17.4.1")
            implementation ("com.google.firebase:firebase-analytics:21.0.0")
            implementation ("com.google.firebase:firebase-dynamic-links:20.0.0")
            coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
        }
    }

    flutter {
        source = "../.."
    }
