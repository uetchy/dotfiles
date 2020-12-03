#!/bin/bash

R=$(cat vscode/cspell.txt)
cat <<EOD | sort > vscode/cspell.txt
$(cat vscode/settings.json | jq '."cSpell.userWords"[]' -r)
$R
EOD
json -I -f vscode/settings.json -e 'this["cSpell.userWords"] = []'
