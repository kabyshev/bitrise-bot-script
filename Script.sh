#!/usr/bin/env bash

CUSTOM_MESSAGE_FOR_FAILED=""
CUSTOM_MESSAGE_FOR_SUCCEED="🕔 App Store is processing this build right now. Please wait...\n\n#ios #$BITRISE_TRIGGERED_WORKFLOW_TITLE"

TELEGRAM_CHAT_ID=$TELEGRAM_CHAT_ID_FOR_FAILED
CUSTOM_MESSAGE=$CUSTOM_MESSAGE_FOR_FAILED
MESSAGE="❌ *CI*: Build #$BITRISE_BUILD_NUMBER failed!"

if [ $BITRISE_BUILD_STATUS -eq 0 ] ; then
    TELEGRAM_CHAT_ID=$TELEGRAM_CHAT_ID_FOR_SUCCEED
    CUSTOM_MESSAGE=$CUSTOM_MESSAGE_FOR_SUCCEED
    MESSAGE="🚀 *CI*: build #$BITRISE_BUILD_NUMBER passed!"
fi

MESSAGE+="\n\nBranch: *$BITRISE_GIT_BRANCH*\nWorkflow: *$BITRISE_TRIGGERED_WORKFLOW_TITLE*\nMessage: $BITRISE_GIT_MESSAGE ($BITRISE_GIT_COMMIT)\n\n $CUSTOM_MESSAGE"

curl -X POST -H "Content-Type: application/json" -d "{ \"chat_id\": \"$TELEGRAM_CHAT_ID\", \"text\":\"$MESSAGE\", \"parse_mode\": \"markdown\" }" https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage
