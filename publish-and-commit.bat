echo off
echo *************************** publishing **********************************
cd _blog-source
call publish.bat
cd ..
pause

echo *************************** pushing **********************************
call commit.bat



ping 127.0.0.1 -n 5 > nul