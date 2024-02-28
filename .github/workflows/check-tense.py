import os
import sys
import yaml
import spacy
import re

# Load English language model
nlp = spacy.load("en_core_web_sm")

def is_past_tense(text):
    """
    Function to check if a given text is in past tense.
    """
    doc = nlp(text)
    for token in doc:
        if token.tag_ == 'VBD' or token.tag_ == 'VBN':  # Include both VBD (past tense) and VBN (past participle)
            return True
    return False

def parse_sentence_from_yaml(yaml_string, field_name):
    """
    Function to parse a sentence from a YAML field.
    """
    data = yaml.safe_load(yaml_string)
    if field_name in data:
        field_text = data[field_name]
        if isinstance(field_text, dict) and 'text' in field_text:
            return field_text['text']
    return None

def check_yaml_files(directory, field_name):
    """
    Function to check YAML files in a directory for past tense in the specified field.
    """
    for filename in os.listdir(directory):
        if filename.endswith(".yaml") or filename.endswith(".yml"):
            filepath = os.path.join(directory, filename)
            with open(filepath, 'r') as file:
                yaml_string = file.read()
                sentence = parse_sentence_from_yaml(yaml_string, field_name)
                if sentence and not re.search(r'`.*?`', sentence):  # Ignore sentences containing code snippets
                    if not is_past_tense(sentence):
                        print(f"Error: Sentence in '{field_name}' field of file '{filename}' is not in past tense:")
                        print(sentence)
                        print()

def main():
    """
    Main function to check YAML files in a directory for past tense in the specified field.
    """
    # Check if the directory path is provided as an argument
    if len(sys.argv) != 2:
        print("Usage: python script.py <directory_path>")
        sys.exit(1)
    
    directory = sys.argv[1]
    field_name = "releasenote"
    check_yaml_files(directory, field_name)

if __name__ == "__main__":
    main()
