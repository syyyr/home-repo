#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

perl -MMIME::Base64 -n -00 -e 's/\n +//g;s/(?<=:: )(\S+)/decode_base64($1)/eg;print'
