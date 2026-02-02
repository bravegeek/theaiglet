#!/usr/bin/env bash
# prep-image.sh - Convert and rename an image for a Hugo article
# Uses ImageMagick to convert PNG (or other formats) to JPG
# and places it in the article folder with the correct filename.
#
# Usage:
#   ./scripts/prep-image.sh <article-dir> <source-image>   # explicit mode
#   ./scripts/prep-image.sh <article-dir>                   # auto-detect: find the image that doesn't match frontmatter
#   ./scripts/prep-image.sh                                 # full auto: find most recent article + mismatched image
#
# Examples:
#   ./scripts/prep-image.sh content/posts/2026-01-30-my-article/ ~/Downloads/random123.png
#   ./scripts/prep-image.sh content/posts/2026-01-30-my-article/   # after dropping random123.png in the folder
#   ./scripts/prep-image.sh                                         # finds the latest article automatically

set -euo pipefail

POSTS_DIR="content/posts"
STAGING_DIR="sessions"

usage() {
    echo "Usage: $0 [article-dir] [source-image]"
    echo ""
    echo "  No args:        Auto-detect latest article + image from sessions/ staging dir"
    echo "  article-dir:    Look for an unprocessed image in this folder or sessions/"
    echo "  source-image:   Explicit source image to convert"
    exit 1
}

# Extract the expected image filename from frontmatter
get_target_image() {
    local index_file="$1"
    grep "^image" "$index_file" | head -1 | sed "s/^image *= *'//;s/'.*//"
}

# Find an image in a directory that doesn't match the expected filename
find_image_in_dir() {
    local dir="$1"
    local target="$2"

    for img in "$dir"/*.{png,PNG,webp,WEBP,jpg,JPG,jpeg,JPEG}; do
        [[ -f "$img" ]] || continue
        local basename
        basename=$(basename "$img")
        if [[ "$basename" != "$target" ]]; then
            echo "$img"
            return 0
        fi
    done
    return 1
}

# Find source image: check article dir first, then sessions/ staging dir
find_source_image() {
    local article_dir="$1"
    local target="$2"

    find_image_in_dir "$article_dir" "$target" && return 0
    if [[ -d "$STAGING_DIR" ]]; then
        find_image_in_dir "$STAGING_DIR" "$target" && return 0
    fi
    return 1
}

# Find the most recent article directory containing an unprocessed image
find_latest_article() {
    for dir in $(ls -dt "$POSTS_DIR"/*/); do
        local index_file="$dir/index.md"
        [[ -f "$index_file" ]] || continue

        local target
        target=$(get_target_image "$index_file")
        [[ -z "$target" ]] && continue

        if find_source_image "$dir" "$target" > /dev/null 2>&1; then
            echo "$dir"
            return 0
        fi
    done
    return 1
}

# Parse arguments
case $# in
    0)
        # Full auto mode
        article_dir=$(find_latest_article) || { echo "Error: No article found with an unprocessed image."; exit 1; }
        echo "Found article: $article_dir"
        ;;
    1)
        if [[ "$1" == "-h" || "$1" == "--help" ]]; then
            usage
        fi
        article_dir="$1"
        ;;
    2)
        article_dir="$1"
        source_image="$2"
        ;;
    *)
        usage
        ;;
esac

# Validate article directory
if [[ ! -d "$article_dir" ]]; then
    echo "Error: Article directory not found: $article_dir"
    exit 1
fi

index_file="$article_dir/index.md"
if [[ ! -f "$index_file" ]]; then
    echo "Error: No index.md found in $article_dir"
    exit 1
fi

# Extract expected image filename from frontmatter
target=$(get_target_image "$index_file")
if [[ -z "$target" ]]; then
    echo "Error: No 'image' field found in frontmatter of $index_file"
    exit 1
fi

dest="$article_dir/$target"

# Find source image if not explicitly provided
if [[ -z "${source_image:-}" ]]; then
    source_image=$(find_source_image "$article_dir" "$target") || {
        echo "Error: No unprocessed image found in $article_dir"
        echo "Drop an image file in the folder and try again."
        exit 1
    }
    echo "Found image: $source_image"
fi

# Validate source image
if [[ ! -f "$source_image" ]]; then
    echo "Error: Source image not found: $source_image"
    exit 1
fi

# Check if target already exists
if [[ -f "$dest" ]]; then
    read -rp "Image already exists at $dest. Overwrite? [y/N] " confirm
    if [[ "$confirm" != [yY] ]]; then
        echo "Aborted."
        exit 0
    fi
fi

# Convert and place the image
echo "Converting: $source_image"
echo "       To: $dest"
magick "$source_image" -quality 85 "$dest"

# Clean up the source if it was in the article dir or staging dir
source_dir="$(dirname "$(realpath "$source_image")")"
if [[ "$source_dir" == "$(realpath "$article_dir")" ]] || [[ -n "${STAGING_DIR:-}" && "$source_dir" == "$(realpath "$STAGING_DIR" 2>/dev/null)" ]]; then
    rm "$source_image"
    echo "Removed original: $source_image"
fi

echo "Done. Image ready at $dest"
