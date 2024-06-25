#! /sbin/bash

# Get docker nodes tags
# docker node ls -q | xargs docker node inspect \
# -f '{{ .ID }} [{{ .Description.Hostname }}]: {{ .Spec.Labels }}'

