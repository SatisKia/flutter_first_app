# flutter_first_app

�r���h��Android Studio Flamingo�{JDK 11�Ńr���h��ʂ�����

android\gradle\wrapper\gradle-wrapper.properties
```
distributionUrl=https\://services.gradle.org/distributions/gradle-7.4-all.zip
```

android\build.gradle
```
buildscript {
    dependencies {
        classpath 'com.android.tools.build:gradle:7.1.2'
    }
```

android\app\build.gradle
```
android {
    compileSdkVersion 33

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_11
        targetCompatibility JavaVersion.VERSION_11
    }

    defaultConfig {
        targetSdkVersion 33
    }
```
