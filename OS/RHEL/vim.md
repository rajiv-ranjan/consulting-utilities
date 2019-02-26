### Find and replace in vim
All commands has to be followed by **Esc:**

| Command | Purpose | 
|-------|-------|
|:s/UNIX/Linux/g |all occurances in the current line only |
|:%s/UNIX/Linux/g|all occurances in the file|
|:%s/unix/Linux/gic|all occurances with case insensitive and confirmation|
|:%s/UNIX/bar/gIc|all occurances with case sesitive and confirmation|
|:100,200s/UNIX/Linux/gc|all occurances between line number 100 and 200|