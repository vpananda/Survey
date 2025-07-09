import pyodbc

try:
    conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=SSIC-SQL-01;'
    'DATABASE=dbint_Survey;'
    'UID=INT_Priya;'
    'PWD=Priya@2005;'
    )
    print("✅ Connected to SQL Server!")
except Exception as e:
    print("❌ Connection failed:", e)
