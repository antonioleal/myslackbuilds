#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

gallery-dl "https://danbooru.donmai.us/posts?tags=bonocho"
konqueror .
sleep 30
rm -rf gallery-dl
