### Generating Patch Release Notes for the Release Notes website

To follow this process, fork the [Release Notes repo](https://github.com/kubernetes-sigs/release-notes), and create your own branch.

#### Running the Release Notes Tool for Patch Release

Run the [Release notes tool](https://github.com/kubernetes/release/tree/master/cmd/release-notes) with the following options:

Release branch, your GitHub token, repo path, patch release version, `json` as the format, and choose the previous and current patch releases for your start and end revisions:

Example:

```
./release-notes \
    --branch=release-1.15 \
    --github-token <YOUR-SECRET-TOKEN> \
    --repo-path /tmp/k8s \
    --release-version 1.15.3 \
    --format json \
    --output release-notes-1.15.3.json \
    --start-rev v1.15.2 \
    --end-rev v1.15.3
  ```

After you successfully run the Release Notes tool, make sure the resulting file is in the `src/assets` directory of your repo. [1.15.3 Example](https://github.com/kubernetes-sigs/release-notes/blob/master/src/assets/release-notes-1.15.3.json)

#### Two More Steps!

You'll need to update the Typescript file that filters notes per release -- just add the patch release entry to the list:

Example: `'src/assets/release-notes-1.15.3.json'`

[src/environments/assets.ts](https://github.com/kubernetes-sigs/release-notes/blob/master/src/environments/assets.ts)

Lastly, prepare (prettify) the JSON file, using the following commands:

```
> npm install
> npm run prettier
```

Commit the JSON file and TS file and open your pull request.
