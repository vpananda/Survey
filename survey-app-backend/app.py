from flask import Flask, request, jsonify, session, redirect
from datetime import date,datetime,timedelta
import pyodbc
from flask_cors import CORS
from flask import request, jsonify, session

app = Flask(__name__)
CORS(app, supports_credentials=True, origins=["http://localhost:5173"])
app.secret_key = 'survey_application'

def build_date_filter(start_date, end_date, column='CreatedDate', table_prefix=''):
    if table_prefix:
        column = f"{table_prefix}.{column}"
    filters = ""
    values = []
    if start_date and end_date:
        filters = f" AND CAST({column} AS DATE) BETWEEN ? AND ?"
        values = [start_date, end_date]
    return filters, values


def get_db():
    conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=SSIC-SQL-01;'
    'DATABASE=dbint_Survey;'
    'UID=INT_Priya;'
    'PWD=Priya@2005;'
)
    return conn, conn.cursor()

# Login API (POST)
@app.route('/login', methods=['POST'])
def login():
    conn,cursor=get_db()
    data = request.get_json() 
    email = data.get('email')
    password = data.get('password')

    cursor.execute("""
        SELECT EmployeeId, EmployeeName, RoleId 
        FROM Employee 
        WHERE EmployeeEmail=? AND Password=? AND IsActive=1
    """, (email, password))
    user = cursor.fetchone()

    if user:
        session['user_id'] = user[0]
        session['user_name'] = user[1]
        session['role_id'] = user[2]
        return jsonify({
            'EmployeeId': user[0],
            'EmployeeName': user[1],
            'RoleId': user[2]
        }), 200
    cursor.close()
    return jsonify({'error': 'Invalid credentials'}), 401

# Get Session Info API
@app.route('/api/session')
def get_session():
    if 'user_id' in session:
        return jsonify({
            'EmployeeId': session['user_id'],
            'EmployeeName': session['user_name'],
            'RoleId': session['role_id']
        })
    return jsonify({'error': 'Unauthorized'}), 401

# Logout
@app.route('/logout')
def logout():
    session.clear()
    return redirect('/login')

# Get FR for a Role
@app.route('/api/user-functional-requirements', methods=['POST'])
def get_user_functional_requirements():
    try:
        conn,cursor=get_db()
        data = request.get_json()
        role_id = data.get('role_id')

        cursor.execute("""
            SELECT fr.FRName
            FROM FunctionalRequirements fr
            JOIN RoleFunctionalMapping rfm ON fr.FRId = rfm.FRId
            WHERE rfm.RoleId = ?
        """, (role_id,))
        frs = [row[0] for row in cursor.fetchall()]
        cursor.close()
        return jsonify({'status': 'success', 'data': frs}), 200

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500

#GET Roles
@app.route('/api/roles/getroles', methods=['GET'])
def get_roles():
    try:
        conn,cursor=get_db()
        cursor.execute("EXEC sp_GetRoles")
        roles = [
            {
                'RoleId': row[0],
                'RoleName': row[1],
                'IsActive': row[2],
                'CreatedBy': row[3],
                'CreatedDate': str(row[4]),
                'ModifiedDate': str(row[5]),
                'ModifiedBy': row[6]
            } for row in cursor.fetchall()
        ]
        cursor.close()
        return jsonify({'status': 'success', 'data': roles}), 200

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500

#INSERT Role
@app.route('/api/roles/insert', methods=['POST'])
def insert_role():
    try:
        conn,cursor=get_db()
        data = request.json
        cursor.execute("EXEC sp_InsertRole ?, ?, ?, ?, ?",
                       (data['RoleName'], data['CreatedBy'], data['CreatedDate'],
                        data['ModifiedBy'], data['ModifiedDate']))
        cursor.close()
        conn.commit()
        return jsonify({'status': 'success', 'message': 'Role inserted successfully'}), 201

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500

