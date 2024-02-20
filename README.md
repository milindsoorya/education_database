# Education Data Quality and Analysis

This project aims to enhance data quality and facilitate the analysis of educational data stored in `educationDb`, a MySQL database. It encompasses SQL scripts for initializing database structures, data analysis queries, a jupyter notebook for data preparation (`dataPrep.ipynb`), and a Streamlit application for interactive data quality assessments and analytics. Utilizing MySQL Community Edition for database management, DBeaver for database interactions and CSV uploads, and Pandas for data manipulation, this project ensures dates are formatted correctly for MySQL compatibility.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You'll need to install:

-   **MySQL Community Edition**: For database management.
-   **Python 3.x**: Necessary for executing the data preparation script and the Streamlit application.
-   **Pandas**: Used for Python-based data manipulation.
-   **Streamlit**: Required for the interactive dashboard. 

### Installation and Setup

#### Database Setup

1. Install MySQL Community Edition on your machine.
2. Connect to your MySQL instance using DBeaver or another preferred SQL client.
3. Execute the `sql/01_create_tables.sql` script to create the database schema.

#### Data Preparation

1. Store your CSV files in a designated directory.
2. Run `python/dataPrep.ipynb` to format the data suitably for database insertion.

#### Data Upload

1. Leverage DBeaver's import feature to load the formatted CSV data into the corresponding database tables.

#### Query Execution

1. Open `sql/02_queries.sql` with DBeaver.
2. Run the queries to perform data analysis as required by the project objectives.

#### Python Script Execution

1. Run `python/dataQualityCheck.py` to examine `UserOnlineHistory.csv` for potential data quality issues, outputting findings into separate CSV files.

#### Interactive Dashboard with Streamlit

1. Install Streamlit using pip if it's not already installed: `pip install streamlit`.
2. Launch the Streamlit application: `streamlit run streamlit_app.py`.
3. Utilize the application's features to upload data, configure parameters, and download the analysis results.

## Built With

-   [MySQL Community Edition](https://www.mysql.com/products/community/) - The database system used.
-   [Pandas](https://pandas.pydata.org/) - For data manipulation and analysis.
-   [Streamlit](https://streamlit.io/) - For developing the interactive dashboard.

## Acknowledgments

-   Thanks to all open-source projects and tools that made this project possible.
