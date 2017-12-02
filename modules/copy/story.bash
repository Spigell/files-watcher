debug=$(config debug)
[[ $debug ]] && set -x

files=$( find_targets )
remote=$( story_var remote )

for file in $files; do

  echo "Processing file: $file"

  if [[ "$remote" == 'true' ]]; then
    rsync_cmd=$(create_rsync_cmd)

    if [[ "$dry_run" ]]; then
       echo -e "Your cmd for rsync will be: \n $rsync_cmd"
    else
       $rsync_cmd
    fi
  else
    if [[ "$dry_run" ]]; then
       echo "Your $file will be copied to $destionation_dir"
    else

    cp $file $destination_dir || exit 16
    echo "File $file copied to $destination_dir"
    fi

  fi

done

