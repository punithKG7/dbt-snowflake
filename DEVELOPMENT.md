# Development Setup

## Local Development Prerequisites

1. **Python Virtual Environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install Dependencies**
   ```bash
   pip install dbt-snowflake
   pip install dbt-core==1.7.0
   ```

3. **Configure Snowflake Connection**
   - Copy `profiles.yml` template
   - Store in `~/.dbt/profiles.yml` (not in repo!)
   - Update with your Snowflake credentials

4. **Test Connection**
   ```bash
   dbt debug
   ```

## Common Commands

| Command | Description |
|---------|-------------|
| `dbt run` | Execute all models |
| `dbt test` | Run all tests |
| `dbt seed` | Load seed data |
| `dbt debug` | Test warehouse connection |
| `dbt docs generate` | Generate documentation |
| `dbt docs serve` | Serve docs locally |
| `dbt parse` | Parse project without executing |

## Deployment

### Dev Environment
```bash
dbt run --target dev --profiles-dir ~/.dbt
dbt test --target dev
```

### Prod Environment
```bash
dbt run --target prod --profiles-dir ~/.dbt
dbt test --target prod
```

## Environment Variables

Set these for secure credential management:

```bash
export DBT_SNOWFLAKE_ACCOUNT=<account_id>
export DBT_SNOWFLAKE_USER=<username>
export DBT_SNOWFLAKE_PASSWORD=<password>
export DBT_SNOWFLAKE_ROLE=<role>
export DBT_SNOWFLAKE_DATABASE=<database>
```

Then update `profiles.yml` to use these variables.

## Pull Request Process

1. Create feature branch: `git checkout -b feature/description`
2. Make changes and test locally
3. Push: `git push origin feature/description`
4. Create Pull Request
5. Ensure CI/CD pipeline passes
6. Get code review approval
7. Merge to main

## Notes

- Never commit `profiles.yml` to version control
- Always test models before pushing
- Write tests for new models
- Update documentation when adding features
