import yaml
import sys

def validate_yaml(file_path):
    try:
        with open(file_path, 'r') as f:
            yaml.safe_load(f)
        return "Valid"
    except yaml.YAMLError as e:
        return f"Error in {file_path}:\n{str(e)}"

if __name__ == "__main__":
    files = sys.argv[1:]
    invalid_files = []
    for file in files:
        result = validate_yaml(file)
        if result != "Valid":
            invalid_files.append(result)

    if invalid_files:
        print("YAML Validation Failed:\n")
        for error in invalid_files:
            print(error)
            print("\n" + "-"*40 + "\n")
        sys.exit(1)
    else:
        print("All YAML files are valid 🎉.")