set -eo pipefail

xcodebuild -workspace Example/Draftsman.xcworkspace \
            -scheme Draftsman-Example \
            -destination platform=iOS\ Simulator,OS=14.5,name=iPhone\ 12 \
            clean test | xcpretty