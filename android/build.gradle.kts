allprojects {
    repositories {
        google()
        mavenCentral()
        // অনেক পুরনো বা কাস্টম অ্যান্ড্রয়েড টিভি লাইব্রেরি/প্লেয়ারের জন্য মাঝে মাঝে এটি প্রয়োজন হয়
        maven { url = uri("https://jitpack.io") } 
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
    // এটি নিশ্চিত করে যেন প্লাগইনগুলোর ইভালুয়েশন সিকোয়েন্স ঠিক থাকে
    afterEvaluate {
        if (project.hasProperty("android")) {
            project.evaluationDependsOn(":app")
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}