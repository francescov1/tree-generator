#!/bin/bash

# TODO: pass number of levels deep to go

explore_dir() {
  level=$1

  for item in * .[^.]*; do
    if [[ $item != "*" && $item != ".[^.]*" ]]; then
      str=""
      if [[ $level != 0 ]]; then
        for i in $(seq 1 $level); do str+='|   '; done
      fi

      #str="${str}├── ${item}"
      str="${str}+-- ${item}"
      echo $str >> ${root}/tree.md

      if [[ -d $item ]]; then
        (cd $item && explore_dir $(($level + 1)))
      fi
    fi

  done
}

if [ -f tree.md ]; then
   rm tree.md
fi

root=$(pwd)
explore_dir 0

# this part replaces the end with a closing branch (├── -> └──)
# TODO: this could be done cleaner
#last_line=$(grep "." tree.md | tail -1)
#last_line=$(echo "$last_line" | tr ├ └)
#last_line="└─${last_line:2}"
#sed -i '' -e '$ d' tree.md
#echo $last_line >> ${root}/tree.md

echo "The following directory tree can be found in tree.md:"
cat tree.md
