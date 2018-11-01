## How to Use a postgresql image
Start a docker container

```sh
docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
```
Connect to it from psql

```sh
docker run -it --rm --link some-postgres:postgres postgres psql -h postgres -U postgres
```

Connect to it from an application

```sh
docker run --name some-app --link some-postgres:postgres -d application-that-uses-postgres
```

>https://github.com/docker-library/docs/tree/master/postgres/

---


|Command|Purpose|
|----|----|
|psql -U dbUser -h localhost -p 5432 dbTasksMgmt| To login to a database dbTasksMgmt|
|dbTasksMgmt=>CREATE DATABASE dbname| To create a new database|
|dbTasksMgmt=> \c dbname| To connect to the database|
|dbname=> \l|List databases|
|dbname=> \d|To describe (list) what tables are in the database|
|dbname=> \d tablename|To describe attributes of a table|
|dbname=> \dy| List events|
|dbname=> \df| List functions|
|dbname=> \di| List indexes|
|dbname=> \dn| List schemas|
|dbname=> \dt \*.\* | List tables from all schemas (if \*.\* is omitted will only show SEARCH_PATH ones)|
|dbname=> \dv| List views|
|dbname=> \df+ functionname | Show function SQL code|
|dbname=> \x | Pretty-format query results instead of the not-so-useful ASCII tables|
|dbname=> \copy (SELECT * FROM table_name) TO 'file_path_and_name.csv' WITH CSV |Export a table as CSV|
|dbname=> \du| List users|
|dbname=> \du username| List a username if present|
|dbname=> \i filename|To run (include) a script file of SQL commands|
|dbname=> \e filename |To edit an existing script and execute the commands|
|dbname=> \e|To edit the last SQL command and execute upon exit|
|dbname=> \w filename |To write the last SQL command to a file|
|dbname=> \? |Show the list of \postgres commands|
|dbname=> \h |Show the list of SQLcommands|
|dbname=> \h command|Show syntax on this SQL command|
|dbTasksMgmt=> \q| To quit the psql terminal|
|||