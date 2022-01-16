# Contributing

## Pull Requests

**Feature branches**. We develop using the feature branches, see this section of the Git book:
https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows.

If you are a member of the development team, create a feature branch directly
within the repository.

Otherwise, if you are a non-member contributor, fork the repository and create
the feature branch in your forked repository. See [this Github tuturial](
https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork
) for more guidance. 

**Branch Prefix**. Please prefix the branch with your Github user name 
(*e.g.,* `mristin/Add-some-feature`).

**Continuous Integration**. Github will run the continuous integration (CI) 
automatically through Github actions to verify that the submitted changes are
valid.

## Recommendation for Commit Messages

The commit messages follow the guidelines from 
from https://chris.beams.io/posts/git-commit:
* Separate subject from body with a blank line
* Limit the subject line to 50 characters
* Capitalize the subject line
* Do not end the subject line with a period
* Use the imperative mood in the subject line
* Wrap the body at 72 characters
* Use the body to explain *what* and *why* (instead of *how*)

## Pre-merge Checks

We use the sample programs from 
[schema-validation](https://github.com/admin-shell-io/schema-validation) 
repository to validate the schemas against the example data.

To install the schema-validation, invoke:

```
schemas\InstallSchemaValidation.ps1
```

To validate the example data against the schemas, call:

```
schemas\Validate.ps1
```

## Approval Process
All changes must be reviewed and approved.

Minor changes (simple failiures, typos, etc.) and additional content (more examples, etc.) can be accepted straight away after a brief review by the responsible reviewers.
In order to indicate the change, the reviewers in charge must be added to the pull request.
The responsible reviewers are:

| Topic | Path | Reviewer |
| ------------- | ------------- | ------------- |
| JSON | [schemas/json/](schemas/json/) | [@Manu3756](https://github.com/Manu3756) @torben.deppe |
| RDF | [schemas/rdf/](schemas/rdf/) | [@sebbader](https://github.com/sebbader) [@changqin26](https://github.com/changqin26) |
| XML | [schemas/xml/](schemas/xml/) | [@JoergWende](https://github.com/JoergWende) [@Manu3756](https://github.com/Manu3756) |
| XMI | [schemas/xmi/](schemas/xmi/) | [@BirgitBoss](https://github.com/BirgitBoss) |
| aas-specs-repo | [aas-specs/](https://github.com/admin-shell-io/aas-specs) | [@BirgitBoss](https://github.com/BirgitBoss) [@mristin](https://github.com/mristin) |


Major changes must first be reviewed and approved by the joint working group of the [Platform Industrie 4.0](http://www.plattform-i40.de) and [IDTA](https://industrialdigitaltwin.org/).


## Merge into Master Branch
After the approval the pull request can be merged into the repository.
Therefore, an assignee with the ability to merge into the main brach has to be notified by adding it to the pull request.
Those assignees are:
- [@sebbader](https://github.com/sebbader)
- [@mristin](https://github.com/mristin)
- [@BirgitBoss](https://github.com/BirgitBoss) 
- [@aorzelskiGH](https://github.com/aorzelskiGH) 
