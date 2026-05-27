pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val localPropertiesFile = file("local.properties")
        
        // ১. যদি গিটহাব অ্যাকশন বা এনভায়রনমেন্টে ফ্ল্যাটার পাথ থাকে (CI/CD Safety)
        val envFlutterRoot = System.getenv("FLUTTER_ROOT")
        
        if (envFlutterRoot != null && envFlutterRoot.isNotEmpty()) {
            envFlutterRoot
        } else if (localPropertiesFile.exists()) {
            // ২. লোকাল পিসির জন্য local.properties থেকে পাথ নেবে
            localPropertiesFile.inputStream().use { properties.load(it) }
            val path = properties.getProperty("flutter.sdk")
            require(path != null) { "flutter.sdk not set in local.properties" }
            path
        } else {
            error("Flutter SDK path could not be found in Environment or local.properties")
        }
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
    id("com.android.application") version "8.3.2" apply false // নোটিফিকেশন দেখুন নিচে
    id("org.jetbrains.kotlin.android") version "1.9.24" apply false
}

include(":app")