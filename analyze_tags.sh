#!/bin/bash

# Read all tags into an array
mapfile -t tags < /tmp/tags.txt

# Get total number of tags
total_tags=${#tags[@]}
echo "Processing $total_tags tags, creating $((total_tags - 1)) analysis files..."

# Process each consecutive pair of tags
for ((i=0; i<total_tags-1; i++)); do
    prev_tag="${tags[i]}"
    next_tag="${tags[i+1]}"

    # Create filename
    filename="tag_analysis/${prev_tag}-${next_tag}.md"

    echo "Processing: $prev_tag -> $next_tag ($((i+1))/$((total_tags-1)))"

    # Create markdown file with header
    echo "# Changes from $prev_tag to $next_tag" > "$filename"
    echo "" >> "$filename"

    # Get commit count
    commit_count=$(git rev-list --count ${prev_tag}..${next_tag})
    echo "**Total commits:** $commit_count" >> "$filename"
    echo "" >> "$filename"

    # Get date range
    prev_date=$(git log -1 --format=%ai $prev_tag)
    next_date=$(git log -1 --format=%ai $next_tag)
    echo "**Date range:** $prev_date to $next_date" >> "$filename"
    echo "" >> "$filename"

    # Get all commits with detailed messages
    echo "## Commits" >> "$filename"
    echo "" >> "$filename"

    # Use git log to get commits in reverse chronological order (newest first)
    git log --format="### %s%n%n**Author:** %an <%ae>%n**Date:** %ai%n**Commit:** %H%n%n%b%n----%n" ${prev_tag}..${next_tag} >> "$filename"

    # Add a final newline
    echo "" >> "$filename"
done

echo "Done! Created $((total_tags - 1)) analysis files in tag_analysis/"
