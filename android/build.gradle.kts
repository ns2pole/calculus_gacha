allprojects {
    repositories {
        google()
        mavenCentral()
    }
    
    // Java toolchainをプロジェクト全体で設定してJava 8警告を解消
    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = JavaVersion.VERSION_11.toString()
        targetCompatibility = JavaVersion.VERSION_11.toString()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    // Java toolchainを明示的に設定してJava 8警告を解消
    // Androidプロジェクトの場合はcompileOptionsを設定
    plugins.withId("com.android.application") {
        extensions.findByType<com.android.build.gradle.AppExtension>()?.apply {
            compileOptions {
                sourceCompatibility = JavaVersion.VERSION_11
                targetCompatibility = JavaVersion.VERSION_11
            }
        }
    }
    
    plugins.withId("com.android.library") {
        extensions.findByType<com.android.build.gradle.LibraryExtension>()?.apply {
            compileOptions {
                sourceCompatibility = JavaVersion.VERSION_11
                targetCompatibility = JavaVersion.VERSION_11
            }
        }
    }
    
    // Javaプロジェクトの場合もJava 11を設定
    plugins.withId("java") {
        extensions.findByType<JavaPluginExtension>()?.apply {
            toolchain {
                languageVersion.set(JavaLanguageVersion.of(11))
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
