#!/bin/sh

# Usage: ./load_env.sh path/to/your.env

# Check if file was provided
if [ -z "$1" ]; then
  echo "Usage: $0 path/to/.env"
  exit 1
fi

ENV_FILE="$1"

# Check if file exists and is readable
if [ ! -f "$ENV_FILE" ] || [ ! -r "$ENV_FILE" ]; then
  echo "Error: Cannot read file '$ENV_FILE'"
  exit 1
fi

# Read and process each line
while IFS= read -r line || [ -n "$line" ]; do
  # Ignore empty lines and comments
  case "$line" in
    ''|\#*) continue ;;
  esac

  # Only handle lines in VAR=VALUE format
  case "$line" in
    [A-Za-z_]*=*)
      var_name=$(printf "%s" "$line" | cut -d= -f1)
      var_value=$(printf "%s" "$line" | cut -d= -f2-)
      # Remove surrounding quotes from value
      case "$var_value" in
        \"*\"|\'*\')
          var_value=$(printf "%s" "$var_value" | sed -e 's/^["'\'']//; s/["'\'']$//')
          ;;
      esac
      echo "$var_name"
      echo "$var_value"
      export "$var_name=$var_value"
      ;;
  esac
done < "$ENV_FILE"
