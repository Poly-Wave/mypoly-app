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
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "kr.kro.mypoly.app"
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
        applicationId = "kr.kro.mypoly.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
    
    val flutterRoot = rootProject.projectDir.parentFile

    val appEnv = dotenv {
        directory = flutterRoot.absolutePath
        filename = ".env"
    }

    val devEnv = dotenv {
        directory = flutterRoot.absolutePath
        filename = ".env.dev"
    }

    val prodEnv = dotenv {
        directory = flutterRoot.absolutePath
        filename = ".env.prod"
    }

    signingConfigs {
        getByName("debug") {
            keyAlias = appEnv.get("DEBUG_KEY_ALIAS", "")
            keyPassword = appEnv.get("DEBUG_KEY_PASSWORD", "")
            storeFile = file(appEnv.get("DEBUG_STORE_FILE", ""))
            storePassword = appEnv.get("DEBUG_STORE_PASSWORD", "")
        }
        create("release") {
            keyAlias = appEnv.get("RELEASE_KEY_ALIAS", "")
            keyPassword = appEnv.get("RELEASE_KEY_PASSWORD", "")
            storeFile = file(appEnv.get("RELEASE_STORE_FILE", ""))
            storePassword = appEnv.get("RELEASE_STORE_PASSWORD", "")
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
            resValue("string", "KAKAO_SCHEME", devEnv.get("KAKAO_SCHEME", ""))
        }
    }
}

flutter {
    source = "../.."
}
