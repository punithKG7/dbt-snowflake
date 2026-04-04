# DBT Snowflake Project

A modern, scalable dbt project configured for Snowflake data warehousing.

## Project Structure

```
dbt_snowflake_project/
├── models/
│   ├── staging/          # Raw data transformations
│   └── marts/            # Business-ready analytics tables
├── tests/                # dbt tests (singular and generic)
├── macros/               # Custom dbt macros and Jinja templates
├── snapshots/            # Type-2 slowly changing dimensions
├── seeds/                # Reference data and CSV files
├── analysis/             # Ad-hoc analysis queries
├── data/                 # Input data files
├── dbt_project.yml       # Project configuration
├── profiles.yml          # Snowflake connection config
├── packages.yml          # dbt package dependencies
└── README.md             # This file
```

## Prerequisites

- Python 3.8+
- dbt-core >= 1.0
- dbt-snowflake package
- Git

## Installation

### 1. Install dbt

```bash
pip install dbt-snowflake
```

### 2. Configure Snowflake Connection

Update `profiles.yml` with your Snowflake credentials:

```yaml
dbt_snowflake:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: xy12345.us-east-1
      user: your_username
      password: your_password
      role: TRANSFORMER
      database: ANALYTICS
      schema: PUBLIC
      warehouse: TRANSFORMING
      threads: 4
      client_session_keep_alive: False
```

**Note:** Place `profiles.yml` in `~/.dbt/` directory (not in the project root for security).

### 3. Clone and Setup

```bash
git clone <repository-url>
cd dbt_snowflake_project
dbt deps          # Install dbt packages
dbt debug         # Test connection
```

## Usage

### Running Models

```bash
# Run all models
dbt run

# Run specific model
dbt run --select model_name

# Run models in a specific path
dbt run --select path:models/staging
```

### Testing

```bash
# Run all tests
dbt test

# Run specific test
dbt test --select test_name
```

### Building Documentation

```bash
# Generate documentation
dbt docs generate

# Serve documentation
dbt docs serve
```

### Seeds

```bash
# Load CSV data into warehouse
dbt seed

# Reload specific seed
dbt seed --select seed_name
```

### Snapshots

```bash
# Create type-2 slowly changing dimensions
dbt snapshot
```

## Development Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### 2. Create Models

Place `.sql` files in `models/staging/` or `models/marts/`:

```sql
-- models/staging/stg_customers.sql
{{ config(
    materialized='view',
    schema='staging'
) }}

select
    customer_id,
    customer_name,
    email
from {{ source('raw_data', 'customers') }}
```

### 3. Add Tests

Create tests in `tests/` directory:

```sql
-- tests/assert_customer_id_not_null.sql
select *
from {{ ref('stg_customers') }}
where customer_id is null
```

### 4. Commit and Push

```bash
git add .
git commit -m "Add customer staging model"
git push origin feature/your-feature-name
```

### 5. Create Pull Request

Create a PR and ensure all tests pass before merging.

## Directory Details

### models/staging
Raw data transformations that clean and normalize source data. Use views for staging models.

### models/marts
Business-ready analytics tables. Use tables for marts to improve query performance.

### tests
Include both generic tests (not_null, unique, relationships) and singular tests for custom business logic.

### macros
Custom Jinja functions for reusable transformation logic.

### snapshots
Track changes in dimension tables over time using type-2 slowly changing dimensions.

### seeds
CSV files for reference data (e.g., country codes, lookup tables).

### analysis
Ad-hoc analysis queries that don't become part of the data warehouse.

## Configuration

### dbt_project.yml

- `name`: Project name (lowercase, underscores)
- `version`: Project version
- `profile`: Profile name to use (matches profiles.yml)
- `model-paths`, `test-paths`, etc.: Directory paths for different artifact types

### Key Variables

Variables can be set in `dbt_project.yml` or via command line:

```bash
dbt run --vars '{"environment": "prod"}'
```

## Best Practices

1. **Naming Conventions:**
   - Models: lowercase with underscores (e.g., `stg_customers`)
   - Tests: descriptive names (e.g., `assert_orders_positive_amount`)
   - Sources: singular table names (e.g., `customers`, not `customer`)

2. **Lineage:**
   - Staging models should use sources
   - Mart models should use refs to staging models
   - Keep dependencies clear and traceable

3. **Testing:**
   - Test all sources
   - Test primary keys with unique + not_null
   - Test relationships between tables

4. **Performance:**
   - Use views for staging models
   - Use tables for marts
   - Use materialized views for complex aggregations
   - Configure warehouse size appropriately

5. **Security:**
   - Never commit `profiles.yml` to version control
   - Use environment variables for credentials
   - Store sensitive data in seed files with appropriate permissions

## Snowflake-Specific Tips

### Dynamic Table Materialization

```sql
{{ config(materialized='dynamic_table') }}
```

### Using Snowflake Functions

```sql
select
    customer_id,
    {{ dbt_utils.surrogate_key(['customer_id', 'email']) }} as customer_key
```

### Row Access Policies

Configure row-level security directly in Snowflake and dbt will respect it.

## Troubleshooting

### Connection Issues

```bash
dbt debug
```

Check your:
- Snowflake account ID
- User credentials
- Role permissions
- Warehouse status

### Model Failures

```bash
dbt run --debug
```

Check the debug logs in `target/` directory.

## Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Snowflake Plugin](https://docs.getdbt.com/reference/warehouse-setups/snowflake-setup)
- [dbt Best Practices](https://docs.getdbt.com/guides/best-practices)
- [Snowflake Documentation](https://docs.snowflake.com/)

## Contributing

1. Create a feature branch
2. Make your changes
3. Run `dbt test` locally
4. Commit with clear messages
5. Push and create a Pull Request

## License

This project is licensed under the MIT License - see LICENSE file for details.

## Contact

For questions or issues, please create a GitHub issue or contact the data engineering team.
