#!/bin/bash
mkdir /tmp/CalSync

# get the calendars
fname=/tmp/CalSync/WorkCalendar.ics
curl -k "LINK_TO_PUBLISHED_ICS_FILE" > "${fname}"
# end with newline:
echo >> "${fname}"
file="${fname}"

#Get individual events:
bevents=($(grep -n BEGIN:VEVENT "$file" | cut -d: -f1))
eevents=($(grep -n END:VEVENT "$file" | cut -d: -f1))

ehead=${bevents[0]}
let "ehead -= 1"

bfoot=$(wc -l < $file)
let "bfoot -= ${eevents[-1]}"

for (( i=0; i < ${#bevents[@]}; i++))
do
    head -n $ehead $file > $file-$i.ics
    sed -n ${bevents[$i]},${eevents[$i]}p $file >> $file-$i.ics
    tail -n $bfoot $file >> $file-$i.ics
done
rm $file

echo "Deleting obsolete calendar entries"
curl -k -X DELETE https://USER:PASSWORD@OWNCLOUD_SERVER/remote.php/dav/calendars/admin/work

echo "Recreating the Work folder"
curl -k -X MKCALENDAR https://USER:PASSWORD@OWNCLOUD_SERVER/remote.php/dav/calendars/admin/work

echo "Repopulating the calendar with up-to-date events"
    for (( i=0; i < ${#bevents[@]}; i++))
    do
        uid=`grep -e "^UID:"  $file-$i.ics | sed 's/UID://' | tr -d '\n' | tr -d '\r'`

        curl -k -T $file-$i.ics  https://USER:PASSWORD@OWNCLOUD_SERVER/remote.php/dav/calendars/admin/work/"${uid}".ics
	echo "Event $i out of ${#bevents[@]}"
    done

echo "Deleting temporary files"
rm -rf /tmp/CalSync

echo "Done"
