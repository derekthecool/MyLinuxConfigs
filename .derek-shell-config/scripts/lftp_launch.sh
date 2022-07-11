#!/bin/bash

lftp "$(fzf < ~/.ftplist)"
