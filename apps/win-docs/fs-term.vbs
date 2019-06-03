set ws=wscript.createobject("wscript.shell")
ws.run "C:\PROGRA~1\VcXsrv\vcxsrv.exe :1 -nodecoration -notrayicon"
ws.run "C:\WSL\Arch\Arch.exe run source ~/.profile;cd ~;export DISPLAY=localhost:1; openbox& xfce4-terminal --fullscreen --hide-menubar; taskkill -f $(cmd wmic PROCESS LIST /format:csv | grep -P 'C:\\PROGRA~1\\VcXsrv\\vcxsrv\.exe' | cut -d, -f7)",0

