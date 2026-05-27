plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.ottking.ottking"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.ottking.ottking"
        
        // টিভির জন্য মিনিমাম SDK ২১ (Android 5.0) ফিক্সড করা হলো
        minSdk = 21 
        
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // স্মার্ট টিভির ৩২-বিট ও মোবাইলের ৬৪-বিট আর্কিটেকচার হ্যান্ডেল করার জন্য এটি যুক্ত করা হলো
        ndk {
            abiFilters.addAll(setOf("armeabi-v7a", "arm64-v8a", "x86_64"))
        }
    }

    buildTypes {
        release {
            // TODO: রিলিজ করার সময় আপনার নিজস্ব signing config এখানে যুক্ত করবেন।
            signingConfig = signingConfigs.getByName("debug")
            
            // অপ্রয়োজনীয় কোড রিমুভ করে অ্যাপ সাইজ ছোট করার জন্য (ঐচ্ছিক)
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}