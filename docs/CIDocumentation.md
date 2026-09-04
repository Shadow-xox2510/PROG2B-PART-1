# Continuous Integration

The RaceDay repository uses GitHub Actions for continuous integration.

The workflow runs when changes are pushed to the main branch.

The CI process verifies:

- Required repository files exist.
- The SQL script contains all required database tables.
- Important SQL constraints are present.

A successful workflow run confirms that the repository structure passes the automated validation checks.