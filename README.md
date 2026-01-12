# icloud-heic-mov-killer
Delete all the Livephoto videos from a raw / original export of iCloud data. If there is a mov file with the same name as a heic file the script will delete it.

Example:

* IMG_1234.HEIC   ← Picture
* IMG_1234.MOV    ← Livevideo from IMG_1234.HEIC
* IMG_1235.MOV    ← Normal video record

-> IMG_1234.MOV will be deleted

-> IMG_1235.MOV will not be deleted
