# Welcome to Radio Data Service

Holding page and layout for RDS.

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
        RdsAdminMvc      # Rds Admin MVC written in C#
        RdsAAdminApi     # Rds Admin API written in Swagger OpenAPI
        RdsPubicMvc      # Rds Public WebMVC
        RdsPublicApi     # Rds Public API
