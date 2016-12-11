# OwnCloudCalSync
One-way synchronization of an ics calendar file to owncloud CalDAV

The aim is simple: provide a one-way synchronization of an ics calendar file published by MS Outlook with a CalDAV calendar hosted on a private OwnCloud server.

# Methodology
My Outlook calendar allows me to publish an ics file to a WebDAV server. The overall methodology is to use a bash script to:
1. Retrieve the ics file,
2. Re-work it so that it is compatible with the OwnCloud CalDAV server,
3. Replace all previously uploaded CalDAV events with the new, updated version.

I started from the solutions provided by [georgehrke](https://github.com/georgehrke/cl-calendarimport), but it is not compabible with the latest version of OwnCloud. I therefore investigated further and found this [Owncloud Forum Thread](https://forum.owncloud.org/viewtopic.php?t=11576) which I had to adapt a slightly to fit my needs.
1. I slightly adapted the ics file retrieval process to the download of a single well-defined file published by Outlook,
2. The re-work process is directly taken from the above sources. It consists in the split of the ics file into separate events,
3. I then needed a way to purge the CalDAV server from past synchronizations before uploading any new event. I could not find a nicer way to do so than to delete the whole calendar alltogether, before creating a new one.
4. The last step involves the upload of each of the separate events onto the CalDAV server.
