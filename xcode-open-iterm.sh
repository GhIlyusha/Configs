# I bind this to ⌃⌘T
#!/bin/sh
dir="$PWD"
# Remove a potential suffix in case Xcode shows a Swift Package
suffix="/.swiftpm/xcode"
dir=${dir//$suffix/}
open -a iTerm "$dir"
