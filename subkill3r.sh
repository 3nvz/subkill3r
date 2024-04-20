#!/bin/bash

# Function to display usage information
display_usage() {
    echo "Usage: $0 [-h] <domain>"
    echo "Options:"
    echo "  -h   Display this help message"
    exit 1
}

# Check for the presence of the -h flag
while getopts ":h" opt; do
    case ${opt} in
        h)
            display_usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            display_usage
            ;;
    esac
done

# Remove processed options from the command line arguments
shift $((OPTIND -1))

# Check if at least one command line argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Access the first command line argument
user_input=$1

# Print the input
echo "You entered: $user_input"

# Run the tools and combine output into a single file
output_file="subEnumFindings.txt"

echo "############### Stage 1 Starting ###############"
assetfinder -subs-only $user_input >> $output_file

echo "############### Stage 2 Starting ###############"
sublist3r -d $user_input -n -o $output_file

echo "############### Stage 3 Starting ###############"
subfinder -d $user_input -silent >> $output_file

echo "############### Removing Duplicates ###############"
# Remove duplicates from the combined output file
awk '!seen[$0]++' "$output_file" > "${output_file}.tmp" && mv "${output_file}.tmp" "$output_file"

echo "############### Checking for Live Hosts ###############"
cat "$output_file" | httprobe >> "$output_file"

number_of_subdomains=$(wc -l < "$output_file")

echo "We found: $number_of_subdomains subdomains!"
# Exit the script
exit 0