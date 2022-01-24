# Add this function to your powershell profile (code $PROFILE)
# and call it with CreateGradleProject [project name]

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

    $BuildGradle = "
plugins {
    id 'java'
}

group 'org.example'
version '1.0-SNAPSHOT'

repositories {
    mavenCentral()
}

dependencies {
    testImplementation 'org.junit.jupiter:junit-jupiter-api:5.8.2'
    testImplementation 'org.junit.jupiter:junit-jupiter-params:5.8.2'
    testRuntimeOnly 'org.junit.jupiter:junit-jupiter-engine:5.8.2'
}

test {
    useJUnitPlatform()
}
"
    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    New-Item -Name "$PROJECT_NAME/build.gradle" -ItemType File
    [System.IO.File]::WriteAllLines("$PWD/$PROJECT_NAME/build.gradle", $BuildGradle, $Utf8NoBomEncoding)

    $GitIgnore = ".idea
.gradle
*.iml
*.ipr
*.iws
out
build"
    New-Item -Name "$PROJECT_NAME/.gitignore" -ItemType File
    [System.IO.File]::WriteAllLines("$PWD/$PROJECT_NAME/.gitignore", $GitIgnore, $Utf8NoBomEncoding)

    $SettingsGradle = "rootProject.name = `"$PROJECT_NAME`""

    New-Item -Name "$PROJECT_NAME/settings.gradle" -ItemType File
    [System.IO.File]::WriteAllLines("$PWD/$PROJECT_NAME/settings.gradle", $SettingsGradle, $Utf8NoBomEncoding)

    Set-Location $PROJECT_NAME
    git init
    git add -- build.gradle .gitignore settings.gradle
    git commit -m "Added build script and .gitignore"

    Write-Output "All done. You can now import the project into your IDE."
}