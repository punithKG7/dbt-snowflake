# GitHub Actions Setup Guide

## CI/CD Pipeline Configuration

This project includes automated testing via GitHub Actions. Follow these steps to set it up:

### 1. Add GitHub Secrets

Go to your GitHub repository → **Settings** → **Secrets and variables** → **Actions**

Add the following secrets:

| Secret Name | Value | Description |
|-------------|-------|-------------|
| `SNOWFLAKE_ACCOUNT` | `BCOPEBF-DC53037` | Your Snowflake account ID |
| `SNOWFLAKE_USER` | `PUNIKG` | Your Snowflake username |
| `SNOWFLAKE_PASSWORD` | Your password | Your Snowflake password |
| `SNOWFLAKE_ROLE` | `ACCOUNTADMIN` | Your Snowflake role |
| `SNOWFLAKE_DATABASE` | `ANALYTICS` | Target database |
| `SNOWFLAKE_WAREHOUSE` | `COMPUTE_WH` | Target warehouse |

### 2. Create Profiles File in Actions

The GitHub Actions workflow will automatically create a `profiles.yml` file with your secrets.

### 3. Configure Repository Settings

1. **Branch Protection**: Go to **Settings** → **Branches** → Add rule for `main` branch
   - Require status checks to pass before merging
   - Require branches to be up to date

2. **Pull Request Template**: Create `.github/pull_request_template.md`

### 4. Workflow Details

The `dbt-test.yml` workflow:
- ✅ Runs on every push to any branch
- ✅ Runs on pull requests
- ✅ Tests dbt models with Snowflake
- ✅ Fails if tests don't pass (prevents bad code from merging)

### 5. Local Testing Before Push

Always test locally before pushing:

```bash
# Activate environment
source venv/bin/activate

# Set password
export DBT_SNOWFLAKE_PASSWORD="your_password"

# Test parse
dbt parse

# Run tests
dbt test

# Run models
dbt run
```

### 6. View Workflow Results

After pushing, check the **Actions** tab in your GitHub repo to see:
- ✅ Build status
- 📊 Test results
- 🐛 Any failures with full logs

### 7. Advanced: Matrix Builds

To test against multiple dbt versions:

```yaml
strategy:
  matrix:
    dbt-version: ['1.7.0', '1.8.0', '1.9.0']

steps:
  - name: Install dbt
    run: pip install dbt-snowflake==${{ matrix.dbt-version }}
```

### 8. Advanced: Scheduled Runs

To run tests daily:

```yaml
on:
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM UTC
```

## Troubleshooting

### "Authentication failed"
- Verify secrets are set correctly in GitHub
- Check Snowflake credentials are valid
- Ensure warehouse is active

### "Cannot find module"
- Check all dbt_utils imports
- Run `dbt deps` locally

### "Test failed"
- Check dbt logs in Actions output
- Reproduce locally with `dbt test --debug`

## Best Practices

1. **Never commit sensitive data** - Always use secrets for credentials
2. **Test before merging** - Local tests catch issues early
3. **PR reviews** - Always review code before merging
4. **Documentation** - Update README when changing models
5. **Version control** - Tag releases with versions
