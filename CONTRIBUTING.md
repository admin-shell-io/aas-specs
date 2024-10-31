# Contributing

The [Specification of the Asset Administration Shell - Part 1] is an official publication of the [IDTA] work stream "Specification of the Asset Administration Shell".
The API definitions in this repository must be particularly compliant with this specification.
To ensure a faster adoption and improvement of AAS API, we invite the community to contribute with reviews, reporting issues, and fixing them.  
Do you want to contribute? Great! But before you do it, please follow the defined procedure for the contribution in this repository. 

[Specification of the Asset Administration Shell - Part 1]: https://industrialdigitaltwin.org/en/content-hub/


## Prerequisites

**Please note** that by submitting an Issue or a Pull Request (PR), you aggree that the created content falls under a Developer Certificate of Origin ([DCO]), by which you declare that you have the legal right to contribute the content under the stated license and that the [IDTA] and the maintainers of this repository are allowed to use your contribution for publications, e.g., [Specification of the Asset Administration Shell - Part 2]. In certain cases, an additional signing of a Contributor License Agreement (CLA) can be required. It is up to the maintainers of this repository to decide whether an individual contribution needs also a signed CLA. In case the contributor does not sign it in an appropriate time span after being notified, the contribution cannot be used further and in particular can not appear in any release.

[DCO]: https://developercertificate.org 


## Raising Issues

[Github Issues](https://github.com/admin-shell-io/aas-specs-api/issues) are the preferred way to inform the community about bugs, shortcomings, feature requests and so on.  


**Use a template**. Several issue templates are available to better structure the process. Depending on your issue, submit a review finding, a bug report, or a request for a new feature. Only if none of these fits, [open a new blank issue](https://github.com/admin-shell-io/aas-specs-api/issues/new). Due to legal reasons, click also the checkmark stating that you have already signed the [DCO] (see [Section Prerequisites](#prerequisites)).  
A maintainer will then assign additional labels, milestones, and individual other contributers if possible.


## Before the Pull Requests

If you are contributing for the first time, please inform yourself about the [LICENSE](./LICENSE.txt) used for this repository. Also, you will be asked to sign a [DCO] if not done already (see [Section Prerequisites](#prerequisites)). Different to issues, Pull Requests are checked automatically through the [CLA Assistant](https://cla-assistant.io).


**Create Feature branches**.
We develop using the feature branches, see [this section of the Git book].

[this section of the Git book]: https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows.

If you are a member of the IDTA workstream team, [create a feature branch] directly within the repository.

[create a feature branch]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-and-deleting-branches-within-your-repository

Otherwise, if you are a non-member contributor, fork the repository and create the feature branch in your forked repository. See [this Github tutorial] for more guidance. 

[this Github tutorial]: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork



**Branch Prefix**.
Please prefix the branch with your Github user name (*e.g.,* `my-user/Add-some-feature`).

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
Every PR must be linked to an issue for tracking.
See [this Github tutorial] for more guidance. 

[pull request]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request

[link PR to issue]: https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue

The discussion on the issue's content happends in the issue and not the PR. The discussion in the PR should focus on the reviewer's remarks.

## Pre-Merge Checks
**Continuous Integration.**
Github will run the continuous integration (CI) automatically through Github actions to verify that the submitted changes are valid.
Every pull request automatically runs the continuous integration with every update.

The continuous integration must be **successfully completed** with `All checks have passed` before proceeding with the approval process.


### Check Commit and Pull Request Messages
In accordance with Section "Recommendation for Commit Messages" the continuous integration checks the previously defined conditions.
For the present development, however, this is not enforced.

## Approval Process
All changes must be **reviewed** and **approved** by members of the IDTA workstream "Specification of the Asset Administration Shell".

Minor changes (simple failures, typos, *etc.*) and additional content (more examples, etc.) can be accepted straight away after a brief review by at least one responsible reviewers.

Major changes must first be presented and approved in the [IDTA] workstream "AAS in Detail". If the creator of a PR is not a member of the workstream, a dedicated assignee will present it.

[Platform Industrie 4.0]: http://www.plattform-i40.de
[IDTA]: https://industrialdigitaltwin.org/


## Merge into `main` Branch

After the approval, the pull request can be merged into the repository. This is done by one of the maintainers.  
Bugfixes might be collected together first and then be merged through one indivdual commit. Similarly, new features are first collected in defined minor/major release branches, and merged into the `main` at the time when the corresponding version of the specification is published.

*Note:* Changes into external resources, e.g. Swaggerhub, are done by the members of the IDTA workstream immediatly after the indivdual PRs have been merged. The leading source is always the content of this repository. 


## Post-Merge Cleanup
**Congratulation.**
You successfully contributed to the aas-spec-api repository.

If you are a member of the workstream team, please delete the feature branch you directly created within the aas-specs repository.

Otherwise, if you are not part of the team and you forked the repository, feel free to delete your fork.
