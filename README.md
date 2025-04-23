# DTS reusable components

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository serves as a central collection point for reusable components,
libraries, infrastructure modules, and scripts developed and used by DTS-STN.

The aim is to promote code sharing, reduce duplication, and standardize common
patterns across various projects within the organization.

## Repository structure

The repository is *mainly* organized into the following top-level directories:

* **`apps/`**: standalone applications that are built and deployed
  independently, but might be reusable or serve as examples
* **`infra/`**: reusable infrastructure-as-code modules, configuration snippets,
  or templates (eg., terraform, terragrunt)
* **`libs/`**: general-purpose code libraries and modules
* **`scripts/`**: various utility scripts for development, deployment, or
  maintenance tasks

## Getting started

To use a specific component from this repository, navigate to its respective
directory in `apps/`, `libs/`, `infra/`, etc. Each component should ideally
contain its own `README.md` with specific instructions on installation, usage,
and configuration.

## Libraries

This section lists reusable code libraries available within this repository,
primarily found under the `libs/` directory.

| Package                                        | Description                                               |
| ---------------------------------------------- | --------------------------------------------------------- |
| [health-checks](libs/javascript/health-checks) | Simple server-side health checks in a NodeJS application. |

## Licenses

Unless specified differently within a specific directory or package, all content
within this repository is licensed under the [MIT license](LICENSE).

| Package                                        | License                                                   |
| ---------------------------------------------- | --------------------------------------------------------- |
| [health-checks](libs/javascript/health-checks) | [MIT](libs/javascript/health-checks/LICENSE.md)           |
