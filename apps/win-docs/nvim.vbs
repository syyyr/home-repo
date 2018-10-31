set ws=wscript.createobject("wscript.shell")

for each arg in wscript.arguments
    filename=filename&arg&" "
next
comm="C:\WSL\Arch\Arch.exe run ~/apps/windows-nvim.bash "
final=comm&filename
'wscript.echo final

ws.run final,0