#UPDATE Role
@app.route('/api/roles/update', methods=['PUT'])
def update_role():
    try:
        conn,cursor=get_db()
        data = request.json
        cursor.execute("EXEC sp_UpdateRole ?, ?, ?, ?, ?",
                       (data['RoleId'], data['RoleName'], data['IsActive'],
                        data['ModifiedBy'], data['ModifiedDate']))
        cursor.close()
        conn.commit()
        return jsonify({'status': 'success', 'message': 'Role updated successfully'}), 200

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500

# DELETE Role 
@app.route('/api/roles/delete', methods=['DELETE'])
def delete_role():
    try:
        conn,cursor=get_db()
        data = request.json
        cursor.execute("EXEC sp_DeleteRole ?, ?, ?",
                       (data['RoleId'], data['ModifiedBy'], data['ModifiedDate']))
        cursor.close()
        conn.commit()
        return jsonify({'status': 'success', 'message': 'Role deleted successfully'}), 200

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500

#create survey
@app.route('/api/survey/create', methods=['POST'])
def create_survey():
    try:
        conn,cursor=get_db()
        data = request.get_json()
        cursor.execute("""
            INSERT INTO Survey (SurveyName, Description, StartDate, EndDate, IsActive, CreatedBy, ModifiedDate, ModifiedBy)
            OUTPUT INSERTED.SurveyID
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            data['SurveyName'],
            data['Description'],
            data['StartDate'],
            data['EndDate'],
            1,
            data['CreatedBy'],
            datetime.now(),
            data['CreatedBy']
        ))
        survey_id = cursor.fetchone()[0]

        for q in data['Questions']:
            cursor.execute("""
                INSERT INTO QuestionMaster (QuestionText, QuestionType, Options, IsActive, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy)
                OUTPUT INSERTED.QuestionID
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                q['QuestionText'],
                q['QuestionType'],
                q.get('Options', ''),
                1,
                datetime.now(),
                data['CreatedBy'],
                datetime.now(),
                data['CreatedBy']
            ))
            question_id = cursor.fetchone()[0]

            cursor.execute("""
                INSERT INTO SurveyQuestionMapping (SurveyID, QuestionID, IsActive, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            """, (
                survey_id,
                question_id,
                1,
                datetime.now(),
                data['CreatedBy'],
                datetime.now(),
                data['CreatedBy']
            ))
        cursor.close()
        conn.commit()
        return jsonify({"status": "success", "survey_id": survey_id}), 200

    except Exception as e:
        print("ERROR:",str(e))
        conn.rollback()
        return jsonify({"status": "error", "message": str(e)}), 500

#manage survey-get all surveys
@app.route('/api/surveys', methods=['GET'])
def get_surveys():
    try:
        conn,cursor=get_db()
        cursor.execute("SELECT SurveyID, SurveyName, StartDate, EndDate FROM Survey WHERE IsActive = 1")
        surveys = []
        for row in cursor.fetchall():
            if len(row) >= 4:
                surveys.append({
                    'SurveyID': row[0],
                    'SurveyName': row[1],
                    'StartDate': str(row[2]),
                    'EndDate': str(row[3])
                })
            else:
                print(" Unexpected row length in /api/surveys:", len(row), row)
        cursor.close()
        return jsonify({'status': 'success', 'data': surveys}), 200
    except Exception as e:
        print(" error:", str(e))
        return jsonify({'status': 'error', 'message': str(e)}), 500


#get employees
@app.route('/api/users', methods=['GET'])
def get_employees():
    try:
        conn,cursor=get_db()
        cursor.execute("SELECT EmployeeId, EmployeeName FROM Employee WHERE IsActive = 1")
        employees = [{'EmployeeId': row[0], 'EmployeeName': row[1]} for row in cursor.fetchall()]
        cursor.close()
        conn.close()
        return jsonify({'status': 'success', 'data': employees}), 200
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500


