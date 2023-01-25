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

# Usage: `sync-enhancements-github-project-beta.sh`
# Pre-requisite: add a GITHUB_TOKEN as the environment variable (Ref: https://github.com/kubernetes/org/issues/3558)

set -eu -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ORGANIZATION='kubernetes'
REPOSITORY='enhancements'
PROJECT_NUMBER=${GITHUB_PROJECT_BETA_NUMBER:-}

if [ "$PROJECT_NUMBER" == "" ]; then
      echo "[Error] Required environment variable \"GITHUB_PROJECT_BETA_NUMBER\" is not set."
      exit 1
fi

if [ "$GITHUB_TOKEN" == "" ]; then
      echo "[Error] Required environment variable \"GITHUB_TOKEN\" is not set."
      exit 1
fi

GITHUB_TOKEN="$(echo "$GITHUB_TOKEN" | tr -d '\n')"

milestone_issue_ids=()
milestone_issue_numbers=()


# function definitions
function get_field_ids_from_github_beta_project() {
    if [ $1 == 'project-id' ]
    then
        query='.data.organization.projectV2.id'
    else
        ##for 'issue-number-field-id'
        query='.data.organization.projectV2.fields.nodes[] | select(.name== "Issue Number") | .id'
    fi
    
    ID="$( gh api graphql --paginate -f query='query($org: String!, $number: Int!) {
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
                    }' -f org=${ORGANIZATION} -F number=${PROJECT_NUMBER} --jq "$query")"
    echo $ID
}

echo 'Startig sync...'
echo -e "[INFO] Fetching the list of open KEP issues from k/enhancements with the label, \"lead-opted-in\""


## Fetch k/enhancements issues & process json data
MILESTONE_ISSUES_JSON="$(gh api graphql --paginate -f query='query($org: String!, $repo: String!){
              			  repository(owner: $org, name: $repo) {
                		      description
                		      url
    				      issues(states:[OPEN], first: 100, labels: ["lead-opted-in"]) {
    					  nodes {
					      id
                      			      number
    					  }
    			                  pageInfo{
                        		      endCursor
                        		      hasNextPage
                    		          }
    				      }
    				  }
				  }' -f org=${ORGANIZATION} -f repo=${REPOSITORY})"

no_of_issues=$(jq ".data.repository.issues.nodes | length" <<< "$MILESTONE_ISSUES_JSON")
loop_index_range=$(( no_of_issues - 1 ))

for index in $(seq 0 $loop_index_range);
do
	issue_id=$(jq ".data.repository.issues.nodes[$index].id" <<< "$MILESTONE_ISSUES_JSON")
	issue_no=$(jq ".data.repository.issues.nodes[$index].number" <<< "$MILESTONE_ISSUES_JSON")
	milestone_issue_ids+=("${issue_id}")
	milestone_issue_numbers+=("${issue_no}")
done


# Fetch Project metadata
echo -e "[INFO] Getting metadata for the Enhancements GitHub Beta Project with ID: ${PROJECT_NUMBER}"

PROJECT_ID=$( get_field_ids_from_github_beta_project 'project-id')
ISSUE_NO_FIELD_ID=$( get_field_ids_from_github_beta_project 'issue-number-field-id')


# Add data into the Project Board
echo  '[INFO] Feeding data from k/enhancements into the GitHub Project Beta'

for index in $(seq 0 ${loop_index_range});
do
      item_id="$( gh api graphql -f query='
            mutation($project:ID!, $issue:ID!) {
              addProjectV2ItemById(input: {projectId: $project, contentId: $issue}) {
                item {
                  id
                }
              }
            }' -f project="${PROJECT_ID}" -f issue="${milestone_issue_ids[index]}" --jq '.data.addProjectV2ItemById.item.id')"

	    gh api graphql -f query='
                  mutation (
                    $project: ID!
                    $item: ID!
                    $issue_no_field: ID!
                    $issue_no_value: String
                  ) {
                    set_issue_no: updateProjectV2ItemFieldValue(input: {
                      projectId: $project
                      itemId: $item
                      fieldId: $issue_no_field
                      value: {
                        text: $issue_no_value
                        }
                    }) {
                      projectV2Item {
                        id
                      }
                    }
                  }' -f project="${PROJECT_ID}" -f item="${item_id}"  -f issue_no_field="${ISSUE_NO_FIELD_ID}" -f issue_no_value="${milestone_issue_numbers[index]}" --silent
done

echo 'Sync finished!'
