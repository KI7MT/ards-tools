# Amateur Radio Data Service Tools

>NOTE: This page is under heavy revision. Expect things to change at rapid
>pace.

## Page Index

* [Overview](#overview)
* [Usability](#usability)
* [System Requirements](#system-requirements)
* [Bug Reports](#bug-reports)

## Overview

The Amateur Radio Data Service Tools (ARDS) project aims to provide radio
amateurs with a scalable set of end-points for data access. As the project
grows, so shall this section of the `ards-tools`

The conceptual components can be broken down into three basic areas during
development, and the order of work:

* Data Store (PostgreSQL, MongoDB, Redis, other Data Stores)
* Optional Command Line Tools
* Application API (JSON/JSONB/XML) RESt Endpoints
* Web MVC for administration.

The current focus is on Data Storage, solidifying base models,
draft API concepts, and measure initial performance across various host platforms.

## Usability

At the time of this writing, all example applications are being tested on:

* Window-10 build 17134 x86_64
* [Windows Subsystem Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about)
* Linux Native [Ubuntu 18.04](http://releases.ubuntu.com/18.04/)

## System Requirements

* Supported Operating Systems: `Windows`, `Linux`, `MacOS`
* [Net Core SDK v2.2+](https://dotnet.microsoft.com/download)
* [VS Code Editor](https://code.visualstudio.com/) is optional but preferred
* [PostgreSQL v11.2+](https://ki7mt.github.io/jtsdk-tools/windows/Install-PostgreSQL/#optional-install-postgresql)
* [Python 3.5+](https://ki7mt.github.io/jtsdk-tools/windows/Install-Python/#install-anaconda-python)
* Dual Core CPU
* At Least 2GB RAM
* 10 GB of Free disk space (minimum)

>IMPORTANT: The `PostgreSQL Install Instructions` list 10.6 as the version of
>of choice. However, `ards-tools` requires version 11.0 or better to facilitate
>[Store Procedures](https://www.postgresql.org/docs/11/sql-createprocedure.html).

## Bug Reports

If you have problems with setting things up, or any of the steps in this brief guide,
please file a [Bug Report](https://github.com/KI7MT/dotnet-core-examples/issues)
on the Github Issue Tracker.

[Install Anaconda Python]: https://ki7mt.github.io/jtsdk-tools/windows/Install-Python/#install-anaconda-python