# README

This repo contains project information for the New Hospital Programme (NHP) model in a Quarto website.

## Releases

Published (tagged) releases of this site are automatically deployed at [connect.strategyunitwm.nhs.uk/nhp/project_information](https://connect.strategyunitwm.nhs.uk/nhp/project_information/).

[Release notes](https://github.com/The-Strategy-Unit/nhp_project_information/releases) are provided.

Development releases [are also available](https://connect.strategyunitwm.nhs.uk/nhp_dev/project_information/).

## Contact

If you have any queries or additional information requests you can [raise an issue](https://github.com/The-Strategy-Unit/nhp_project_information/issues/new) or [contact the team](mailto:mlcsu.nhpanalytics@nhs.net).

## Developers

Some data is fetched from an Azure container.
To access it, you need to create a local `.Renviron` file in the project root that copies the keys from `.Renviron.example`.
If you're a member of the Strategy Unit, you can contact the Data Science team for the corresponding values.
We authenticate with the Azure container using SAS tokens, which expire after 1 month.
If the GitHub action fails due to an authentication error, you will need to run `update_secrets.ps1` in your terminal.
Note that you will need to have [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows) and the [gh CLI](https://cli.github.com/) installed and set up for this script to work.
You may need to run `az login` to authenticate with Azure before running the script.
