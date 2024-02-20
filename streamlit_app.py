import streamlit as st
import pandas as pd
from datetime import datetime, date
import os
from zipfile import ZipFile
import base64
import tempfile

# Function to generate a download link for a ZIP file
def create_download_zip(filenames, zip_name="data_quality_issues.zip"):
    with tempfile.TemporaryDirectory() as tmpdirname:
        zip_path = os.path.join(tmpdirname, zip_name)
        with ZipFile(zip_path, 'w') as zipf:
            for file in filenames:
                zipf.write(file)
                os.remove(file)  # Clean up the CSV file after adding it to ZIP
        
        with open(zip_path, "rb") as f:
            bytes = f.read()
            b64 = base64.b64encode(bytes).decode()
            href = f'<a href="data:application/octet-stream;base64,{b64}" download="{zip_name}">Download ZIP file</a>'
            return href

# Streamlit app starts here
st.set_page_config(page_title="Data Quality Check", layout="wide")
st.title('Data Quality Check for UserOnlineHistory')

# File upload
uploaded_file = st.file_uploader("Choose a CSV file", type="csv")

# Date input with a specific default date
default_reference_date = date(2019, 5, 25)
reference_date = st.date_input("Enter the reference date for data quality check", default_reference_date)

if uploaded_file is not None:
    df = pd.read_csv(uploaded_file)
    df['completed'] = pd.to_datetime(df['completed'], format='%d/%m/%Y %H:%M:%S')

    # Perform checks
    missing_values_df = df[df['userUid'].isnull() | df['onlineCourseUid'].isnull()]
    invalid_grades_df = df[(df['grade'] > df['gradeMaxVal']) | (df['pct'] > 1)]
    future_dates_df = df[df['completed'] > pd.Timestamp(reference_date)]

    # Display results
    st.write("### Missing Values Issues")
    st.dataframe(missing_values_df)

    st.write("### Invalid Grades Issues")
    st.dataframe(invalid_grades_df)

    st.write("### Completed in the Future")
    st.dataframe(future_dates_df)

    # Prepare files for download if there are any issues
    if not missing_values_df.empty or not invalid_grades_df.empty or not future_dates_df.empty:
        filenames = []
        if not missing_values_df.empty:
            filename = 'missing_values_issues.csv'
            missing_values_df.to_csv(filename, index=False)
            filenames.append(filename)
        if not invalid_grades_df.empty:
            filename = 'invalid_grades_issues.csv'
            invalid_grades_df.to_csv(filename, index=False)
            filenames.append(filename)
        if not future_dates_df.empty:
            filename = 'completed_in_future.csv'
            future_dates_df.to_csv(filename, index=False)
            filenames.append(filename)
        
        # Create ZIP and provide a download link
        if filenames:
            zip_link = create_download_zip(filenames)
            st.markdown(zip_link, unsafe_allow_html=True)
