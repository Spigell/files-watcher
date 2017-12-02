debug=$(config debug)
[[ $debug ]] && set -x

files=$( find_targets )
remote=$( story_var remote )

for file in $files; do

  echo "Processing file: $file"

  if [[ "$remote" == 'true' ]]; then
    rsync_cmd=$(create_rsync_cmd)
    rsync_cmd+=" --remove-source-files"

    if [[ "$dry_run" ]]; then
       echo -e "Your cmd for rsync will be: \n $rsync_cmd"
    else
       $rsync_cmd
    fi
  else

    if [[ "$dry_run" ]]; then
       echo "Your $file will be moved to $destionation_dir"
       exit 0
    else

    mv $file $destination_dir || exit 16
    echo "File $file moved to $destination_dir"
    fi
  fi

done
