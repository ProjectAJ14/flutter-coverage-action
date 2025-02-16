#!/bin/bash

# Constants for colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Default configuration
readonly DEFAULT_MAX_REPORTS=50
readonly DEFAULT_DEBUG=0

# Path configuration
readonly COVERAGE_DIR="coverage"
readonly TEMP_DIR="gh-pages"
readonly README_FILE="README.md"

# Template paths
readonly PR_PATH_PATTERN="${COVERAGE_DIR}/pr-*"

# Usage information
usage() {
    echo -e "${BLUE}Usage: ./script.sh <repository> <pr_number> <github_token> [max_reports] [debug]${NC}"
    echo "Parameters:"
    echo "  repository   - GitHub repository (owner/repo)"
    echo "  pr_number   - Pull request number"
    echo "  github_token - GitHub authentication token"
    echo "  max_reports - Maximum number of reports to retain (default: ${DEFAULT_MAX_REPORTS})"
    echo "  debug       - Enable debug mode (0 or 1, default: ${DEFAULT_DEBUG})"
    echo
    echo "Environment variables:"
    echo "  COVERAGE_BASE_DIR - Base directory for coverage reports (default: coverage)"
    exit 1
}

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_debug() {
    if [[ "${DEBUG}" -eq 1 ]]; then
        echo -e "${BLUE}[DEBUG]${NC} $1"
    fi
}

# Path handling functions
initialize_paths() {
    # Override default coverage dir with environment variable if set
    COVERAGE_BASE_DIR=${COVERAGE_BASE_DIR:-$COVERAGE_DIR}
    # Create PR-specific paths
    PR_COVERAGE_DIR="${COVERAGE_DIR}/pr-${PR_NUMBER}"

    log_debug "Using paths:"
    log_debug "- Base coverage dir: ${COVERAGE_BASE_DIR}"
    log_debug "- PR coverage dir: ${PR_COVERAGE_DIR}"
}

ensure_directories() {
    local dirs=("$@")
    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            log_debug "Creating directory: ${dir}"
            mkdir -p "$dir"
        fi
    done
}

# Validate parameters
validate_parameters() {
    local repository=$1
    local pr_number=$2
    local github_token=$3
    local max_reports=$4

    validate_required_params "$repository" "$pr_number" "$github_token"
    validate_repository_format "$repository"
    validate_pr_number "$pr_number"
    validate_max_reports "$max_reports"
}

validate_required_params() {
    local repository=$1
    local pr_number=$2
    local github_token=$3

    if [[ -z "$repository" || -z "$pr_number" || -z "$github_token" ]]; then
        log_error "Missing required parameters"
        if [[ -z "$repository" ]]; then
            log_error "Repository is required"
        fi
        if [[ -z "$pr_number" ]]; then
            log_error "PR number is required"
        fi
        if [[ -z "$github_token" ]]; then
            log_error "GitHub token is required"
        fi
        usage
    fi
}

validate_repository_format() {
    local repository=$1

    if ! [[ "$repository" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]]; then
        log_error "Invalid repository format: $repository"
        exit 1
    fi
}

validate_pr_number() {
    local pr_number=$1

    if ! [[ "$pr_number" =~ ^[0-9]+$ ]] || [ "$pr_number" -lt 1 ]; then
        log_error "PR number must be a positive integer: $pr_number"
        exit 1
    fi
}

validate_max_reports() {
    local max_reports=$1

    if ! [[ "$max_reports" =~ ^[0-9]+$ ]] || [ "$max_reports" -lt 1 ]; then
        log_error "max_reports must be a positive integer: $max_reports"
        exit 1
    fi
}

