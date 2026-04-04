#!/bin/bash

# DBT Snowflake Project Setup Script
# This script sets up the development environment

set -e

echo "🚀 Starting DBT Snowflake Project Setup..."

# Create virtual environment
echo "📦 Creating Python virtual environment..."
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Upgrade pip
echo "🔄 Upgrading pip..."
pip install --upgrade pip setuptools wheel

# Install dbt-snowflake
echo "📥 Installing dbt-snowflake..."
pip install dbt-snowflake

# Install additional useful packages
echo "📥 Installing additional packages..."
pip install dbt-expectations dbt-utils

# Test dbt installation
echo "✅ Testing dbt installation..."
dbt --version

echo ""
echo "✨ Setup complete! Next steps:"
echo ""
echo "1. Activate the virtual environment:"
echo "   source venv/bin/activate"
echo ""
echo "2. Set your Snowflake password:"
echo "   export DBT_SNOWFLAKE_PASSWORD='your_password'"
echo ""
echo "3. Test the connection:"
echo "   dbt debug"
echo ""
echo "4. Install dbt packages:"
echo "   dbt deps"
echo ""
echo "5. Run dbt models:"
echo "   dbt run"
echo ""
