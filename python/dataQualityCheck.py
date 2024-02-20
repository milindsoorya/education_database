import pandas as pd
from datetime import datetime
import os

# Load the CSV file into a pandas DataFrame
df = pd.read_csv('./data/UserOnlineHistory.csv')

# Create the 'data_quality_check' folder if it doesn't exist
data_quality_check = './data/data_quality_check'
if not os.path.exists(data_quality_check):
    os.makedirs(data_quality_check)

# 1. Records with no value in either UserUid or OnlineCourseUid
missing_values_df = df[df['userUid'].isnull() | df['onlineCourseUid'].isnull()]
missing_values_df.to_csv('./data/data_quality_check/missing_values_issues.csv', index=False)

# 2. Records with either grade > gradeMaxVal or pct > 1
invalid_grades_df = df[(df['grade'] > df['gradeMaxVal']) | (df['pct'] > 1)]
invalid_grades_df.to_csv('./data/data_quality_check/invalid_grades_issues.csv', index=False)

# 3. Records with completed in the future
# Convert 'completed' to datetime using the specified format
df['completed'] = pd.to_datetime(df['completed'], format='%d/%m/%Y %H:%M:%S')
future_dates_df = df[df['completed'] > datetime.now()]
future_dates_df.to_csv('./data/data_quality_check/future_dates_issues.csv', index=False)

# Output messages to console for confirmation
print(f"Found {len(missing_values_df)} records with missing UserUid or onlineCourseUid.")
print(f"Found {len(invalid_grades_df)} records with invalid grades or pct values.")
print(f"Found {len(future_dates_df)} records with completion dates in the future.")
