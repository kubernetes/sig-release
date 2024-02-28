import os
import sys
import yaml

def check_release_notes_period(directory, field_name):
    """
    Function to check YAML files in a directory for the presence of a period at the end of the release notes field.
    """
    for filename in os.listdir(directory):
        if filename.endswith(".yaml") or filename.endswith(".yml"):
            filepath = os.path.join(directory, filename)
            with open(filepath, 'r') as file:
                try:
                    data = yaml.safe_load(file)
                    if field_name in data:
                        field_text = data[field_name].get('text', '')
                        if field_text.strip() and not field_text.strip().endswith('.'):
                            print(f"Error: Release notes field in file '{filename}' does not end with a period:")
                            print(field_text)
                            print()
                except yaml.YAMLError as e:
                    print(f"Error parsing YAML file '{filename}': {e}")

def main():
    """
    Main function to check YAML files in a directory for the presence of a period at the end of the release notes field.
    """
    # Check if the directory path is provided as an argument
    if len(sys.argv) != 2:
        print("Usage: python script.py <directory_path>")
        sys.exit(1)
    
    directory = sys.argv[1]
    field_name = "releasenote"
    check_release_notes_period(directory, field_name)

if __name__ == "__main__":
    main()
