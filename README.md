jpg-ranger
==========

This is a little webapp I put together to store, archive, and index personal photos. It uses mongoDB as a backend.

The goal is to be able to upload pictures from various devices, storing them in once central location that can be easily
backed up. Also will allow various indexing and tagging options, and to be able to search and find a photo or photos
that can be viewed through the site or downloaded.

Developer note
--------------

The word "collection" is used as a method in mongoid objects. Therefore, inside the codebase the word "group" is used
instead of "collection" in many places. This is not always consistent, but it is in the process of being migrated.

The word "collection" is still preferable in the GUI, and should remain in use there.