# Function to generate coverage directory index HTML
generate_coverage_index() {
    local output_file="${COVERAGE_BASE_DIR}/index.html"
    local title="Coverage Reports Directory"
    log_debug "Generating coverage index at: $output_file"

    cat > "$output_file" << EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <style>
        :root {
            --primary-color: #2563eb;
            --background-color: #f8fafc;
            --text-color: #1e293b;
        }
        body {
            font-family: sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            padding: 2rem;
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        h1 { text-align: center; margin-bottom: 2rem; }
        .summary {
            background: #f1f5f9;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 2rem;
        }
        .retention-notice {
            background: #fef3c7;
            border: 1px solid #f59e0b;
            padding: 1rem;
            border-radius: 6px;
            margin-bottom: 2rem;
            font-size: 0.875rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }
        th {
            font-weight: 600;
            background-color: #f8fafc;
        }
        tr:hover { background-color: #f8fafc; }
        a {
            color: var(--primary-color);
            text-decoration: none;
        }
        a:hover { text-decoration: underline; }
        .latest-badge {
            background-color: #22c55e;
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            margin-left: 0.5rem;
        }
    </style>
    <script>
        function formatDate(utcString) {
            const date = new Date(utcString);
            return date.toLocaleString();
        }
        window.onload = function() {
            document.querySelectorAll('.timestamp').forEach(el => {
                el.textContent = formatDate(el.getAttribute('data-utc'));
            });
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>${title}</h1>
        <div class="retention-notice">
            <strong>📅 Retention Policy:</strong> To manage repository size, only the latest ${MAX_REPORTS} PR coverage reports are retained. Older reports will be automatically removed.
        </div>
EOL

    # Add summary section
    current_reports=$(find "${PR_PATH_PATTERN}" -maxdepth 0 -type d 2>/dev/null | wc -l)
    {
        echo '<div class="summary">'
        echo "<p>Active PR reports: ${current_reports} / ${MAX_REPORTS}</p>"
        echo "<p>Last updated: <span class=\"timestamp\" data-utc=\"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\"></span></p>"
        echo '</div>'
    } >> "$output_file"

    generate_table_entries "$output_file"

    # Close HTML
    echo '</div></body></html>' >> "$output_file"
}

# Function to generate table entries
generate_table_entries() {
    local output_file=$1

    # Add table header
    cat >> "$output_file" << EOL
        <table>
            <thead>
                <tr>
                    <th>Generated Date</th>
                    <th>Pull Request</th>
                </tr>
            </thead>
            <tbody>
EOL

    # Add current PR entry
    DEPLOY_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "<tr><td class=\"timestamp\" data-utc=\"${DEPLOY_TIME}\"></td><td><a href=\"pr-${PR_NUMBER}/\">PR #${PR_NUMBER}</a><span class=\"latest-badge\">Latest</span></td></tr>" >> "$output_file"

    # Add previous PR entries
    for pr_dir in ${PR_PATH_PATTERN}; do
        if [ -d "$pr_dir" ] && [ "$pr_dir" != "${PR_COVERAGE_DIR}" ]; then
            pr_num=$(basename "$pr_dir" | sed 's/pr-//')
            if [ "$pr_num" != "index.html" ] && [ "$pr_num" != "README.md" ]; then
                deploy_time=$(git log -1 --format="%aI" -- "$pr_dir" || date -u +"%Y-%m-%dT%H:%M:%SZ")
                echo "<tr><td class=\"timestamp\" data-utc=\"${deploy_time}\"></td><td><a href=\"pr-${pr_num}/\">PR #${pr_num}</a></td></tr>" >> "$output_file"
            fi
        fi
    done

    echo '</tbody></table>' >> "$output_file"
}

# Function to cleanup old reports
cleanup_old_reports() {
    local total_reports
    total_reports=$(find "${PR_PATH_PATTERN}" -maxdepth 0 -type d | wc -l) || return
    if [ "$total_reports" -gt "$MAX_REPORTS" ]; then
        log_info "Cleaning up old reports to maintain limit of $MAX_REPORTS reports..."
        find "${PR_PATH_PATTERN}" -maxdepth 0 -type d | sort -V | head -n -"$MAX_REPORTS" | xargs rm -rf
    fi
}

log_tree() {
    log_debug "Current Tree: $(pwd)"
    if [[ "${DEBUG}" -eq 1 ]]; then
        tree ../
    fi
}

# Main script execution
main() {
    set -e  # Exit on any error

    # Parse command line arguments
    REPOSITORY=$1
    PR_NUMBER=$2
    GITHUB_TOKEN=$3
    MAX_REPORTS=${4:-$DEFAULT_MAX_REPORTS}
    DEBUG=${5:-$DEFAULT_DEBUG}

    log_info "Starting coverage deployment for PR #${PR_NUMBER}"
    log_debug "Repository: ${REPOSITORY}"
    log_debug "Max Reports: ${MAX_REPORTS}"
    log_debug "Debug: ${DEBUG}"

    # Initialize and validate paths
    initialize_paths
    # Validate parameters
    validate_parameters "$REPOSITORY" "$PR_NUMBER" "$GITHUB_TOKEN" "$MAX_REPORTS"
    # Clone gh-pages branch
    git clone --single-branch --branch gh-pages "https://x-access-token:${GITHUB_TOKEN}@github.com/${REPOSITORY}.git" "${TEMP_DIR}" || {
    # If branch doesn't exist, create it
    log_warning "gh-pages branch not found, creating new branch..."
    git checkout --orphan gh-pages
    git rm -rf .
    ensure_directories "${COVERAGE_BASE_DIR}"
    echo "# Coverage Reports" > "${COVERAGE_BASE_DIR}/${README_FILE}"
    }

    ensure_directories "${TEMP_DIR}"
    log_tree
    cd "${TEMP_DIR}"
    # Create coverage directory for this PR
    log_info "Creating coverage directory for PR #${PR_NUMBER}..."
    ensure_directories "${PR_COVERAGE_DIR}"

    log_tree
    # Copy coverage report
    log_info "Copying coverage report..."
    cp -r "../${COVERAGE_BASE_DIR}/html/"* "${PR_COVERAGE_DIR}/"
    log_tree
    # Cleanup old reports
    cleanup_old_reports

    log_tree
    # Generate coverage index
    log_info "Generating coverage index..."
    generate_coverage_index

    # Commit and push changes
    log_info "Committing and pushing changes..."
    git add .
    git commit -m "Update coverage report for PR #${PR_NUMBER}"
    git push origin gh-pages

    log_info "Coverage deployment completed successfully"
}

# Execute main function with all arguments
main "$@"