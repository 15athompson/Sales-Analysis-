# Sales-Analysis-

●	Developed an interactive Power BI dashboard to analyze internet sales data for a company. The dashboard provides a comprehensive overview of sales performance, allowing users to filter data by customers and products. It includes various visualisations such as graphs and KPIs to track sales against budget, helping to identify top-selling products and high-value customers. The data is updated daily, ensuring timely and accurate insights for decision-making.



<img width="861" height="488" alt="image" src="https://github.com/user-attachments/assets/d68f7b9e-4427-46f3-914c-709dbd1b8df7" />



# Power BI Sales Analytics Dashboard

## Project Overview

This project delivers a comprehensive business intelligence solution for internet sales reporting and analysis, addressing critical business demands for enhanced sales visibility and performance tracking. The solution transforms traditional Excel-based budgeting processes into dynamic, interactive Power BI dashboards that enable data-driven decision-making across sales teams.

## Business Context & Requirements

**Stakeholder**: Steven (Sales Manager)  
**Primary Objective**: Implementation of visual dashboards and improved sales reporting capabilities for enhanced sales force effectiveness

### Core Business Requirements

The solution addresses four key user stories with defined acceptance criteria:

| User Story | Role | Requirement | Business Value | Acceptance Criteria |
|------------|------|-------------|----------------|-------------------|
| 1 | Sales Manager | Dashboard overview of internet sales | Enhanced customer and product performance tracking | Power BI dashboard with daily data refresh |
| 2 | Sales Representative | Detailed customer-focused sales analysis | Improved customer follow-up and cross-selling opportunities | Interactive dashboard with customer filtering capabilities |
| 3 | Sales Representative | Product-centric sales performance view | Identification of top-performing products | Dashboard with product-level filtering and analysis |
| 4 | Sales Manager | Sales performance against budget tracking | Temporal sales analysis with budget comparison | Dashboard featuring KPIs, graphs, and budget variance analysis |

## Technical Architecture

### Data Sources
- **Primary Database**: AdventureWorksDW2019 (SQL Server)
- **Legacy Systems**: Excel-based budgets (2021 baseline)
- **Target Platform**: Power BI with CRM system integration

### Data Model Components

#### Dimension Tables
- **DIM_Calendar**: Comprehensive date dimension with hierarchical time periods
- **DIM_Customer**: Customer master data with demographic segmentation
- **DIM_Products**: Product hierarchy with categorization and attributes

#### Fact Tables
- **FACT_InternetSales**: Transactional sales data with comprehensive metrics

## Database Schema & Data Transformations

### 1. Calendar Dimension (DIM_Calendar)
```sql
-- Comprehensive date dimension supporting temporal analysis
SELECT 
  [DateKey], [FullDateAlternateKey] AS Date,
  [EnglishDayNameOfWeek] AS Day,
  [WeekNumberOfYear] AS WeekNr,
  [EnglishMonthName] AS Month,
  LEFT([EnglishMonthName], 3) AS MonthShort,
  [MonthNumberOfYear] AS MonthNo,
  [CalendarQuarter] AS Quarter,
  [CalendarYear] AS Year
FROM [AdventureWorksDW2019].[dbo].[DimDate]
WHERE CalendarYear >= 2019
```

**Key Features:**
- Multi-granular time hierarchies (Day → Week → Month → Quarter → Year)
- Standardised date formats for consistent reporting
- Historical data coverage from 2019 onwards

### 2. Customer Dimension (DIM_Customer)
```sql
-- Enhanced customer profiling with geographic integration
SELECT 
  c.customerkey AS CustomerKey,
  c.firstname AS [FirstName],
  c.lastname AS [LastName],
  c.firstname + ' ' + lastname AS [Full Name],
  CASE c.gender WHEN 'M' then 'Male' WHEN 'F' THEN 'Female' END AS Gender,
  c.datefirstpurchase AS DateFirstPurchase,
  g.city AS [Customer City]
FROM dbo.dimcustomer AS c
LEFT JOIN dbo.dimgeography AS g ON g.geographykey = c.geographykey
```

**Key Features:**
- Consolidated customer identifiers and demographics
- Geographic segmentation through city-level data
- Customer lifecycle tracking via first purchase dates
- Standardised gender classifications for analytical consistency

### 3. Product Dimension (DIM_Products)
```sql
-- Hierarchical product categorisation with status management
SELECT 
  p.ProductKey, p.ProductAlternateKey AS ProductItemCode,
  p.EnglishProductName AS ProductName,
  ps.EnglishProductSubcategoryName AS SubCategory,
  pc.EnglishProductCategoryName AS CategoryName,
  p.Color AS ProductColor, Size AS ProductSize,
  p.ProductLine, p.ModelName AS ProductModelName,
  p.EnglishDescription AS ProductDescription,
  ISNULL (p.Status, 'Outdated') AS ProductStatus
FROM dbo.DimProduct AS p
LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
LEFT JOIN dbo.DimProductCategory AS pc ON pc.ProductCategoryKey = ps.ProductCategoryKey
```

