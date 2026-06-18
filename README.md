# NHP (New Hospital Programme) model project information

This code repository contains the code used to build a Quarto website for the NHP documentation which is hosted on 
the Strategy Unit Posit Connect.

## Releases

There are three workflows set up in GitHub to publish this documentation.

As it's updated a workflow publishes a [preview](https://connect.strategyunitwm.nhs.uk/nhp/project_information_preview/) 
on the Strategy Unit Posit Connect server. This is helpful to the team who have made the changes
to ensure they are working and to check readability in the published format
before release.

> The preview documentation site is created automatically from a Pull Request to the main branch in GitHub

Once a PR has been accepted with a merge to main the document can then be viewed
at a [development Posit Connect site](https://connect.strategyunitwm.nhs.uk/nhp/dev/project_information/)
so it's worth viewing this as a user of the documentation as these will reflect
accepted changes.

> The development documentation showing accepted changes (but not yet published) is created automatically by 
a merge to the main branch in GitHub

The final document available at the [Posit Connect site](https://connect.strategyunitwm.nhs.uk/nhp/project_information/)
is related closely to the [tagged releases](https://github.com/The-Strategy-Unit/nhp_project_information/releases).

> The published documentation is triggered by a tagged release being added to the GitHub code

Releases of the documentation are timed to coincide with the [NHP model](https://github.com/The-Strategy-Unit/nhp_model) 
releases. This is in terms of the time of release and not the versions which can be different.

## Versioning

The versioning used for the first two parts of the number reflect all NHP 
products (major and minor in Semantic Versioning terms) and the third number 
will reflect "patch releases" connected with the repository. For documentation
this may be edits or updates to the text.

## Contact

If you have any queries, corrections or additional information requests you can 
[raise an issue](https://github.com/The-Strategy-Unit/nhp_project_information/issues/new) 
or [contact the team](mailto:mlcsu.su.datascience@nhs.net).
