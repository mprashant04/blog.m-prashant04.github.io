echo off
echo *************************** publishing **********************************
cd _blog-source
call publish.bat
cd ..

echo *************************** pushing **********************************
call commit.bat


pause