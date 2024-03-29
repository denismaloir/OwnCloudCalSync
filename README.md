# OwnCloudCalSync
One-way synchronization of an ics calendar file to owncloud CalDAV

The aim is simple: provide a one-way synchronization of an ics calendar file published by MS Outlook with a CalDAV calendar hosted on a private OwnCloud server.

# Methodology
My Outlook calendar allows me to publish an ics file to a WebDAV server. The overall methodology is to use a bash script to:
* Retrieve the ics file,
* Re-work it so that it is compatible with the OwnCloud CalDAV server,
* Replace all previously uploaded CalDAV events with the new, updated version.

I started from the solutions provided by [georgehrke](https://github.com/georgehrke/cl-calendarimport), but it is not compabible with the latest version of OwnCloud. I therefore investigated further and found this [Owncloud Forum Thread](https://forum.owncloud.org/viewtopic.php?t=11576) which I had to adapt a slightly to fit my needs:
* I slightly adapted the ics file retrieval process to the download of a single well-defined file published by Outlook,
* The re-work process is directly taken from the above sources. It consists in the split of the ics file into separate events,
* I then needed a way to purge the CalDAV server from past synchronizations before uploading any new event. I could not find a nicer way to do so than to delete the whole calendar alltogether, before creating a new one,
* The last step involves the upload of each of the separate events onto the CalDAV server.

# Variables
The variables to update to your situation are:
* LINK_TO_PUBLISHED_ICS_FILE : The link to the ics file published by Outlook or any other software,
* OWNCLOUD_SERVER : the location of your CalDAV server (here, an Owncloud server),
* USER : the username to access your CalDAV server,
* PASSWORD : the password to access your CalDAV server.
