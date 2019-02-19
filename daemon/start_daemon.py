from daemon import GitUpDaemon
import os

# The repository information is stored in this file.
repofile = "/usr/share/gitup/repositories.csv"
logs_dir = '/tmp/gitup/'
out = '/tmp/gitup/daemon.out'
err = '/tmp/gitup/daemon.err'

# make sure the directory to write logs to exists.
if not os.path.isdir(logs_dir):
    try:
        os.mkdir(logs_dir)
    except OSError:
        print >> os.stderr,("failed to create logs directory")
        exit(1)
# delte previous logs
if os.path.isfile(out):
    os.remove(out)
if os.path.isfile(err):
    os.remove(err)
daemon = GitUpDaemon(pidfile='/tmp/gitup_daemon.pid',
                     repofile=repofile,
                     stdout=out,
                     stderr=err)
# Change this to daemon.run() to run the daemon connected to
# the terminal for easier debugging
daemon.start()
