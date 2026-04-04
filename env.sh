#!/bin/bash

# Required Environment Variables for Snowflake Connection

# Snowflake Account (from profile)
export DBT_SNOWFLAKE_ACCOUNT="BCOPEBF-DC53037"

# Snowflake Username
export DBT_SNOWFLAKE_USER="PUNIKG"

# Snowflake Role (default: ACCOUNTADMIN)
export DBT_SNOWFLAKE_ROLE="ACCOUNTADMIN"

# Snowflake Database (default: ANALYTICS)
export DBT_SNOWFLAKE_DATABASE="ANALYTICS"

# Snowflake Warehouse (default: COMPUTE_WH)
export DBT_SNOWFLAKE_WAREHOUSE="COMPUTE_WH"

# Snowflake Password - ADD YOUR PASSWORD HERE
# export DBT_SNOWFLAKE_PASSWORD="your_password_here"

# dbt Target (dev or prod)
# export DBT_TARGET="dev"

echo "✅ Environment variables loaded"
echo "⚠️  Make sure to set DBT_SNOWFLAKE_PASSWORD before running dbt commands"
