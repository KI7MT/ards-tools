# Amateur Radio Data Service PostgreSQL

PostgreSQL data store for Amateur Radio Data. Includes ADIF Spec Enumeration,
LoTW, eSQL, and More. Manage by CLI, WebMVC, and Swagger OpenAPI.  

The ARDS project is a culmination of several frameworks and languages: 
PostgreSQL, Python, C#, shell scripts, and more. While pulling the elements
together, the SQL scripts will function as intended, however, the parent
management tool may not.

## Under Construction

This repository is under development, and is not in a stable installation state.

## Documentation

Project documentation will be hosted on `Github.io` when available.

## Project Layout

    docs/
      index.md           # The documentation homepage.
      ...                # Other markdown pages, images and other files.
    src
      batch              # Windows batch scripts
      bash               # Linux bash scripts
      python
          rds-dbutils    # database connection and setup tools
          rds-lotw       # LoTW activity management
          rds-adif       # ADIF specification enumeration data
          rds-esql       # eSQL activity management
          rds-alltext    # WSJT-X all-text update, search, post, query
          rds-fab3       # server setup scripts using Python Fabric3
      dotnet-core
        RdsAdminMvc      # Rds Admin MVC written in Net Core
        RdsAAdminApi     # Rds Admin API written in Swagger OpenAPI
        RdsPubicMvc      # Rds Public WebMVC
        RdsPublicApi     # Rds Public API
