* on macos use java_home to get the version of the java installed.
```sh
# show where is the java home 
/usr/libexec/java_home

# show available java versions
/usr/libexec/java_home -V

# switch the java version
/usr/libexec/java_home -v 1.8.0_151
```

* easy script for switching java versions
```sh
# below to bash_profile
alias j11="export JAVA_HOME=/usr/libexec/java_home -v 11; java -version"
alias j10="export JAVA_HOME=/usr/libexec/java_home -v 10; java -version"
alias j8="export JAVA_HOME=/usr/libexec/java_home -v 1.8; java -version"
```