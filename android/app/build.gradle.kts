import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import java.util.Properties
import java.io.FileInputStream
import io.github.cdimascio.dotenv.dotenv

buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("io.github.cdimascio:dotenv-kotlin:6.5.1")
    }
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.emotionmap.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.emotionmap.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    val devEnv = dotenv {
        directory = "../"
        filename = ".env.dev"
    }

    val prodEnv = dotenv {
        directory = "../"
        filename = ".env"
    }

    signingConfigs {
        getByName("debug") {
            keyAlias = devEnv.get("KEY_ALIAS", "")
            keyPassword = devEnv.get("KEY_PASSWORD", "")
            storeFile = file(devEnv.get("STORE_FILE", ""))
            storePassword = devEnv.get("STORE_PASSWORD", "")
        }
        create("release") {
            keyAlias = prodEnv.get("KEY_ALIAS", "")
            keyPassword = prodEnv.get("KEY_PASSWORD", "")
            storeFile = file(prodEnv.get("STORE_FILE", ""))
            storePassword = prodEnv.get("STORE_PASSWORD", "")
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
    }


    flavorDimensions += "flavor"

    productFlavors {
        create("dev") {
            dimension = "flavor"
            applicationIdSuffix = ".dev"

            resValue("string", "APP_NAME", devEnv.get("APP_NAME", ""))
            resValue("string", "KAKAO_SCHEME", devEnv.get("KAKAO_SCHEME", ""))
        }

        create("prod") {
            dimension = "flavor"

            resValue("string", "APP_NAME", prodEnv.get("APP_NAME", ""))
            resValue("string", "KAKAO_SCHEME", prodEnv.get("KAKAO_SCHEME", ""))
        }
    }
}

flutter {
    source = "../.."
}
