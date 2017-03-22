echo off
echo *************************** publishing **********************************
cd _blog-source
call publish.bat
cd ..
pause

echo *************************** pushing **********************************
call commit.bat


pause