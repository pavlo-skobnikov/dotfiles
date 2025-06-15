fish -c env | while IFS='=' read -r key value; do # Source Fish's environment.
  [[ -z $key || $key != *=* ]] && continue # Skip empty lines or if there’s no '='
  export "$key"="$value"                     # Wrap values with "" to protect from spaces.
done
