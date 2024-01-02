#!/bin/bash
set -euxo pipefail
shopt -s inherit_errexit

if [[ -z "${GITLAB_TOKEN+x}" ]]; then
	echo GITLAB_TOKEN not set. >&2
	exit 1
fi

if [[ -z "${GITLAB_URL+x}" ]]; then
	echo GITLAB_URL not set. >&2
	exit 1
fi

JQ_SCRIPT='map(select(.type == "DiffNote" and .resolved == false))
	| map({
		path: .position.new_path,
		line: .position.line_range.start.new_line,
		endline: .position.line_range.end.new_line,
		message: "\(.body)\nAuthor: \(.author.name)",
		severity: "warning",
		file: .position.new_path
	})'

cd "$(dirname "$1")" || exit 1
REPO_NAME="$(git remote get-url origin | sed -nr 's@.*:(.*)/(.*)\.git@\1%2F\2@p')"
CURRENT_BRANCH="$(git branch --show-current)"
MERGE_REQUEST_IID="$(curl --silent -H"Private-token: $GITLAB_TOKEN" "$GITLAB_URL/api/v4/projects/$REPO_NAME/merge_requests?source_branch=$CURRENT_BRANCH" | jq -r 'map(select(.state == "opened")) | if (. | length) == 1 then .[].iid else "" end')"
if [[ -z "$MERGE_REQUEST_IID" ]]; then
	exit 0
fi

curl --silent -H"Private-token: $GITLAB_TOKEN" "$GITLAB_URL/api/v4/projects/$REPO_NAME/merge_requests/$MERGE_REQUEST_IID/notes" | jq -r "$JQ_SCRIPT"
