hugo --cleanDestinationDir --disable404 --destination ../docs
echo blog.mprashant.com >> ../docs/CNAME


ping 127.0.0.1 -n 5 > nul