#!/usr/bin/env bash

# to fix key repeating in sublime
defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false

# to make fonts less blurry in external monitors
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 3