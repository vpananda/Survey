import React, { useEffect, useState } from 'react';
import Select from 'react-select';
import DataTable from 'datatables.net-dt';
import 'datatables.net-dt/js/dataTables.dataTables.min.js';
import 'datatables.net-dt/css/dataTables.dataTables.min.css';
import '../styles/ManageResponses.css';
import $ from 'jquery';

const ManageResponses = () => {
  const [surveyOptions, setSurveyOptions] = useState([]);
  const [employeeOptions, setEmployeeOptions] = useState([]);
  const [filteredData, setFilteredData] = useState([]);

  const [selectedSurvey, setSelectedSurvey] = useState(null);
  const [selectedEmployees, setSelectedEmployees] = useState([]);

  useEffect(() => {
    fetchSurveys();
    fetchEmployees();
    handleSearch();
  }, []);

  useEffect(() => {
    if (filteredData.length > 0) {
      setTimeout(() => {
        if ($.fn.DataTable.isDataTable('#responsesTable')) {
          $('#responsesTable').DataTable().destroy();
        }
        $('#responsesTable').DataTable({
          pageLength: 5
        })
      }, 0);
    }
  }, [filteredData]);

  const fetchSurveys = async () => {
    try {
      const res = await fetch('http://localhost:5000/api/surveys');
      const data = await res.json();
      if (data.status === 'success') {
        setSurveyOptions(data.data.map(s => ({
          value: s.SurveyID,
          label: s.SurveyName
        })));
      }
    } catch (e) {
      console.error('Survey fetch error:', e);
    }
  };

  const fetchEmployees = async () => {
    try {
      const res = await fetch('http://localhost:5000/api/employees/role/2');
      const data = await res.json();
      if (data.status === 'success') {
        setEmployeeOptions(data.data.map(emp => ({
          value: emp.EmployeeId,
          label: emp.EmployeeName
        })));
      }
    } catch (e) {
      console.error('Employee fetch error:', e);
    }
  };

  const handleSearch = async () => {
    try {
      const res = await fetch('http://localhost:5000/api/responses/combined', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          survey_id: selectedSurvey?.value || null,
          employee_ids: selectedEmployees.map(e => e.value)
        })
      });
      const data = await res.json();
      if (data.status === 'success') {
        if ($.fn.DataTable.isDataTable('#responsesTable')) {
          $('#responsesTable').DataTable().destroy();
        }
        setFilteredData(data.data);
      } else {
        setFilteredData([]);
      }
    } catch (e) {
      console.error('Search error:', e);
      setFilteredData([]);
    }
  };

  return (
    <div className="manage-responses-container">
      <h2>Manage Responses</h2>
      <div className="filter-bar">
        <Select
          placeholder="Filter by Survey"
          options={surveyOptions}
          onChange={setSelectedSurvey}
          isClearable
        />
        <Select
          placeholder="Filter by Employee(s)"
          options={employeeOptions}
          isMulti
          onChange={setSelectedEmployees}
        />
        <button onClick={handleSearch}>Search</button>
      </div>

      <table id="responsesTable" className="display">
        <thead>
          <tr>
            <th>Survey Name</th>
            <th>Start</th>
            <th>End</th>
            <th>Employee</th>
            <th>Question</th>
            <th>Options</th>
            <th>Correct Answer</th>
            <th>Submitted Answer</th>
          </tr>
        </thead>
        <tbody>
          {filteredData.map((survey, sIdx) =>
            survey.Questions.map((q, qIdx) => {
              const answers = q.SubmittedAnswers?.length
                               ? Array.from( 
                                new Map(
                                       q.SubmittedAnswers.map(a => [`${a.EmployeeID}-${q.QuestionID}`, a])
                                        ).values()
    )
  : [{ EmployeeID: null, EmployeeName: '-', Answer: '-' }];
              return answers.map((ans, aIdx) => (
                <tr key={`row-${sIdx}-${qIdx}-${aIdx}`}>
                  <td>{survey.SurveyName}</td>
                  <td>{survey.StartDate}</td>
                  <td>{survey.EndDate}</td>
                  <td>{ans.EmployeeName}</td>
                  <td>{q.QuestionText}</td>
                  <td>{q.Options || '-'}</td>
                  <td>{q.CorrectAnswer || '-'}</td>
                  <td>{ans.Answer || '-'}</td>
                </tr>
              ));
            })
          )}
        </tbody>
      </table>
    </div>
  );
};

export default ManageResponses;
