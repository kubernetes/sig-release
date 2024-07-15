package main

import (
	"fmt"
	"os"
	"strings"

	"sigs.k8s.io/yaml"
)

// validateYAML reads and parses the YAML file at the given path.
func validateYAML(filePath string) string {
	data, err := os.ReadFile(filePath)
	if err != nil {
		return fmt.Sprintf("Error reading %s:\n%s", filePath, err.Error())
	}

	var content interface{}
	if err := yaml.UnmarshalStrict(data, &content); err != nil {
		return fmt.Sprintf("Error in %s:\n%w", filePath, err.Error())
	}

	return "Valid"
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("No YAML files specified.")
		os.Exit(1)
	}

	files := os.Args[1:]
	invalidFiles := []string{}

	for _, file := range files {
		result := validateYAML(file)
		if result != "Valid" {
			invalidFiles = append(invalidFiles, result)
		}
	}

	if len(invalidFiles) > 0 {
		fmt.Println("YAML Validation Failed:\n")
		for _, errorMsg := range invalidFiles {
			fmt.Println(errorMsg)
			fmt.Println("\n" + strings.Repeat("-", 40) + "\n")
		}
	} else {
		fmt.Println("All YAML files are valid 🎉.")
	}
}
