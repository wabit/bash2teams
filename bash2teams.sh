#!/bin/bash

# Teams incoming web-hook
url='$3'
curlheader='-H "Content-Type: application/json"'
curlmaxtime='-m 60'


## Values received by this script:
# Subject = $1 Message Subject - hopefully either ERROR or SUCCESS
# Message = $2 whatever you want really i.e. "DANGER WILL ROBINSON!!!!"
# Chanel  = $3 Channel Webhook URL

subject="$1"

# Change message themeColor depending on the subject - green (SUCCESS), red (ERROR), or grey (for everything else)
if [[ "$subject" =~ SUCCESS ]]; then
        THEMECOLOR='43EA00'
elif [ "$subject" == 'ERROR' ]; then
        THEMECOLOR='EA4300'
else
        THEMECOLOR='555555'
fi

message="$2"

# Build the JSON payload and send it as a POST request to the Teams incoming web-hook URL

payload=\""{\\\"title\\\": \\\"${subject} \\\", \\\"text\\\": \\\"${message} \\\", \\\"themeColor\\\": \\\"${THEMECOLOR}\\\"}"\"

curldata=$(echo -d "$payload")

eval curl $curlmaxtime $curlheader $curldata $url $agent
