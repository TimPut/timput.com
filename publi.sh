#!/usr/bin/env bash
nix-build --builders '' && rsync -P -vr -e ssh -i /home/tim/.ssh/general result/ tput_put@ssh.phx.nearlyfreespeech.net:/home/public/
