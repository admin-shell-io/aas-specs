# Contributing

The specification of [Asset Administration Shell - Part 1] is an official publication of the joint working group of the [Platform Industrie 4.0] and [IDTA].
The specification and schema definition, including application examples in the aas-spec repository must be particularly compliant with this.
However, we invite the community to review, report and fix the specification and schema definitions, including application examples. 
Therefore, we demand a defined procedure for the contribution in this repository.

[Asset Administration Shell - Part 1]: https://www.plattform-i40.de/PI40/Redaktion/EN/Standardartikel/specification-administrationshell.html

## Before the Pull Requests

**Create Feature branches**.
We develop using the feature branches, see [this section of the Git book].

[this section of the Git book]: https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows.

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
After all changes have been committed to your feature branch, a [pull request] has to be created. See [this Github tutorial] for more guidance. 

[pull request]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request

## Pre-Merge Checks
**Continuous Integration.**
Github will run the continuous integration (CI) automatically through Github actions to verify that the submitted changes are valid.
Every pull request automatically runs the continuous integration with every update.

The continuous integration must be **successfully completed** with `All checks have passed` before proceeding with the approval process.

### Schema Validation
We use the sample programs from [schema-validation] repository in the continuous integration to validate the schemas against the [JSON], [XML] and [RDF] examples from the aas-spec repository.
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

## Approval Process
All changes must be **reviewed** and **approved**.

Minor changes (simple failures, typos, *etc.*) and additional content (more examples, etc.) can be accepted straight away after a brief review by the responsible reviewers.
In order to indicate the change, the reviewers in charge must be added to the pull request.

The responsible reviewers are:

| Topic | Path | Reviewer |
| -------------------- | --------------- | ------------------------- |
| JSON                 | [schemas/json/] | [@Manu3756] [@TorbenD] [@mristin] |
| RDF                  | [schemas/rdf/]  | [@sebbader] [@changqin26] [@mristin] |
| XML                  | [schemas/xml/]  | [@JoergWende] [@Manu3756] [@mristin] |
| XMI                  | [schemas/xmi/]  | [@BirgitBoss]             |
| aas-specs repository | [aas-specs/]    | [@BirgitBoss] [@mristin] |

[schemas/json/]: https://github.com/admin-shell-io/aas-specs/tree/master/schemas/json
[schemas/rdf/]: https://github.com/admin-shell-io/aas-specs/tree/master/schemas/rdf
[schemas/xml/]: https://github.com/admin-shell-io/aas-specs/tree/master/schemas/xml
[schemas/xmi/]: https://github.com/admin-shell-io/aas-specs/tree/master/schemas/xmi
[aas-specs/]: https://github.com/admin-shell-io/aas-specs

[@Manu3756]: https://github.com/Manu3756
[@TorbenD]:https://github.com/torbend
[@sebbader]: https://github.com/sebbader
[@changqin26]: https://github.com/changqin26
[@JoergWende]: https://github.com/JoergWende
[@BirgitBoss]: https://github.com/BirgitBoss
[@mristin]: https://github.com/mristin
[@g1zzm0]:https://github.com/g1zzm0

Major changes must first be reviewed and approved by the joint working group of the [Platform Industrie 4.0] and [IDTA].

[Platform Industrie 4.0]: http://www.plattform-i40.de
[IDTA]: https://industrialdigitaltwin.org/

## Merge into Master Branch

After the approval the pull request can be merged into the repository.
Therefore, an assignee with the ability to merge into the main branch has to be notified by adding it to the pull request.
Those assignees are:
- [@sebbader]
- [@mristin]
- [@BirgitBoss]
- [@aorzelskiGH]

[@aorzelskiGH]: https://github.com/aorzelskiGH

## Post-Merge Cleanup
**Congratulation.**
You successfully contributed to the aas-spec repository.

If you are a member of the development team, pleas delete the feature branch you directly created within the aas-specs repository.

Otherwise, if you are not part of the team and you forked the repository, feel free to delete your fork.
