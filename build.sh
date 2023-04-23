#!/bin/bash

# Parent directory of the multi-module project


# List of module directories to build
MODULES=$(git status | grep -E "modified:|deleted:|added:" | awk '{print $2}' | cut -f1 -d"/")

# Maven command to run
MAVEN_COMMAND="mvn clean install"

# Loop through the module directories and run Maven command
for MODULE in "${MODULES[@]}"; do

	if [ "${MODULE}" != "pom.xml" ]; then
  		echo "Building ${MODULE}..."
  		(mvn install  -pl ${MODULE} )
  		echo "Build of ${MODULE} completed."
  	fi
done

echo "Build of all modules completed."
