# Virtual-Vehicle-Storage-for-Epoch

After downloading and decompression the files from github do the following:

SERVER:
1. copy @VGFE into the root directory for your server, where @epochhive is kept.
2. pack @VGFE\addons\vgfe (to VGFE.pbo) using PBO manager or another PBO tool.
3. edit the startup parameters for your server as follows: 
    Add @VGFE; to "-servermod= " 
    It will look like this for a basic server "-servermod=@epochhive;@VGFE;"

CLIENT [Mission.pbo]:

4. Unpack your mission.pbo (The mission pbo would be named epoch.Altis, epoch.Tanoa, etc.)
   copy the addons folder from epoch.mapname in the download into the folder for you mission.
5. Merge the contents of description.ext and the files inside \epoch_config with those in your mission.pbo
6. Adjust configuration for VGFE in addons\VGFE\CfgVGFE.hpp
7. Repack your miission .pbo.

BATTLEYE:

8. Merge remoteexec.txt to add the exception

INFISTAR

9. Add 720 to the list of allowed idd's, here: 
_allowedIDDs =
[

];
