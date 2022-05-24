set -eo pipefail

xcodebuild -workspace Example/Draftsman.xcworkspace \
            -scheme Draftsman-Example \
            -destination platform=iOS\ Simulator,OS=15.2,name=iPhone\ 11 \
            clean test | xcpretty