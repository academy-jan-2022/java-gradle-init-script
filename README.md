# Java Gradle project init script

Helper script to initialize a new Gradle project.

## Usage

Adjust the script to your needs, put it on the `$PATH` and call it from the command line.

Enter the following parameters when prompted:

  - Project name (e.g. "my-java-project", "fizzbuzz-andrei-yeray")
  - Folder/java packages structure (e.g. "com/codurance/academy", "com/kata")

For example:

```
$ ./java-gradle-init.sh
Please enter a project name: my-java-project
Please enter an initial package structure for your application (use forward slash to separate packages): com/codurance/academy
```

For `my-java-project` as a project name and `com/codurance/academy` as a folder structure
the following files and directories will be created:

```
./my-java-project
├── build.gradle
├── .editorconfig
├── .gitattributes
├── .gitignore
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── .gradle
│   └── DETAILS OMITTED
├── gradlew
├── gradlew.bat
├── settings.gradle
└── src
    ├── main
    │   ├── java
    │   │   └── com
    │   │       └── codurance
    │   │           └── academy
    │   │               └── .keep
    │   └── resources
    └── test
        ├── java
        │   └── com
        │       └── codurance
        │           └── academy
        │               └── .keep
        └── resources
```

## It works on my machine

Tested on Linux and supposedly should work on Mac. It may not work the same or may not work at all on Windows.
