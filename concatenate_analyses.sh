#!/bin/bash

output_file="COMPLETE_TAG_ANALYSIS.md"

# Create header
cat > "$output_file" << 'HEADER'
# Complete Elixir Version History Analysis

This document contains a comprehensive analysis of all changes between consecutive Elixir versions, from v0.5.0 to v1.19.2, based on commit messages and git history.

**Total version transitions analyzed:** 135

**Generated on:** $(date)

---

HEADER

# Get all markdown files sorted by version
for file in $(ls tag_analysis/*.md | sort -V); do
    echo "Adding: $file"
    cat "$file" >> "$output_file"
    echo -e "\n\n" >> "$output_file"
done

echo "Done! Created $output_file"
