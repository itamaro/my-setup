# Quickly toggle visibility of hidden files in Finder
# (source: http://ianlunn.co.uk/articles/quickly-showhide-hidden-files-mac-os-x-mavericks/)
alias hidden_show='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidden_hide='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

reset_bluetooth() {
  sudo kextunload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport
  sleep 1
  sudo kextload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport
}
