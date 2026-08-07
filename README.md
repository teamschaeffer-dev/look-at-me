# LookML Development

Welcome to the **Look at Me** LookML repository!

## Overview

LookML (Looker Modeling Language) is a SQL-abstracted modeling language used in Looker to construct semantic data models. It allows data teams to define dimensions, measures, calculations, and relationships between datasets in a version-controlled environment.

## Key Concepts

- **Projects**: A collection of model, view, and dashboard files managed via Git.
- **Views**: Define field-level metadata, dimensions (attributes), and measures (aggregations) corresponding to underlying database tables or derived queries.
- **Models**: Define the database connection and declare **Explores** by specifying joins and access relationships between views.
- **Explores**: The interactive query surfaces presented to end users for ad-hoc analysis and dashboard creation.

## Getting Started

1. **Development Mode**: Toggle on Development Mode in Looker to make changes.
2. **Git Workflow**: Create a feature branch, make modifications, validate LookML, and submit a pull request for code review.
3. **Validation**: Use Looker's built-in LookML Validator before committing changes.
