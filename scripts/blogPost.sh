#! /usr/bin/env bash

# Assign the current date and time to a variable
current_datetime=$(date +"%m/%d/%Y")
postName="$1.md"

cat >> ./content/blog/$postName <<EOF
---
title: '$1'
description: 'N/A'
pubDate: '$current_datetime'
heroImage: 'N/A'
heroImageWidth: 600
heroImageHeight: 300
---
EOF


