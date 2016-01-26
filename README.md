# moray-etl-jsonb  

Created by Christopher Hogue.

# Overview

This repo contains methodology to refactor via extract-transform-load
a Moray JSON bucket into a set of PostGreSQL 9.4 SQL tables employing:
   
   JSONB indexing 
   <https://www.postgresql.org/docs/9.4/static/datatype-json.html>

   Power Schema analysis to optimize SQL edge-case behavior.
   


# Repository

    deps/
    docs/           Docs and Power Schema Description
    lib/            Source files.
    test/           Test data 
    measure/        Scripts to evaluate JSON for tag classification
    tools/          Miscellaneous dev/upgrade/deployment tools and data.
    Makefile
    package.json    npm module info (holds the project version)
    README.md


# Overview

Refactoring involves a JSON measurement phase, a table/tag classification phase,
a Postgres dump file split, and reload into Postgres 9.4.


# Usage

Note: Current writeup  here is **incomplete**.



# Development

To run tools:

   tbd

To refactor a new Moray JSON bucket:

   tbd
 
To update the guidelines, edit "docs/index.restdown" and run `make docs`
to update "docs/index.html".

Before commiting/pushing run `make prepush` and, if possible, get a code
review.


# Testing

    make test

If you project has setup steps necessary for testing, then describe those
here.


