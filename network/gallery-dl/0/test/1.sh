#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

gallery-dl "https://danbooru.donmai.us/posts?tags=bonocho"

ls -R
sleep 10

rm -rf gallery-dl
