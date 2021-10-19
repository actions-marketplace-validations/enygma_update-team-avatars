# Update-Team-Avatars

This action updates the target repository's README with the avatars for the defined GitHub team.

This action will look at the `README.md` file in the root of the specified repository and see if the string `<TEAM>` exists. If it does, it will:

1. Fetch the current members of the specified team
2. Grab the URL locations for their avatars
3. Replace `<TEAM>` with an HTML table of the images

If at any time you want to recycle the images currently in place, you can just replace the table with `<TEAM>` and commit. The action handles the rest.

> Note: This action makes use of the [enygma/fetch-team-avatars](https://github.com/enygma/fetch-team-avatars) script to fetch the team information and output the table. This makes use of several Composer (PHP) packages to get the job done so check out that repository if you're interested in its dependencies.

## Setup

In order for this action to work, you'll need to set up a personal access token that has access to write to the target repository. It can be named anything you'd like. It just needs to be configured using the `access_token` input below. If it's a secret, that would look something like:

```yaml
access_token: ${{ secrets.token_name }}
```

It's also recommended to set up the `username` and `email` fields as secrets too:

```yaml
username: ${{ secrets.username }}
email: ${{ secrets.email }}
```

## Usage

Any time this action is installed and the `README.md` in the root directory contains the `<TEAM>` string, it will be replaced (all of them, not just one). So, if you want to update the avatars, remove the HTML table that was inserted before and replace it with `<TEAM>`.

You can then use a configuration similar to below to use this action:

## Inputs

Add a step like this to your workflow

```yaml
- uses: enygma/update-team-avatars@v1.1 # You can change this to use a specific version.
  with:
    # The repository where you want to update the README.md file.
    # Required, no default
    target_repository: 'user/repo-name'

    # Username of the user to use for the API request made to get team information
    # Required, no default
    username: 'username1'

    # Email that matches the user in "username" (for git commit)
    # Required
    email: 'user@email.com'

    # Access token used during the git checkout and push
    access_token: 'your-token-here'

    # Path to the team to get the information for. API request uses: https://docs.github.com/en/rest/reference/teams#members
    # Required, no default
    team: 'orgs/my-org/teams/team-name/members'

    # Branch to update
    # Default: "main"
    target_branch: 'main'
```

## Outputs

None