#assign survey
@app.route('/api/survey/assign', methods=['POST'])
def assign_multiple_employees():
    try:
        conn,cursor=get_db()
        data = request.get_json()
        SurveyID = data.get('SurveyID')
        EmployeeIDs = data.get('EmployeeIDs')  
        DueDate = data.get('DueDate')
        CreatedBy = data.get('CreatedBy') or 'Admin'
        ModifiedBy = CreatedBy
        today = datetime.now()

        if not SurveyID or not EmployeeIDs:
            return jsonify({'status': 'error', 'message': 'Missing SurveyID or EmployeeIDs'}), 400

        for emp_id in EmployeeIDs:
            cursor.execute("""
                INSERT INTO SurveyAssignments (
                    SurveyID, EmployeeID, AssignedDate, DueDate, IsActive,
                    CreatedDate, CreatedBy, ModifiedDate, ModifiedBy
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (
                SurveyID, emp_id, today, DueDate, 1,
                today, CreatedBy, today, ModifiedBy
            ))
        cursor.close()
        conn.commit()
        return jsonify({"status": "success", "message": "Survey assigned to selected employees"}), 201

    except Exception as e:
        conn.rollback()
        return jsonify({'status': 'error', 'message': str(e)}), 500


#only the the user 
@app.route('/api/employees/role/2', methods=['GET'])
def get_users_with_role_2():
    try:
        conn,cursor=get_db()
        cursor = conn.cursor()      
        cursor.execute("SELECT EmployeeId, EmployeeName FROM Employee WHERE IsActive = 1 AND RoleId = 2")
        users = []
        for row in cursor.fetchall():
            users.append({
                'EmployeeId': row[0],
                'EmployeeName': row[1]
            })
        cursor.close()
        conn.close()
        return jsonify({'status': 'success', 'data': users}), 200
    except Exception as e:
        print("error:", str(e))
        return jsonify({'status': 'error', 'message': str(e)}), 500


# view survey
@app.route('/api/survey/<int:survey_id>', methods=['GET'])
def get_survey_by_id(survey_id):
    try:
        conn,cursor=get_db()
        cursor.execute("""
            SELECT SurveyID, SurveyName, Description, StartDate, EndDate
            FROM Survey
            WHERE SurveyID = ?
        """, (survey_id,))
        row = cursor.fetchone()
        if not row:
            return jsonify({'status': 'error', 'message': 'Survey not found'}), 404

        survey_data = {
            'SurveyID': row[0],
            'SurveyName': row[1],
            'Description': row[2],
            'StartDate': str(row[3]),
            'EndDate': str(row[4])
        }
        cursor.execute("""
            SELECT qm.QuestionText, qm.QuestionType, qm.Options
            FROM SurveyQuestionMapping sqm
            JOIN QuestionMaster qm ON sqm.QuestionID = qm.QuestionID
            WHERE sqm.SurveyID = ?
        """, (survey_id,))
        questions = [{
            'QuestionText': q[0],
            'QuestionType': q[1],
            'Options': q[2]
        } for q in cursor.fetchall()]

        survey_data['Questions'] = questions
        cursor.close()
        conn.close()
        return jsonify({'status': 'success', 'data': survey_data})

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500


#for assigned employees
@app.route('/api/survey/<int:survey_id>/assignees', methods=['GET'])
def get_assigned_employees(survey_id):
    try:
        conn,cursor=get_db()
        cursor.execute("""
            SELECT e.EmployeeId, e.EmployeeName
            FROM SurveyAssignments sa
            JOIN Employee e ON sa.EmployeeID = e.EmployeeId
            WHERE sa.SurveyID = ? AND sa.IsActive = 1
        """, (survey_id,))
        
        data = [{'EmployeeId': row[0], 'EmployeeName': row[1]} for row in cursor.fetchall()]
        cursor.close()
        conn.close()
        return jsonify({'status': 'success', 'data': data})
    
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500

#survey response submittion
@app.route('/api/survey/submit', methods=['POST'])
def submit_survey_response():
    try:
        conn,cursor=get_db()
        data = request.get_json()
        for response in data['responses']:
            cursor.execute("""
                INSERT INTO SurveyResponses (SurveyID, EmployeeID, QuestionID, Answer, CreatedBy)
                VALUES (?, ?, ?, ?, ?)
            """, (
                data['SurveyID'],
                data['EmployeeID'],
                response['QuestionID'],
                response['Answer'],
                data['CreatedBy']
            ))
        cursor.close()
        conn.commit()
        return jsonify({'status': 'success', 'message': 'Responses saved'}), 201
    except Exception as e:
        conn.rollback()
        return jsonify({'status': 'error', 'message': str(e)}), 500

#response filters
@app.route('/api/responses/combined', methods=['POST'])
def get_combined_response_data():
    try:
        conn,cursor=get_db()
        data = request.get_json()
        survey_id = data.get('survey_id')
        employee_ids = data.get('employee_ids', [])
        emp_id_str = ",".join(map(str, employee_ids)) if employee_ids else None
        cursor = conn.cursor()
        cursor.execute("EXEC sp_GetCombinedSurveyResponses ?, ?", (survey_id, emp_id_str))
        rows = cursor.fetchall()
        cursor.close()
        conn.close()

        combined = {}
        for row in rows:
            sid = row[0]
            if sid not in combined:
                combined[sid] = {
                    'SurveyID': sid,
                    'SurveyName': row[1],
                    'StartDate': str(row[2]),
                    'EndDate': str(row[3]),
                    'Questions': []
                }

            existing_question = next((q for q in combined[sid]['Questions'] if q['QuestionID'] == row[4]), None)
            if not existing_question:
                existing_question = {
                    'QuestionID': row[4],
                    'QuestionText': row[5],
                    'QuestionType': row[6],
                    'Options': row[7],
                    'CorrectAnswer': row[8],
                    'SubmittedAnswers': []
                }
                combined[sid]['Questions'].append(existing_question)

            if row[9] and row[10]:
                existing_question['SubmittedAnswers'].append({
                    'EmployeeID': row[9],
                    'EmployeeName': row[10],
                    'Answer': row[11]
                })

        return jsonify({'status': 'success', 'data': list(combined.values())})

    except Exception as e:
        print(" ERROR:", e)
        return jsonify({'status': 'error', 'message': str(e)}), 500

@app.route('/api/user/assigned-surveys/<int:employee_id>', methods=['GET'])
def get_assigned_surveys(employee_id):
    try:
        conn, cursor = get_db()
        query = """
        SELECT s.SurveyID AS survey_id, s.SurveyName AS survey_name, s.StartDate AS start_date, s.EndDate AS end_date,
               COALESCE(MAX(sr.Status), 'not_started') AS status
        FROM SurveyAssignments sa
        JOIN Survey s ON sa.SurveyID = s.SurveyID
        LEFT JOIN SurveyResponses sr ON sr.SurveyID = s.SurveyID AND sr.EmployeeID = sa.EmployeeID
        WHERE sa.EmployeeID = ?
        GROUP BY s.SurveyID, s.SurveyName, s.StartDate, s.EndDate
        """
        cursor.execute(query, (employee_id,))
        rows = cursor.fetchall()
        result = [dict(zip([col[0] for col in cursor.description], row)) for row in rows]
        cursor.close()
        conn.close()
        return jsonify(result)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/user/survey/<int:survey_id>/responses/<int:employee_id>', methods=['GET'])
def get_survey_with_responses(survey_id, employee_id):
    try:
        conn, cursor = get_db()
        query = """
        SELECT s.SurveyName, qm.QuestionID, qm.QuestionText, qm.Options,
               sr.Answer AS SubmittedAnswer, sr.Status
        FROM SurveyQuestionMapping sqm
        JOIN QuestionMaster qm ON sqm.QuestionID = qm.QuestionID
        JOIN Survey s ON s.SurveyID = sqm.SurveyID
        LEFT JOIN SurveyResponses sr
          ON sr.QuestionID = qm.QuestionID AND sr.SurveyID = sqm.SurveyID AND sr.EmployeeID = ?
        WHERE sqm.SurveyID = ?
        """
        cursor.execute(query, (employee_id, survey_id))
        rows = cursor.fetchall()

        print("Rows fetched:", rows)  

        questions = []
        status = "not_started"
        survey_name = ""
        for row in rows:
            if row.SurveyName:
                survey_name = row.SurveyName
            if row.Status == "submitted":
                status = "submitted"
            elif row.Status == "draft" and status != "submitted":
                status = "draft"

            options = row.Options.split(',') if row.Options else []

            questions.append({
                "question_id": row.QuestionID,
                "question_text": row.QuestionText,
                "options": options,
                "submitted_answer": row.SubmittedAnswer
            })

        cursor.close()
        conn.close()
        return jsonify({
            "survey_id": survey_id,
            "survey_name": survey_name,
            "status": status,
            "questions": questions
        })
    except Exception as e:
        print("ERROR in survey response route:", str(e)) 
        return jsonify({"error": str(e)}), 500


@app.route('/api/user/save-draft', methods=['POST'])
def save_draft():
    try:
        data = request.get_json()
        conn, cursor = get_db()
        for qid, ans in data['answers'].items():
            cursor.execute("""
                MERGE SurveyResponses AS target
                USING (SELECT ? AS SurveyID, ? AS QuestionID, ? AS EmployeeID) AS src
                ON (target.SurveyID = src.SurveyID AND target.QuestionID = src.QuestionID AND target.EmployeeID = src.EmployeeID)
                WHEN MATCHED THEN
                    UPDATE SET Answer = ?, Status = 'draft'
                WHEN NOT MATCHED THEN
                    INSERT (SurveyID, QuestionID, EmployeeID, Answer, Status)
                    VALUES (?, ?, ?, ?, 'draft');
            """, (
                data['survey_id'], qid, data['employee_id'],
                ans,
                data['survey_id'], qid, data['employee_id'], ans
            ))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"message": "Draft saved successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/user/submit-survey', methods=['POST'])
def submit_survey():
    try:
        data = request.get_json()
        conn, cursor = get_db()
        for qid, ans in data['answers'].items():
            cursor.execute("""
                MERGE SurveyResponses AS target
                USING (SELECT ? AS SurveyID, ? AS QuestionID, ? AS EmployeeID) AS src
                ON (target.SurveyID = src.SurveyID AND target.QuestionID = src.QuestionID AND target.EmployeeID = src.EmployeeID)
                WHEN MATCHED THEN
                    UPDATE SET Answer = ?, Status = 'submitted'
                WHEN NOT MATCHED THEN
                    INSERT (SurveyID, QuestionID, EmployeeID, Answer, Status)
                    VALUES (?, ?, ?, ?, 'submitted');
            """, (
                data['survey_id'], qid, data['employee_id'],
                ans,
                data['survey_id'], qid, data['employee_id'], ans
            ))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"message": "Survey submitted successfully"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

#api with filter
@app.route('/api/survey/response-counts', methods=['GET'])
def get_response_counts_per_survey():
    try:
        start_date = request.args.get('start_date')
        end_date = request.args.get('end_date')
        conn, cursor = get_db()

        date_filter, values = build_date_filter(start_date, end_date, "s.CreatedDate")
        query = f"""
            SELECT s.SurveyID, s.SurveyName, COUNT(r.ResponseID) AS ResponseCount
            FROM Survey s
            LEFT JOIN SurveyResponses r ON s.SurveyID = r.SurveyID
            WHERE 1=1 {date_filter}
            GROUP BY s.SurveyID, s.SurveyName
        """
        cursor.execute(query, values)
        results = cursor.fetchall()

        data = [{"SurveyID": row[0], "SurveyName": row[1], "ResponseCount": row[2]} for row in results]

        cursor.close()
        conn.close()
        return jsonify({"status": "success", "data": data})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500


@app.route('/api/participation/combined', methods=['GET'])
def get_combined_participation():
    try:
        start_date = request.args.get('start_date')
        end_date = request.args.get('end_date')
        conn, cursor = get_db()

        date_filter, values = build_date_filter(start_date, end_date, "s.CreatedDate")

        query = f"""
            SELECT 
                COUNT(DISTINCT sa.EmployeeID) AS AssignedCount,
                COUNT(DISTINCT sr.EmployeeID) AS SubmittedCount
            FROM Survey s
            LEFT JOIN SurveyAssignments sa ON s.SurveyID = sa.SurveyID
            LEFT JOIN SurveyResponses sr ON s.SurveyID = sr.SurveyID
            WHERE 1=1 {date_filter}
        """
        cursor.execute(query, values)
        row = cursor.fetchone()

        assigned = row[0] or 0
        submitted = row[1] or 0
        not_submitted = max(0, assigned - submitted)

        cursor.close()
        conn.close()
        return jsonify({
            "status": "success",
            "data": {
                "submitted": submitted,
                "notSubmitted": not_submitted,
                "total": assigned
            }
        }), 200
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

@app.route('/api/questions/type-distribution', methods=['GET'])
def get_question_type_distribution():
    try:
        start_date = request.args.get('start_date')
        end_date = request.args.get('end_date')

        conn, cursor = get_db()

        # Base query with joins to map SurveyID → QuestionID → QuestionType
        query = """
            SELECT q.QuestionType, COUNT(*) AS count
            FROM Survey s
            JOIN SurveyQuestionMapping sqm ON s.SurveyID = sqm.SurveyID
            JOIN QuestionMaster q ON q.QuestionID = sqm.QuestionID
            WHERE q.IsActive = 1
        """

        values = []
        # Apply date filter if provided
        if start_date and end_date:
            query += " AND CAST(s.CreatedDate AS DATE) BETWEEN ? AND ?"
            values.extend([start_date, end_date])

        query += " GROUP BY q.QuestionType"

        print("Executing:", query, values)

        cursor.execute(query, values)
        rows = cursor.fetchall()
        cursor.close()
        conn.close()

        data = [{"type": row[0], "count": row[1]} for row in rows]

        return jsonify({"status": "success", "data": data}), 200

    except Exception as e:
        print("Error in /api/questions/type-distribution:", str(e))
        return jsonify({"status": "error", "message": str(e)}), 500


# @app.route('/api/engagement/trend', methods=['GET'])
# def get_employee_engagement_trend():
#     try:
#         conn, cursor = get_db()

#         query = """
#             SELECT 
#                 CAST(CreatedDate AS DATE) as Date,
#                 COUNT(DISTINCT EmployeeID) as EngagementCount
#             FROM SurveyResponses
#             GROUP BY CAST(CreatedDate AS DATE)
#             ORDER BY Date
#         """
#         cursor.execute(query)
#         results = cursor.fetchall()
#         cursor.close()
#         conn.close()

#         data = [{"date": row[0].strftime("%Y-%m-%d"), "count": row[1]} for row in results]
#         return jsonify({"status": "success", "data": data}), 200
#     except Exception as e:
#         return jsonify({"status": "error", "message": str(e)}), 500


# @app.route('/api/surveys/top-performers', methods=['GET'])
# def get_top_performing_surveys():
#     try:
#         conn, cursor = get_db()
#         query = """
#             SELECT TOP 5 s.SurveyName, COUNT(r.ResponseID) AS ResponseCount
#             FROM Survey s
#             JOIN SurveyResponses r ON s.SurveyID = r.SurveyID
#             GROUP BY s.SurveyName
#             ORDER BY ResponseCount DESC
#         """
#         cursor.execute(query)
#         results = cursor.fetchall()
#         cursor.close()
#         conn.close()

#         data = [{"survey": row[0], "count": row[1]} for row in results]
#         return jsonify({"status": "success", "data": data}), 200
#     except Exception as e:
#         return jsonify({"status": "error", "message": str(e)}), 500


#api without filter
@app.route('/api/employees/assigned-vs-attended')
def get_assigned_vs_attended():
    try:
        conn, cursor = get_db()

        cursor.execute("SELECT COUNT(DISTINCT EmployeeID) FROM SurveyAssignments")
        assigned = cursor.fetchone()[0] or 0

        cursor.execute("SELECT COUNT(DISTINCT EmployeeID) FROM SurveyResponses")
        attended = cursor.fetchone()[0] or 0

        cursor.close()
        conn.close()
        return jsonify({
            'status': 'success',
            'data': {
                'assigned': assigned,
                'attended': attended
            }
        }), 200
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500


@app.route('/api/responses/count', methods=['GET'])
def total_response_count():
    try:
        conn, cursor = get_db()
        cursor.execute("SELECT COUNT(*) FROM SurveyResponses")
        total = cursor.fetchone()[0]

        cursor.close()
        conn.close()
        return jsonify({'status': 'success', 'data': {'total': total}})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)}), 500


