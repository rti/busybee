### General
Write a prompt for a coding agent.
It should build a script that iteratively develops a software project using an agent harness based on issues and open pull requests.
This script needs to be the only thing not defined via issues in this project.
The script should first check pull requests that received comments or reviews, iterate on them and push an update for review.
Otherwise, it should pick the next issue, implement it, and push it as a new pull request.
The script can ask clarifying questions in issues and pull requests.
If the script encounters a problem, is should create an issue for that.
All reviewing and merging is done by humans.

### Specifics
Execute one step per script invocation, the environment will loop the script.
Use bash for the script.
Use Github (via `gh` cli) as forge.
Expect GH_TOKEN and REPO from env.
Use opencode as agent harness.
Expect dependencies from the environement.
