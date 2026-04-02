#!/bin/bash
package_list="$1"

for row in $(jq -c '.[]' $package_list); do

    name=$(echo $row | jq -r '.name')
    versions=$(echo $row | jq -c '.versions')

    if [[ -n "$versions" && "$versions" != "null" && "$versions" != "[]" ]]; then
      new_ver=""
      first=true
      for version in $(echo $versions | jq -cr '.[]'); do
        if [ $first == true ]; then
          new_ver="${new_ver}\`${version}\`"
          first=false
        else
          new_ver="${new_ver}<br>\`${version}\`"
        fi
      done
      echo "| \`$name\` | $new_ver |"
    else
      echo "| \`$name\` | \`$name\` |"
    fi
done