**Key Features:**
- Three-tier product hierarchy (Category → Subcategory → Product)
- Comprehensive product attributes (colour, size, line, model)
- Data quality enhancement through NULL value management
- Product lifecycle status tracking

### 4. Internet Sales Fact Table (FACT_InternetSales)
```sql
-- Optimised sales fact table with temporal constraints
SELECT 
  ProductKey, OrderDateKey, DueDateKey, ShipDateKey,
  CustomerKey, SalesOrderNumber, SalesAmount
FROM dbo.FactInternetSales
WHERE LEFT (OrderDateKey, 4) >= YEAR(GETDATE()) -2
ORDER BY OrderDateKey ASC
```

**Key Features:**
- Automated data freshness (rolling 2-year window)
- Comprehensive order lifecycle tracking (Order → Due → Ship dates)
- Direct integration with dimension tables via foreign keys
- Optimised for analytical performance

## Data Quality & Governance

### Data Cleansing Strategies
1. **NULL Value Management**: Systematic replacement of NULL status values with 'Outdated' classification
2. **Standardisation**: Consistent naming conventions across all dimension tables
3. **Data Validation**: Temporal constraints ensuring data relevance and accuracy
4. **Referential Integrity**: Comprehensive LEFT JOIN strategies preserving data completeness

### Performance Optimisation
- **Indexing Strategy**: Primary key ordering for enhanced query performance
- **Data Filtering**: Automated temporal filtering reducing dataset size
- **Join Optimisation**: Strategic LEFT JOIN implementation minimising data loss

## Dashboard Specifications

### Refresh Requirements
- **Frequency**: Daily automated refresh
- **Data Latency**: Maximum 24-hour delay from source systems
- **Availability**: 99.5% uptime target during business hours

### Filtering Capabilities
- **Customer-Level Analysis**: Dynamic customer selection and comparison
- **Product-Level Analysis**: Multi-dimensional product filtering
- **Temporal Analysis**: Flexible date range selection with preset periods
- **Geographic Segmentation**: City-level customer analysis

### KPI Framework
- **Sales Performance Metrics**: Revenue, volume, growth rates
- **Customer Analytics**: Acquisition, retention, lifetime value
- **Product Performance**: Category analysis, bestseller identification
- **Budget Variance Analysis**: Actual vs. budget with variance indicators

## Implementation Considerations

### Data Integration Points
1. **Power BI Service**: Primary visualisation and report distribution platform
2. **CRM Integration**: Bidirectional data flow for comprehensive customer insights
3. **Excel Compatibility**: Legacy budget data integration and migration pathway

### Scalability Framework
- **Data Volume**: Architecture supports exponential growth in transaction volumes
- **User Concurrency**: Multi-user access with role-based security implementation
- **Geographic Expansion**: Extensible geographic dimension supporting global operations

## Future Enhancement Opportunities

### Advanced Analytics Integration
- **Predictive Modelling**: Customer churn prediction and product demand forecasting
- **Machine Learning**: Automated anomaly detection in sales patterns
- **Advanced Segmentation**: RFM analysis and customer clustering algorithms

### Extended Data Sources
- **Social Media Integration**: Social listening for market sentiment analysis
- **External Market Data**: Industry benchmarking and competitive intelligence
- **IoT Integration**: Product usage data for enhanced lifecycle management

## Technical Dependencies

### Software Requirements
- **SQL Server**: AdventureWorksDW2019 database
- **Power BI Desktop**: Development environment
- **Power BI Service**: Production deployment platform
- **Excel**: Legacy system integration and ad-hoc analysis

### Security Considerations
- **Row-Level Security**: Customer and territory-based data access controls
- **Role-Based Access**: Differentiated permissions for managers and representatives
- **Data Privacy**: GDPR compliance for customer demographic information

## Project Deliverables

1. **Dimensional Data Model**: Fully normalised star schema with optimised relationships
2. **ETL Documentation**: Comprehensive data transformation specifications
3. **Power BI Dashboard Suite**: Four interconnected dashboards addressing all user stories
4. **User Training Materials**: Role-specific guidance for dashboard utilisation
5. **Technical Documentation**: Complete system architecture and maintenance procedures

## Success Metrics

### Quantitative Measures
- **Data Accuracy**: 99.9% consistency between source systems and dashboards
- **Performance**: Sub-3-second dashboard load times
- **Adoption Rate**: 95% active user engagement within 30 days of deployment

### Qualitative Outcomes
- **Decision-Making Enhancement**: Improved strategic planning through data-driven insights
- **Operational Efficiency**: Reduced time-to-insight from hours to minutes
- **Stakeholder Satisfaction**: Enhanced user experience and analytical capability

---

*This project demonstrates the application of modern business intelligence principles to transform traditional reporting processes into dynamic, interactive analytics platforms that drive organisational performance and strategic decision-making.*
