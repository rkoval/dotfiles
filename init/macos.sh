#!/usr/bin/env bash

# to disable accent menu on longpress
defaults write -g ApplePressAndHoldEnabled -bool false

# to make fonts less blurry in external monitors
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 3