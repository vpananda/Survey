import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import AssignSurveyModal from './AssignSurveyModal';
import ViewSurvey from './ViewSurvey'; 
import '../styles/ManageSurveys.css';

const ManageSurveys = () => {
  const [surveys, setSurveys] = useState([]);
  const [selectedSurvey, setSelectedSurvey] = useState(null);
  const [showAssignModal, setShowAssignModal] = useState(false);
  const [viewSurveyId, setViewSurveyId] = useState(null); 
  const navigate = useNavigate();

  useEffect(() => {
    fetchSurveys();
  }, []);

  const fetchSurveys = async () => {
    try {
      const res = await fetch('http://localhost:5000/api/surveys');
      const data = await res.json();
      if (data.status === 'success') {
        setSurveys(data.data);
      }
    } catch (err) {
      console.error('Error loading surveys:', err);
    }
  };

  const handleAssignClick = (survey) => {
    setSelectedSurvey(survey);
    setShowAssignModal(true);
  };

  const handleModalClose = (reload = false) => {
    setShowAssignModal(false);
    setSelectedSurvey(null);
    if (reload) fetchSurveys();
  };

  const handleViewClick = (surveyId) => {
    setViewSurveyId(surveyId);
  };

  return (
    <div className="manage-surveys-container">
      <div className="header-bar">
        <h2> Manage Surveys</h2>
        <button className="create-btn" onClick={() => navigate('/create-survey')}> Create Survey</button>
      </div>

      <table className="survey-table">
        <thead>
          <tr>
            
            <th>Survey Title</th>
            <th>Start</th>
            <th>End</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {surveys.map((survey) => (
            <tr key={survey.SurveyID}>
              
              <td>{survey.SurveyName}</td>
              <td>{survey.StartDate}</td>
              <td>{survey.EndDate}</td>
              <td>
                <button className="view-btn" onClick={() => handleViewClick(survey.SurveyID)}>👁 View</button>
                <button className="assign-btn" onClick={() => handleAssignClick(survey)}>📤 Assign</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {/* Assign Modal */}
      {showAssignModal && selectedSurvey && (
        <AssignSurveyModal survey={selectedSurvey} onClose={handleModalClose} />
      )}

      {/* View Modal */}
      {viewSurveyId && (
        <ViewSurvey surveyId={viewSurveyId} onClose={() => setViewSurveyId(null)} />
      )}
    </div>
  );
};

export default ManageSurveys;
