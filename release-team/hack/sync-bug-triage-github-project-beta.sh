#!/usr/bin/env bash

# Copyright 2022 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Usage: `sync-bug-triage-github-project-beta.sh`
# Pre-requisite: add a GITHUB_TOKEN as the environment variable (Ref: https://github.com/kubernetes/org/issues/3558)

set -eu -o pipefail

: "${ORGANIZATION:=kubernetes}"
: "${REPOSITORY:=kubernetes}"

PROJECT_NUMBER=${PROJECT_NUMBER:-}
MILESTONE=${MILESTONE:-}

if [ "${GITHUB_TOKEN:-}" == "" ]; then
      echo "[Error] Required environment variable \"GITHUB_TOKEN\" is not set."
      exit 1
fi

if [ "$PROJECT_NUMBER" == "" ]; then
      echo "[Error] Required environment variable \"PROJECT_NUMBER\" is not set."
      exit 1
fi

if [ "$MILESTONE" == "" ]; then
      echo "[Error] Required environment variable \"MILESTONE\" is not set."
      exit 1
fi

milestone_issue_ids=()
milestone_pr_ids=()


## Function definitions

function get_field_ids_from_github_beta_project() {
    if [ "$1" == "project-id" ]
    then
        query='.data.organization.projectV2.id'
    elif [ "$1" == "type-id" ]
    then
        query='.data.organization.projectV2.fields.nodes[] | select(.name== "Type") | .id'
    elif [ "$1" == "issue-id" ]
    then
        query='.data.organization.projectV2.fields.nodes[] | select(.name== "Type") | .options[] | select(.name== "Issue") | .id'
    # for "pr-id"
    else
        query='.data.organization.projectV2.fields.nodes[] | select(.name== "Type") | .options[] | select(.name== "PR") | .id'
    fi

    ID="$( gh api graphql -f query='
                    query($org: String!, $number: Int!) {
                    organization(login: $org){
                        projectV2(number: $number) {
                        id
                        fields(first:100) {
                            nodes {
                            ... on ProjectV2Field {
                                id
                                name
                            }
                            ... on ProjectV2SingleSelectField {
                                id
                                name
                                options {
                                    id
                                    name
                                }
                            }
                            }
                        }
                        }
                    }
                    }' -f org="${ORGANIZATION}" -F number="${PROJECT_NUMBER}" --jq "$query")"
    echo "$ID"
}


function add_items_to_github_beta_project {
    	    gh api graphql -f query='
                    mutation (
                        $project: ID!
                        $item: ID!
                        $type_field: ID!
                        $option_id: String!
                    ) {
                        set_issue_type: updateProjectV2ItemFieldValue(input: {
                            projectId: $project
                            itemId: $item
                            fieldId: $type_field
                            value: {
                                singleSelectOptionId: $option_id
                            }
                        }) {
                            projectV2Item {
                                id
                            }
                        }
                    }' -f project="${PROJECT_ID}" -f item="${1}"  -f type_field="${TYPE_FIELD_ID}" -f option_id="${2}" --silent
}


echo 'Starting sync...'
echo -e "[INFO] Fetching the list of open issues and PRs from k/k under the current release milestone, ${MILESTONE}"


## Fetch issues
MILESTONE_ISSUES_JSON="$(gh api graphql --paginate -f query='
            query($org: String!, $repo: String!, $milestone: String!, $endCursor: String){
              repository(owner: $org, name: $repo) {
                description
                url
                milestones(states: [OPEN],first:1, query: $milestone) {
                  nodes{
                    issues(states:[OPEN], first: 100, after: $endCursor){
                      nodes{
                        id
                      }
                      pageInfo{
                        hasNextPage
                        endCursor
                      }
                    }
                  }
                }
              }
            }' -f org="${ORGANIZATION}" -f repo="${REPOSITORY}" -f milestone="${MILESTONE}")"

milestone_issues=($(jq ".data.repository.milestones.nodes[].issues.nodes | length" <<< "${MILESTONE_ISSUES_JSON}"))

for issues in "${milestone_issues[@]}"
do
	for index in $(seq 0 $(( issues - 1 )));
	do
		issue_id=($(jq ".data.repository.milestones.nodes[].issues.nodes[$index].id" <<< "${MILESTONE_ISSUES_JSON}"))
		milestone_issue_ids+=("${issue_id[@]}")
	done
done


## Fetch PRs
MILESTONE_PRS_JSON="$(gh api graphql --paginate -f query='
            query($org: String!, $repo: String!, $milestone: String!, $endCursor: String){
              repository(owner: $org, name: $repo) {
                description
                url
                milestones(states: [OPEN],first:1, query: $milestone) {
                  nodes{
                    pullRequests(states:[OPEN], first: 100, after: $endCursor){
                      nodes{
                        id
                      }
                      pageInfo{
                        hasNextPage
                        endCursor
                      }
                    }
                  }
                }
              }
            }' -f org="${ORGANIZATION}" -f repo="${REPOSITORY}" -f milestone="${MILESTONE}")"


milestone_prs=($(jq ".data.repository.milestones.nodes[].pullRequests.nodes | length" <<< "${MILESTONE_PRS_JSON}"))

for prs in "${milestone_prs[@]}"
do
	for index in $(seq 0 $(( prs - 1 )));
	do
		pr_id=($(jq ".data.repository.milestones.nodes[].pullRequests.nodes[$index].id" <<< "${MILESTONE_PRS_JSON}"))
		milestone_pr_ids+=("${pr_id[@]}")
	done
done


## Fetch Project metadata
echo -e "[INFO] Getting metadata for the Bug Triage GitHub Beta Project with ID: ${PROJECT_NUMBER}"

PROJECT_ID=$( get_field_ids_from_github_beta_project "project-id")
TYPE_FIELD_ID=$( get_field_ids_from_github_beta_project "type-id")
ISSUE_OPTION_ID=$( get_field_ids_from_github_beta_project "issue-id")
PR_OPTION_ID=$( get_field_ids_from_github_beta_project "pr-id")


## Add data to the Project Board
echo  '[INFO] Feeding data from k/k issues into the GitHub Project Beta'

for issue_id in "${milestone_issue_ids[@]}";
do
	# Issues
	if  [ "${issue_id}" !=  null ]; then
      		item_id="$( gh api graphql -f query='
            		mutation($project:ID!, $issue:ID!) {
              		addProjectV2ItemById(input: {projectId: $project, contentId: $issue}) {
                		item {
                  			id
               			}
              		}
            	}' -f project="${PROJECT_ID}" -f issue="${issue_id}" --jq '.data.addProjectV2ItemById.item.id')"

    		add_items_to_github_beta_project "${item_id}" "${ISSUE_OPTION_ID}"
	fi
done

echo  '[INFO] Feeding data from k/k PRs into the GitHub Project Beta'

for pr_id in "${milestone_pr_ids[@]}";
do
	# PRs
	if  [ "${pr_id}" !=  null ]; then
		item_id="$( gh api graphql -f query='
			mutation($project:ID!, $pr:ID!) {
              		addProjectV2ItemById(input: {projectId: $project, contentId: $pr}) {
                		item {
                 			 id
               		  	}
              		}
            	}' -f project="${PROJECT_ID}" -f pr="${pr_id}" --jq '.data.addProjectV2ItemById.item.id')"

	    	add_items_to_github_beta_project "${item_id}" "${PR_OPTION_ID}"
	fi
done

echo 'Sync finished!'
