> TODO: Get a list of useful commands in each catagories in OCP. [1]
>
>[1]: https://docs.openshift.com/container-platform/3.11/cli_reference/basic_cli_operations.html

### Troubleshooting 
>https://docs.openshift.com/container-platform/3.11/cli_reference/basic_cli_operations.html#troubleshooting-and-debugging-cli-operations 
1. Start a shell for debugging
```sh
oc debug -h
oc debug dc/test
oc debug dc/test --as-user=1000000
oc debug dc/test -c second -- /bin/env
```
2. Verbosity with oc command. Levels go from 1 to 10. Higher the number the more detail is provided.
```sh
oc get pods -v=7
```

2. 