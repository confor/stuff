rem i love bat files
@echo off
rem scoop seems to fork or detach from cmd, start /B fixes it
start /B scoop config debug false
start /B scoop config default_architecture 64bit
start /B scoop config show_update_log false
start /B scoop bucket add extras https://github.com/ScoopInstaller/Extras.git
