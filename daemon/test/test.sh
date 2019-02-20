#Create gitup files
cd /usr/share/
sudo mkdir gitup
cd gitup
sudo touch repositories.csv
sudo echo "local_path,last_pulled" | sudo tee repositories.csv > /dev/null
sudo echo "/tmp/testrepo,0" | sudo tee -a repositories.csv > /dev/null
#echo "Contents of repositories.csv:"
#sudo cat repositories.csv

cd /tmp
mkdir testrepo
cd testrepo
git init

cd /home/travis/build/KamdenChew/TestTravis/daemon

#Start the daemon
python start_daemon.py

#Create new file
cd /tmp/testrepo
sudo touch test.txt

#Write to file
sudo echo "testing write operation" | sudo tee -a test.txt > /dev/null

#Verify file contents
#echo ""
#echo "Contents of test.txt:"
#sudo cat test.txt

#Remove file
sudo rm test.txt

#Print daemon output
#cd /tmp/gitup
#sudo cat daemon.out

#Stop the daemon
python stop_daemon.py

#Write expected output file
cd /home/travis/build/KamdenChew/TestTravis/daemon
sudo touch expected.txt
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_CREATE']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_OPEN']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_ATTRIB']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_CLOSE_WRITE']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_OPEN']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_MODIFY']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_CLOSE_WRITE']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_OPEN']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_ACCESS']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_CLOSE_NOWRITE']" | sudo tee -a test.txt > /dev/null
sudo echo "REPOSITORY=[/tmp/testrepo] PATH=[/tmp/testrepo] FILENAME=[test.txt] EVENT_TYPES=['IN_DELETE']" | sudo tee -a test.txt > /dev/null

#Compare daemon output with expected
cmp -s expected.txt /tmp/gitup/daemon.out

#Compile OAuth
#cd /home/travis/build/KamdenChew/TestTravis/src
#python -m compileall -l .

