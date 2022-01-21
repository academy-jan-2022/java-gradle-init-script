#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

printf "%b" "${GREEN}Please enter a project name: ${NC}"
read -r PROJECT_NAME

# Replace white spaces with dashes
PROJECT_NAME=${PROJECT_NAME// /-}

if [ -z "$PROJECT_NAME" ]; then
    printf "\\n%b\\n" "${RED}Ooops, something went wrong."
    printf "%b\\n" "Please re-run the script and specify a project name.${NC}"
    exit 1
fi

printf "%b" "${GREEN}Please enter an initial package structure for your application (use forward slash to separate packages): ${NC}"
read -r FOLDER_STRUCTURE

if [ -z "$FOLDER_STRUCTURE" ]; then
    printf "\\n%b\\n" "${RED}Ooops, something went wrong."
    printf "%b\\n" "Please re-run the script and specify initial package structure for your project.${NC}"
    exit 1
fi

printf "%b\\n" "${GREEN}Creating Gradle project in ${NC}\"$PWD/$PROJECT_NAME\"${GREEN}...${NC}"

mkdir -p "$PROJECT_NAME"/src/{main,test}/{java/"$FOLDER_STRUCTURE",resources}
touch "$PROJECT_NAME"/src/{main,test}/java/"$FOLDER_STRUCTURE"/.keep

GRADLE_GROUP=${FOLDER_STRUCTURE//\//.}

echo "plugins {
    id 'java'
    id 'com.adarshr.test-logger' version '3.1.0'
}

defaultTasks 'clean', 'test'

group = '${GRADLE_GROUP}'
version = '0.0.1-SNAPSHOT'

repositories {
    mavenCentral()
}

dependencies {
    testImplementation 'org.junit.jupiter:junit-jupiter-api:5.8.2'
    testRuntimeOnly 'org.junit.jupiter:junit-jupiter-engine:5.8.2'
}

wrapper {
    gradleVersion = '7.3.3'
    distributionType = 'BIN'
}

test {
    useJUnitPlatform()
}

clean {
    doFirst {
        delete 'out'
    }
}" > "$PROJECT_NAME"/build.gradle

echo "rootProject.name = '$PROJECT_NAME'" > "$PROJECT_NAME"/settings.gradle

echo "root = true

[*]
charset = utf-8
end_of_line = lf
indent_size = 4
indent_style = space
insert_final_newline = true
max_line_length = 120
tab_width = 4
trim_trailing_whitespace = true

[{*.yml,*.yaml,*.json,*.md}]
indent_size = 2" > "$PROJECT_NAME"/.editorconfig

echo "* text=auto
*.bat text eol=crlf
*.cmd text eol=crlf
gradle/wrapper/gradle-wrapper.jar binary" > "$PROJECT_NAME"/.gitattributes

echo ".idea
.gradle
*.iml
*.ipr
*.iws
out
build" > "$PROJECT_NAME"/.gitignore

cd "$PROJECT_NAME" || exit 1
gradle wrapper
printf "%s\\n" ""
printf "\\n%b\\n"   "${GREEN}---------------------------------------------------"
printf "%b\\n"      "All done. You can now open the project in your IDE."
printf "%b\\n"      "---------------------------------------------------"
printf "%b\\n"   "Happy Gradling!${NC}"
