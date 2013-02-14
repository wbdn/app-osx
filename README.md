#integration-osx
----------------------------------------
Desktop application &amp; system wide contextual menu integration for PrYv.

**Current version :** iteration 4

##Overview
Use the status menu to access the general features. From here, you can create a note, pryv some files, display information about your account (in the console), delete all the events and access the [PrYv website](http://www.pryv.net). It is also possible to drag and drop files on the Dock tilde or the status menu icon to pryv files and folder.

At this stage of development, it only works in offline mode. The online connection to an account will be implemented really soon.

##Details
The first time you'll launch the application, just enter a random username and token. It has no influence for the moment. Once connected, you can create some personal notes and pryv any files and folder. They follow the *event* structure of the PrYv API, storing a timestamp, tags, folder, etc...

###File
When pryving a file, you can choose multiple files and folders. The hierarchical structure of all the subfiles is stored in the name of those ones in the form : 

*sub/folder/path/to/filename.ext*

###User status
*Purge events* delete all the files from the Caches folder and release the event objects.

This Mac OS X integration for PrYv uses *CoreData* to implement persistence to data. The following informations about the account are conserved from one run to another :

- Username
- Authorization Token
- Set of events

We will use this for the application's offline mode.

##Troubleshooter and reset

You are reading this section if you want to :

- Troubleshoot **The managed object model version used to open the persistent store is incompatible with the one that was used to create the persistent store**
- Troubleshoot **Failed to initialize the store**
- Change the user
- Check what files are cached

CoreData is a great, powerful feature but it has some constraints when you have to change the data model. The solution is to *activate model versioning* or to *delete the data folder*. The first one has to be used when the *application is released* and that users are actually using it. The second one has to be used during the *development phase*. If you want to troubleshoot the CoreData errors or connect another user, just delete the **~/Library/Containers/pryv.PrYv** folder.

You can find all the cached files in the **~/Library/Containers/pryv.PrYv/Data/Library/Caches** folder, which is the folder you can use to write in when using application sandboxing.

##Information
You can explore data with the [GitHub explorer](http://pryv.github.com/explorer/).

The developer API reference is accessible at <http://dev.pryv.com>.

API issues should be reported to <https://github.com/pryv/pryv.github.com/issues>.
