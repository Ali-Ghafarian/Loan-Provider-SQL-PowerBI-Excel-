# Loan Provider Analysis Project

## TL;DR
A comprehensive loan analysis system using SQL Server, Power BI, and Excel to analyze lending patterns, risk assessment, and portfolio performance. The project provides detailed insights through various KPIs across multiple dimensions including regional distribution, loan terms, and borrower characteristics.

## Overview and Business Insights

### Why This Analysis Matters
Bank loans are fundamental financial instruments that facilitate individual and business growth by providing access to necessary capital. This analysis serves a crucial role in understanding lending patterns, risk assessment, and portfolio performance to enable data-driven decision-making in loan operations.

### Project Scope
The project delivers a comprehensive loan report focusing on:

#### Key Performance Indicators (KPIs)
- **Total Loan Applications**
  - Overall volume tracking
  - Month-to-Date (MTD) monitoring
  - Month-over-Month (MoM) trend analysis

- **Financial Metrics**
  - Total Funded Amount (with MTD and MoM analysis)
  - Total Amount Received
  - Average Interest Rate trends
  - Average Debt-to-Income Ratio (DTI)

#### Multi-Dimensional Analysis
- Monthly Trends Discovery
- Regional Analysis
- Employee Length Impact
- Loan Term Analysis
- Purpose Analysis
- Good vs. Bad Loans Classification

*Note: For detailed information about data fields and their descriptions, please refer to the [Data Catalog](data_catalog.md).*

### Analysis Categories
The project breaks down loan performance across multiple dimensions:
1. **Geographic Distribution**: Regional lending patterns and risk assessment
2. **Temporal Analysis**: Monthly trends and seasonal patterns
3. **Borrower Profiles**: Employment length and stability analysis
4. **Loan Characteristics**: Term length and purpose analysis

## Methodology

The project follows a systematic approach starting with the establishment of a SQL Server database foundation for data storage and initial analysis. This database serves as the single source of truth, with its SQL-based analysis in Azure Data Studio notebooks providing comprehensive metrics calculation used for cross-validation of all subsequent visualizations. The final phase transforms these analytical insights into interactive visualizations using Power BI dashboards and Excel-based analysis, with each platform's results verified against the core SQL analysis to ensure data consistency and accuracy across all representations.

### SQL Server Implementation
| Component | Description |
|-----------|-------------|
| **DDL (Data Definition)** | • Database creation and configuration<br>• Schema design and implementation<br>• Table structures and constraints |
| **DML (Data Manipulation)** | • Table truncation for clean slate<br>• Bulk insert operations for efficient data loading<br>• Full load implementation |
| **DQL (Data Query)** | • Comprehensive metrics calculation<br>• Complex analytical queries<br>• Performance analysis implementations |
| **Functions & Features** | • Aggregation functions for KPI calculation<br>• Date handling for temporal analysis |

### Power BI Implementation
| Feature Category | Components |
|-----------------|------------|
| **Advanced DAX Development** | • Custom calculated measures and columns for complex metrics<br>• Calculated tables for enhanced analysis<br>• Design-specific DAX implementations |
| **Time Intelligence Features** | • TOTALMTD for Month-to-Date calculations<br>• DATESMTD for date range analysis<br>• DATEADD for period comparisons<br>• CALENDAR for custom date table creation |
| **Interactive Features** | • Field parameters for dynamic analysis<br>• Conditional formatting for visual insights<br>• Custom slicers for enhanced filtering<br>• Dynamic visualizations |

### Excel Implementation
| Feature Category | Components |
|-----------------|------------|
| **Data Processing** | • Power Query integration for data type transformations<br>• Data cleaning and standardization<br>• Custom column calculations |
| **Analysis Tools** | • Pivot tables for KPI calculations<br>• Pivot charts for visual analysis<br>• Dynamic dashboards |
| **Custom Features** | • Advanced cell formatting<br>• Interactive slicers<br>• Customized charts and visualizations<br>• Conditional formatting rules |

### Social Media
Connect with me on [LinkedIn: Ali Ghafarian - Data Analyst](www.linkedin.com/in/ali-ghafarian-data-analyst)