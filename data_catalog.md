# Data Catalog

| Column Name | Data Type | Description |
|------------|-----------|-------------|
| id | INT | A unique identifier assigned to each loan application or loan account. Serves as a primary key for tracking and managing individual loans. Loan providers use it to efficiently manage and track loans throughout their lifecycle. |
| address_state | CHAR(2) | Indicates the borrower's location. Helps in assessing regional risk factors, compliance with state regulations, and estimating default probabilities. Loan providers use this to identify regional trends and manage risk portfolios. |
| emp_length | VARCHAR(20) | Provides insights into the borrower's employment stability. Longer employment durations may indicate greater job security. Loan providers consider this when assessing a borrower's ability to repay. |
| emp_title | VARCHAR(100) | Specifies the borrower's occupation or job title. Loan providers use this to verify income sources, assess financial capacity, and tailor loan offers to different professions. |
| grade | CHAR(1) | Represents a risk classification based on creditworthiness. Higher grades signify lower risk. Loan providers use this to price loans and manage risk. |
| sub_grade | VARCHAR(2) | Refines the risk assessment within a grade. Loan providers use sub-grades to tailor interest rates and lending terms to match borrower risk profiles. |
| home_ownership | VARCHAR(20) | Indicates the borrower's housing status, offering insights into financial stability. Loan providers use this to assess collateral availability and borrower stability. |
| issue_date | VARCHAR(50) | Marks the loan's origination date. Loan providers use this to track loan aging, calculate interest accruals, and manage loan portfolios. |
| last_credit_pull_date | VARCHAR(50) | Records when the borrower's credit report was last accessed. Loan providers use this to track credit history updates and assess credit risk. |
| last_payment_date | VARCHAR(50) | Marks the most recent loan payment received. Loan providers use this to assess payment behavior and calculate delinquency. |
| loan_status | VARCHAR(50) | Indicates the current state of the loan. Loan providers use this to monitor loan health and determine provisioning requirements. |
| next_payment_date | VARCHAR(50) | Estimates the date of the next loan payment. Loan providers use this for liquidity planning and revenue projection. |
| purpose | VARCHAR(50) | Specifies the reason for the loan. Loan providers use this to segment and customize loan offerings. |
| term | VARCHAR(20) | Defines the duration of the loan in months. Loan providers use this to structure loan agreements and manage loan maturities. |
| verification_status | VARCHAR(50) | Indicates whether the borrower's financial information has been verified. Loan providers use this to gauge data reliability. |
| annual_income | DECIMAL(15,2) | Reflects the borrower's total yearly earnings. Loan providers use this to determine loan eligibility and calculate debt-to-income ratios. |
| dti | DECIMAL(10,4) | Measures the borrower's debt burden relative to income. Loan providers use this to assess a borrower's ability to handle loan payments. |
| installment | DECIMAL(15,2) | The fixed monthly payment amount for loan repayment. Loan providers use this to structure loan terms and assess payment affordability. |
| int_rate | DECIMAL(6,4) | Represents the annual cost of borrowing as a percentage. Loan providers use this to price loans and manage profit margins. |
| loan_amount | INT | The total borrowed sum defining the principal amount. Loan providers use this to determine loan size and risk exposure. |
| total_acc | INT | Total number of accounts the borrower has. |
| total_payment | INT | Total amount paid towards the loan. |
| application_type | VARCHAR(50) | Type of loan application submitted. |
| member_id | INT | Unique identifier for the loan provider member/customer. |

Note: Some date columns (issue_date, last_payment_date, next_payment_date, last_credit_pull_date) are initially stored as VARCHAR(50) but are converted to DATE type through a stored procedure as shown in the DDL.