| Command | Purpose | 
|-------|-------|
|oc rollout history| To get the history of the rollouts|
|||

explore and add the below:
|options    |Purpose|
|--------   |-------|
|cancel     | cancel the in-progress deployment|
|history    | View rollout history|
|latest     | Start a new rollout for a deployment config with the |
|latest     | state from its triggers|
|pause      | Mark the provided resource as paused|
|resume     | Resume a paused resource|
|retry      | Retry the latest failed rollout|
|status     | Show the status of the rollout|
|undo       | Undo a previous rollout|



### Patching deployment config 

```sh
oc patch dc/apicast-production --patch '{"spec":{"template":{"spec":{"containers":[{"name":"apicast-production", "env": [{"name":"APICAST_LOG_LEVEL","value":"debug" }]}]}}}}'
```