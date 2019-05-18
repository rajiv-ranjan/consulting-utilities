* Create a tar file 
```sh
tar -cvf rajranja-files.tar /home/rajranja/
```

* Create a tar.gz archive file
```sh
tar -cvzf rajranja-files.tar.gz /home/rajranja/
```

* Create further compressed file in bz2 
```sh
tar -cvjf rajranja-files.tar.bz2 /home/rajranja/
```

* To un tar the compressed file 

```sh
tar -xvf rajranja-files.tar.bz2 /home/anotherfolder/
```

* List the content of the tar file

```sh
tar -tvf rajranja-files.tar.bz2 
```

* Extract one file from the tar file

```sh
tar -xvf rajranja-files.tar.bz2 onefileinsidearchive.sh
```