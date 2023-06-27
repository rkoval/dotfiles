#!/usr/bin/env bash

# command to list all
# defaults read -g

# to disable accent menu on longpress
defaults write -g ApplePressAndHoldEnabled -bool false

# to make fonts less blurry in external monitors
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 3

# show scrollbars always
defaults write -g AppleShowScrollBars -string Always

# dark mode
defaults write -g AppleInterfaceStyle -string Dark

# key repeat
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# disable force click
defaults write -g "com.apple.trackpad.forceClick" -int 0;

# natural scroll direction is unnatural
defaults write -g "com.apple.swipescrolldirection" -int 0

# prevent two-finger trackpad navigation
defaults write -g AppleEnableSwipeNavigateWithScrolls -int 0

# make clicking on scrollbar jump to that spot on page, not page up/down
defaults write -g AppleScrollerPagingBehavior -int 1

# don't make mac type period after two periods (why?)
defaults write -g NSAutomaticPeriodSubstitutionEnabled -int 0

# disable autocorrect by default because talking technical is impossible with it
defaults write -g NSAutomaticSpellingCorrectionEnabled -int 0

# disable auto-capitalization for the same reason
defaults write -g NSAutomaticCapitalizationEnabled -int 0

# disable mouse acceleration
defaults write -g com.apple.mouse.scaling -int -1

# disable expanded clock in top menubar. istatmenus provides a better one
defaults write com.apple.menuextra.clock IsAnalog -bool true

# show hidden files
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"

# show path at bottom
defaults write com.apple.finder "ShowPathbar" -bool "true"

# show all file extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# disable file extension warning
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# folders first when sorting
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

#
# Dock
#
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock "tilesize" -int "28"
defaults write com.apple.dock "mineffect" -string "scale"
defaults write com.apple.dock "static-only" -bool "true"


# load settings
killall Finder
killall Dock