@app.route('/api/questions/count', methods=['GET'])
def get_question_count():
    try:
        conn, cursor = get_db()
        cursor.execute("SELECT COUNT(*) FROM QuestionMaster WHERE IsActive = 1")
        total = cursor.fetchone()[0]

        cursor.close()
        conn.close()
        return jsonify({"status": "success", "count": total})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500


# @app.route('/api/surveys', methods=['GET'])
# def get_surveys():
#     try:
#         conn, cursor = get_db()
#         cursor.execute("SELECT * FROM Survey")
#         rows = cursor.fetchall()
#         surveys = [
#             {
#                 "SurveyID": row[0],
#                 "SurveyName": row[1],
#                 "StartDate": row[2],
#                 "EndDate": row[3],
#                 "CreatedDate": row[4]
#             } for row in rows
#         ]
#         cursor.close()
#         conn.close()
#         return jsonify({"status": "success", "data": surveys})
#     except Exception as e:
#         return jsonify({"status": "error", "message": str(e)}), 500


@app.route('/api/employee/engagement-score')
def get_employee_engagement_score():
    try:
        conn, cursor = get_db()

        cursor.execute("""
            SELECT COUNT(DISTINCT EmployeeID)
            FROM SurveyAssignments
            WHERE EmployeeID IN (SELECT EmployeeID FROM Employee WHERE RoleID = 2)
        """)
        assigned = cursor.fetchone()[0] or 0

        cursor.execute("""
            SELECT COUNT(DISTINCT EmployeeID)
            FROM SurveyResponses
            WHERE EmployeeID IN (SELECT EmployeeID FROM Employee WHERE RoleID = 2)
        """)
        responded = cursor.fetchone()[0] or 0

        engagement = round((responded / assigned) * 100, 1) if assigned else 0.0

        cursor.close()
        conn.close()

        return jsonify({
            "status": "success",
            "data": {
                "engagementPercentage": engagement,
                "assigned": assigned,
                "responded": responded
            }
        })

    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500


@app.route('/api/surveys/top-performing', methods=['GET'])
def get_top_performing_surveys():
    try:
        start_date = request.args.get('start_date')
        end_date = request.args.get('end_date')
        conn, cursor = get_db()
        date_filter, values = build_date_filter(start_date, end_date, "r.SubmittedDate")

        query = f"""
            SELECT TOP 5 s.SurveyName, COUNT(r.ResponseID) as Responses
            FROM Survey s
            JOIN SurveyResponses r ON s.SurveyID = r.SurveyID
            WHERE 1=1 {date_filter}
            GROUP BY s.SurveyID, s.SurveyName
            ORDER BY Responses DESC
        """
        cursor.execute(query, values)
        rows = cursor.fetchall()
        cursor.close()
        conn.close()

        data = [{"survey": row[0], "responses": row[1]} for row in rows]
        return jsonify({"status": "success", "data": data})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500




if __name__ == '__main__':
    try:
        app.run(debug=True, use_reloader=False)
    except Exception as e:
        print("Flask crashed:", str(e))

