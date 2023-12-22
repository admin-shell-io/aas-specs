# Contributing

Thank you for your interest in the specifications of the Asset Administration Shell!

## Industrial Digital Twin Association (IDTA)

Governance of the specifications of the Asset Administration Shell is done in the working group *Open Technology* 
of the [IDTA](https://industrialdigitaltwin.org/en/)

However, we invite the community to review, report and fix the specification 
and schema definitions, openAPI definition including application examples. 

## Naming Convention for github repos

For all github repositories that contain a part belong to the document series "Specification Asset Administration Shell" 
the name of the github repository is starting with **aas-specs**.


## Issue Handling

It is requested that every pull request is assigned to at least one related issue.

There are two types of issues:
- Minor changes (simple failures, typos, *etc.*) and additional content (more examples, etc.) can be accepted straight away after a brief review by the responsible reviewers.
  The corresponding issue will be labeled with **accepted** or **accepted in principle**

- Major changes must first be reviewed and approved by the Workstream "Specification Asset Administration Shell" within the "OpenTechnology" Working "Asset Administration Shell" of the  [IDTA].
  Corresponding issues will be labeled with **requires workstream approval** and - after review in the Workstream - with **accepted** or **accepted in principle**.
  If they are not accepted they will be closed without resolution.

Additionally the following classification by labeling is recommended:
- **specification** (major): the issue has impact on the implementation of the specifciation, e.g. adding new attribute to class, adding new API-operations, depracting element etc. 
- **documentation**: the issue has only impact on the editorial part of the specification but not impact on the implementation
- **process**: the issue has no impact on the specification but requires changes or improvements of the process as e.g. defined in this contribution guide

specific for IDTA-01001 Metamodel:
- **aas-core** (major): the issues has impact on the generation of the schema etc. but not impact on the specification itself.
    Note: Every issue that has impact on the specification (label *specification* also has impact on aas-core).

Labels classified as **major** need workstream approval (see [Approval_Process](#approval-process-for-pr)).

Labeling can only be done by the reponsibles of the github repository. See [How to label issues in github] for information on labeling.

After accepting an issue the milestone shall be set to the corresponding version of the specification that shall contain the change, e.g. "V3.1".
[Learn about milestones in github].

[How to label issues in github]: https://docs.github.com/en/issues/tracking-your-work-with-issues/quickstart#adding-labels
[Learn about milestones in github]: https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/about-milestones

## Before the Pull Requests

**Create Feature branches**.
We develop using feature branches, see [this section of the Git book].

[this section of the Git book]: https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows

If you are a member of the development team, [create a feature branch] directly within the repository.

[create a feature branch]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository

Otherwise, if you are a non-member contributor, fork the repository and create the feature branch in your forked repository. See [this Github tutorial] for more guidance. 

[this Github tutorial]: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork

**Branch Prefix**.
Please prefix the branch with your Github user name (*e.g.,* `mristin/Add-some-feature`).

## Recommendation for Commit Messages

The commit messages follow the guidelines from https://chris.beams.io/posts/git-commit:
* Separate subject from body with a blank line
* Limit the subject line to 50 characters
* Capitalize the subject line
* Do not end the subject line with a period
* Use the imperative mood in the subject line
* Wrap the body at 72 characters
* Use the body to explain *what* and *why* (instead of *how*)

## Create Pull Request
After all changes have been committed to your feature branch, a [pull request] (PR) has to be created.
Every PR should be linked to an issue for tracking.
See [this Github tutorial] for more guidance. 

[pull request]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request

[link PR to issue]: https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue

## Pre-Merge Checks
**Continuous Integration.**
Github will run the continuous integration (CI) automatically through Github actions to verify that the submitted changes are valid.
Every pull request automatically runs the continuous integration with every update.

The continuous integration must be **successfully completed** with `All checks have passed` before proceeding with the approval process.

### IDTA-01001: Schema Validation
We use the sample programs from [schema-validation] repository in the continuous integration to validate the 
schemas against the [JSON], [XML] and [RDF] examples from the aas-spec repository.
It is possible, but not necessary to check the schema-validation without creating the pull request. 

[schema-validation]: https://github.com/admin-shell-io/schema-validation
[JSON]: /schemas/json/examples
[XML]: /schemas/xml/examples
[RDF]: /schemas/rdf/examples

First you need to install the schema-validation, invoke:

```
schemas\InstallSchemaValidation.ps1
```

Afterwards you run the script to validate the example data against the schemas by calling:

```
schemas\Validate.ps1
```

### Check Commit and Pull Request Messages
In accordance with Section "Recommendation for Commit Messages" the continuous integration checks the previously defined conditions.
For the present development, however, this is not enforced.

## Approval Process for PR
All changes must be **reviewed** and **approved**.

Minor changes (simple failures, typos, *etc.*) and additional content (more examples, etc.) can be accepted straight away after a brief review by the responsible reviewers.

Major changes (i.e. pull requests associated to issues labels classified as "major") must first be reviewed and approved by the Workstream "Specification Asset Administration Shell" within the "OpenTechnology" Working "Asset Administration Shell" of the  [IDTA].


[IDTA]: https://industrialdigitaltwin.org/


## Merge into Master Branch

After the approval the pull request can be merged into the repository. This is done by one of the maintainers.


## Post-Merge Cleanup
**Congratulation.**
You successfully contributed to a specification repository of the Asset Administration Shell.

If you are a member of the development team, please delete the feature branch you directly created within the aas-specs repository.

Otherwise, if you are not part of the team and you forked the repository, feel free to delete your fork.


## License Headers & Licensing

All files contributed require headers - this will ensure the license and copyright clearing at the end. Also, all contributions must have the same license as the source.
The header should follow the following template:

```
////
Copyright (c) 2023 Industrial Digital Twin Association

This work is licensed under a [Creative Commons Attribution 4.0 International License](
https://creativecommons.org/licenses/by/4.0/). 

SPDX-License-Identifier: CC-BY-4.0

Illustrations:
Plattform Industrie 4.0; Anna Salari, Publik. Agentur für Kommunikation GmbH, designed by Publik. Agentur für Kommunikation GmbH
////
```

