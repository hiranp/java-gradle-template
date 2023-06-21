#!/bin/env bash

# This script will update the project name in all files and folders
# input format: ./refactor.sh <new project name> <java package name>

# Default project name
PROJECT_NAME="hello-world"
JAVA_PACKAGE="com.willmolloy"

# Check if the number of arguments is correct
if [ $# -ne 2 ]; then
    echo "Usage: ./refactor.sh <new project name> <java package name>"
    echo "Example: ./refactor.sh new-project com.hiran"
    exit 1
fi

# Check if the project name is valid
if [[ ! $1 =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Invalid project name"
    exit 1
fi

# Check if the java package name is valid
if [[ ! $2 =~ ^[a-zA-Z0-9_.]+$ ]]; then
    echo "Invalid java package name"
    exit 1
fi

# Update the project name
NEW_PROJECT_NAME=$1
NEW_JAVA_PACKAGE_NAME=$2


# Copy the java package to the new name, need to use -p to create the parent directories
# Convert . to / in the java package name
mkdir -p "$NEW_PROJECT_NAME"/src/main/java/$(echo $NEW_JAVA_PACKAGE_NAME | sed 's/\./\//g')
mkdir -p "$NEW_PROJECT_NAME"/src/test/java/$(echo $NEW_JAVA_PACKAGE_NAME | sed 's/\./\//g')
mkdir -p "$NEW_PROJECT_NAME"/src/integrationTest/java/$(echo $NEW_JAVA_PACKAGE_NAME | sed 's/\./\//g')
mkdir -p "$NEW_PROJECT_NAME"/src/main/resources
mkdir -p "$NEW_PROJECT_NAME"/src/test/resources
mkdir -p "$NEW_PROJECT_NAME"/src/integrationTest/resources
cp "$PROJECT_NAME"/src/main/java/com/willmolloy/HelloWorld.java "$NEW_PROJECT_NAME"/src/main/java/$(echo $NEW_JAVA_PACKAGE_NAME | sed 's/\./\//g')/HelloWorld.java
cp "$PROJECT_NAME"/src/test/java/com/willmolloy/HelloWorldTest.java "$NEW_PROJECT_NAME"/src/test/java/$(echo $NEW_JAVA_PACKAGE_NAME | sed 's/\./\//g')/HelloWorldTest.java   
cp "$PROJECT_NAME"/src/integrationTest/java/com/willmolloy/HelloWorldIntegrationTest.java "$NEW_PROJECT_NAME"/src/integrationTest/java/$(echo $NEW_JAVA_PACKAGE_NAME | sed 's/\./\//g')/HelloWorldIntegrationTest
cp "$PROJECT_NAME"/src/main/resources/log4j2.xml "$NEW_PROJECT_NAME"/src/main/resources/log4j2.xml

# Update the project name and java package name in all files
escaped_pkg1=$(printf '%s\n' "$JAVA_PACKAGE" | sed 's/[.[\*^$]/\\&/g')
escaped_pkg2=$(printf '%s\n' "$NEW_JAVA_PACKAGE_NAME" | sed 's/[.[\*^$]/\\&/g')
# Escape the special characters in the author name:
link1="https://willmolloy.com>Will Molloy"
link2="https://hiranpatel.com>Hiran Patel"
escaped_link1=$(printf '%s\n' "$link1" | sed 's/[.[\*^$\/]/\\&/g')
escaped_link2=$(printf '%s\n' "$link2" | sed 's/[.[\*^$\/]/\\&/g')

find * -type f -name "*" ! -name "refactor.sh" -print0 | xargs -0 sed -i "s/$escaped_pkg1/$escaped_pkg2/g"
find * -type f -name "*" ! -name "refactor.sh" -print0 | xargs -0 sed -i "s/$PROJECT_NAME/$NEW_PROJECT_NAME/g"
find * -type f -name "*" ! -name "refactor.sh" -print0 | xargs -0 sed -i "s/$escaped_link1/$escaped_link2/g"

