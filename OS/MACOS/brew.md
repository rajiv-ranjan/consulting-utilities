# Useful commands - brew

> I wanted to move completely to python 3.7+ as soon (at the to of writing this doc) python 2 will be completely deprecated. So below set of commands helped me to analyse and move on.
```sh
# list of packages managed
brew ls

# number of packages installed
brew ls | wc -l

# dependencies for all installed packages
brew deps --installed 

# quick dependencies 
brew deps python@2

# which packages are using this package
brew uses python@2 
aap                bzr-fastimport     dxpy               ledger             offlineimap        subliminal
ansible@1.9        cassandra@2.1      euca2ools          logentries         ooniprobe          terminator
ansible@2.0        cassandra@2.2      git-plus           mercurial          opencv@2           tnote
appscale-tools     charm-tools        git-remote-hg      mesos              osc                uwsgi
archivemail        closure-linter     gnuradio           mkvtomp4           pdf-redact-tools   volatility
audacious          curlish            gwyddion           molecule           pwntools           vte
blastem            cvs2svn            headphones         muttils            py2cairo
boost-python@1.59  ddar               hg-flow            mysql-utilities    pygobject
bubbros            dnsviz             ino                nicotine-plus      redo
bup                docker-cloud       ipython@5          numpy@1.16         sslyze

# which INSTALLED packages are using python@2
brew uses python@2 --installed
mercurial

# get a list of leave packages that can be uninstalled easily
brew leaves --installed

# uninstall mercurial & python@2
brew uninstall mercurial python@2

```