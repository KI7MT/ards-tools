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
      index.md            # The documentation homepage.
      ...                 # Other markdown pages, images and other files.
    src
      batch               # Windows batch scripts
      bash                # Linux bash scripts
      dotnet-core
        ARdsAdminMvc      # ARds Admin MVC written in Net Core
        ARdsAdminApi      # ARds Admin API written in Swagger OpenAPI
        ARdsPubicMvc      # ARds Public WebMVC
        ARdsPublicApi     # ARds Public API
      pgsql               # Raw PostgreSQL Scripts and CSV Data Files
      python
          ards-dbutils    # database connection and setup tools
          ards-lotw       # LoTW activity management
          ards-adif       # ADIF specification enumeration data
          ards-esql       # eSQL activity management
          ards-alltext    # WSJT-X all-text update, search, post, query
          ards-fab3       # server setup scripts using Python Fabric3

