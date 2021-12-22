# rkoval's dotfiles

- Shut down your Mac entirely and then boot into recovery OS
  - Intel: Press power button then hold Cmd+R while booting
  - M1/arm: Press and hold power button down while booting

- While in recovery, run:

  ```sh
  csrutil disable
  reboot
  ```

- Install XCode from App Store
- Explicitly open XCode after install to install extras
- [Generate an SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) and associate it with your GitHub account (submodule cloning will fail otherwise)
- Initialize dotfiles:

  ```sh
  ./init.sh
  ```

- Restart your Mac while pressing Cmd+R to boot into recovery OS and run:

  ```sh
  csrutil enable
  reboot
  ```

# Troubleshooting

- If homebrew installation can't find and install the command line extras, then you may need to open Software Update to install missing updates for XCode. If macOS prompts you to reinstall the exact same updates after installing, try restarting (yes, actually)
- If MacVim fails to install because of missing ruby headers, try symlinking the `universal-darwinXX/ruby/config.h` header to the system ruby directory:

  ```sh
  # replace Xs with actual version numbers
  # from ruby directory output by `brew install --verbose`
  sudo ln -s ../../ruby-X.X.X/universal-darwinXX/ruby/config.h
  ```
