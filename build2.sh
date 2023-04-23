#!/bin/bash

# Parent directory of the multi-module project


# List of module directories to build
MODULES=$(git status | grep -E "modified:|deleted:|added:" | awk '{print $2}' | cut -f1 -d"/")

# Maven command to run
MAVEN_COMMAND="mvn clean install"

# Loop through the module directories and run Maven command
while IFS= read -r MODULE; do

	if [ "${MODULE}" != "pom.xml" ]; then
  		echo "Building ${MODULE}..."
  		(mvn install  -pl ${MODULE})
  		#!/bin/bash

      # Read current version from Maven POM
      current_version=$(mvn help:evaluate -Dexpression=project.version -pl ${MODULE} -q -DforceStdout)

      # Extract the major, minor, and patch version components
      major_version=$(echo "$current_version" | cut -d'.' -f1)
      minor_version=$(echo "$current_version" | cut -d'.' -f2)
      patch_version=$(echo "$current_version" | cut -d'.' -f3)

      echo "this is major version $major_version"
      echo "this is major version $minor_version"
      echo  "this is major version $patch_version"

      # Increment the patch version by 1
      new_patch_version=$((patch_version + 1))

      # Construct the new version number
      new_version="$major_version.$minor_version.$new_patch_version"

      # Update Maven POM version
      mvn versions:set -DnewVersion="$new_version" -DgenerateBackupPoms=false -pl ${MODULE}

      # Create Git tag
      echo "Generating Tag \n Tag to be pushed "${MODULE}-$new_version-preprod

      git tag ${MODULE}-$new_version-preprod

      echo "Tag Created " ${MODULE}-$new_version-preprod


		  ##(mvn build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.nextIncrementalVersion} versions:commit -N versions:update-child-modules -DgenerateBackupPoms=false -pl "{$MODULE}")
  		echo "Build of ${MODULE} completed."
  	fi
done <<< "$MODULES"

mvn clean

git tag

git add --all

git commit -m "commit from maven jenkins"

git push
echo "Build of all modules completed."
