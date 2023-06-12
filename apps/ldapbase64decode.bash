#!/bin/bash
set -euo pipefail

perl -MMIME::Base64 -n -00 -e 's/\n +//g;s/(?<=:: )(\S+)/decode_base64($1)/eg;print'
