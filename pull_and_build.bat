@echo off

pushd %develop%
git pull
python "%folscode%\Python\BatchBuild\BuildCmd.py" OriginAll --platform=%1 --configuration=%2 --all-output
popd
