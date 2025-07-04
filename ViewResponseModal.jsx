import React, { useEffect, useState } from 'react';
import '../styles/ManageResponses.css';

const ViewResponseModal = ({ survey, employees, selectedEmployee, setSelectedEmployee, onClose }) => {
  const [responses, setResponses] = useState([]);

  const handleEmployeeChange = (e) => {
    setSelectedEmployee(e.target.value);
  };

  const fetchResponses = async () => {
    if (!selectedEmployee) return;
    try {
      const res = await fetch(
        `http://localhost:5000/api/survey/${survey.SurveyID}/response/${selectedEmployee}`
      );
      const data = await res.json();
      if (data.status === 'success') {
        setResponses(data.data);
      } else {
        setResponses([]);
      }
    } catch (err) {
      console.error('Error fetching responses:', err);
    }
  };

  return (
    <div className="response-modal-overlay">
      <div className="response-modal">
        <h3>Responses for: {survey.SurveyName}</h3>

        <label>Select Employee:</label>
        <select value={selectedEmployee} onChange={handleEmployeeChange}>
          <option value="">-- Select Employee --</option>
          {employees.map((emp) => (
            <option key={emp.EmployeeId} value={emp.EmployeeId}>
              {emp.EmployeeName}
            </option>
          ))}
        </select>
        <button onClick={fetchResponses} className="view-btn">View</button>

        <div className="response-scroll">
          {responses.length > 0 ? (
            responses.map((q, idx) => (
              <div className="response-question" key={idx}>
                <p><strong>Q{idx + 1}: {q.QuestionText}</strong></p>
                <div className="option-scroll">
                  {q.Options?.split(',').map((opt, i) => (
                    <div key={i}>
                      <input type="radio" disabled checked={opt === q.SelectedAnswer} />
                      <label>{opt}</label>
                    </div>
                  ))}
                </div>
                <p>✅ Correct Answer: <strong>{q.CorrectAnswer || '-'}</strong></p>
                <p>📝 Submitted Answer: <strong>{q.SelectedAnswer || '-'}</strong></p>
              </div>
            ))
          ) : (
            <p className="no-response">No responses available for this employee.</p>
          )}
        </div>

        <div className="modal-actions">
          <button className="close-btn" onClick={onClose}>Close</button>
        </div>
      </div>
    </div>
  );
};

export default ViewResponseModal;
