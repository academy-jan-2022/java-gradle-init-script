function CreateGradleProject {
    param (
        $PROJECT_NAME
    )

    if (-Not ("$PROJECT_NAME"))
    {
        Write-Output "Please specify a project name"
        exit 1
    }

    Write-Output Creating Gradle project in $PWD/$PROJECT_NAME...
    mkdir -p "$PROJECT_NAME/src/test/resources"
    mkdir -p "$PROJECT_NAME/src/test/java"
    mkdir -p "$PROJECT_NAME/src/main/resources"
    mkdir -p "$PROJECT_NAME/src/main/java"

    Write-Output "apply plugin: 'java'

repositories {
    mavenCentral()
}

dependencies {
    compile group: 'org.apache.commons', name: 'commons-lang3', version: '3.12.0'
    testCompile group: 'org.junit.jupiter', name: 'junit-jupiter', version: '5.7.2'
    testCompile group: 'org.easytesting', name: 'fest-assert', version: '1.4'
    testCompile group: 'org.mockito', name: 'mockito-all', version: '1.10.19'
}
" | Out-File -FilePath "$PROJECT_NAME/build.gradle" -encoding utf8

    Write-Output ".idea
.gradle
*.iml
*.ipr
*.iws
out
build" | Out-File -FilePath "$PROJECT_NAME/.gitignore" -encoding utf8

    Write-Output "rootProject.name = `"$PROJECT_NAME`"" | Out-File -FilePath "$PROJECT_NAME/gradle.settings" -encoding utf8

    Set-Location $PROJECT_NAME
    git init
    git add -- build.gradle .gitignore
    git commit -m "Added build script and .gitignore"

    Write-Output "All done. You can now import the project into your IDE."
}
