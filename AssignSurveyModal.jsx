import React, { useEffect, useState } from 'react';
import Select from 'react-select';
import '../styles/AssignSurvey.css';

const AssignSurveyModal = ({ survey, onClose }) => {
  const [employeeOptions, setEmployeeOptions] = useState([]);
  const [selectedOptions, setSelectedOptions] = useState([]);
  const [dueDate, setDueDate] = useState('');
  const [loading, setLoading] = useState(true); 

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Fetch employee list
        const empRes = await fetch('http://localhost:5000/api/employees/role/2');
        const empData = await empRes.json();
        let empOptions = [];
        if (empData.status === 'success') {
          empOptions = empData.data.map(emp => ({
            value: emp.EmployeeId,
            label: emp.EmployeeName
          }));
          setEmployeeOptions(empOptions);
        }

        // Fetch assigned employees
        const assignedRes = await fetch(`http://localhost:5000/api/survey/${survey.SurveyID}/assignees`);
        const assignedData = await assignedRes.json();
        if (assignedData.status === 'success') {
          const preSelected = assignedData.data.map(emp => ({
            value: emp.EmployeeId,
            label: emp.EmployeeName
          }));
          setSelectedOptions(preSelected);
        }
      } catch (error) {
        console.error('Error fetching employees:', error);
      } finally {
        setLoading(false); 
      }
    };

    fetchData();
  }, [survey.SurveyID]);

  const handleSubmit = async () => {
    if (!selectedOptions.length || !dueDate) {
      alert('Please select at least one employee and a due date.');
      return;
    }

    const payload = {
      SurveyID: survey.SurveyID,
      EmployeeIDs: selectedOptions.map(opt => opt.value),
      DueDate: dueDate,
      CreatedBy: 'Admin'
    };

    const res = await fetch('http://localhost:5000/api/survey/assign', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    });

    const result = await res.json();
    if (res.ok && result.status === 'success') {
      alert('Survey assigned successfully!');
      onClose(true);
    } else {
      alert('Assignment failed.');
    }
  };

  return (
    <div className="assign-modal-overlay">
      <div className="assign-modal">
        <h3>Assign Survey: {survey.SurveyName}</h3>

        <label>Assign to Employees:</label>
        <Select
          isMulti
          isLoading={loading} 
          options={employeeOptions}
          value={selectedOptions}
          onChange={setSelectedOptions}
          placeholder={loading ? "Loading employees..." : "Select employees..."}
          noOptionsMessage={() => loading ? "Loading..." : "No employees found"}
        />

        <label>Due Date:</label>
        <input type="date" value={dueDate} onChange={(e) => setDueDate(e.target.value)} />

        <div className="assign-actions">
          <button className="assign-btn" onClick={handleSubmit}>Assign</button>
          <button className="cancel-btn" onClick={onClose}>Cancel</button>
        </div>
      </div>
    </div>
  );
};

export default AssignSurveyModal;
