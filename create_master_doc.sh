#!/bin/bash

output_file="COMPLETE_TAG_ANALYSIS.md"

# Create header
cat > "$output_file" << 'HEADER'
# Complete Elixir Version History Analysis

This document contains a comprehensive analysis of all changes between consecutive Elixir versions, from v0.5.0 to v1.19.2, based on detailed commit analysis.

**Total version transitions analyzed:** 135

**Analysis approach:** Each transition was analyzed by an AI agent that examined commit messages, understood the context of changes, and provided thoughtful interpretation of what changed and why - not just a listing of commits.

**Generated on:** $(date)

---

HEADER

# Get all markdown files sorted by version
for file in $(ls -1 tag_analysis/*.md | sort -V); do
    echo "Adding: $file"
    cat "$file" >> "$output_file"
    echo -e "\n\n---\n\n" >> "$output_file"
done

echo "Done! Created $output_file"
wc -l "$output_file"
du -h "$output_file"
