import com.android.build.api.dsl.ApplicationExtension
import com.android.build.api.dsl.LibraryExtension
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    plugins.withId("com.android.application") {
        extensions.configure<ApplicationExtension>("android") {
            compileSdk = 36
            ndkVersion = "28.2.13676358"
        }
    }
    plugins.withId("com.android.library") {
        extensions.configure<LibraryExtension>("android") {
            compileSdk = 36
            ndkVersion = "28.2.13676358"
            if (namespace == null) {
                namespace = "dev.goatsong.${project.name.replace("-", "_")}"
            }
        }
    }
    tasks.withType<KotlinCompile>().configureEach {
        compilerOptions {
            jvmTarget.set(JvmTarget.JVM_11)
        }
    }
    afterEvaluate {
        extensions.findByType(ApplicationExtension::class.java)?.apply {
            compileSdk = 36
            ndkVersion = "28.2.13676358"
        }
        extensions.findByType(LibraryExtension::class.java)?.apply {
            compileSdk = 36
            ndkVersion = "28.2.13676358"
            if (namespace == null) {
                namespace = "dev.goatsong.${project.name.replace("-", "_")}"
            }
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
