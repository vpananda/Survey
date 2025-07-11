import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';

const MySurvey = () => {
  const [surveys, setSurveys] = useState([]);
  const [loading, setLoading] = useState(true);
  const employeeId = localStorage.getItem('employeeId');
  const navigate = useNavigate();

  useEffect(() => {
    if (!employeeId) {
      navigate('/login');
      return;
    }

    fetch(`http://127.0.0.1:5000/api/user/assigned-surveys/${employeeId}`)
      .then(res => res.json())
      .then(data => {
        setSurveys(data);
        setLoading(false);
      })
      .catch(err => {
        console.error('Error fetching surveys:', err);
        setLoading(false);
      });
  }, [employeeId, navigate]);

  const handleAction = (surveyId) => {
    navigate(`/Survey/${surveyId}`);
  };

  if (loading) return <p>Loading surveys...</p>;

  return (
    <div style={{ padding: '20px' }}>
      <h2>My Surveys</h2>
      {surveys.length === 0 ? (
        <p>No surveys assigned.</p>
      ) : (
        <table border="1" cellPadding="10" style={{ width: '100%', marginTop: '20px' }}>
          <thead style={{ backgroundColor: '#003366', color: 'white' }}>
            <tr>
              <th>Survey Name</th>
              <th>Start Date</th>
              <th>End Date</th>
              <th>Status</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            {surveys.map(survey => (
              <tr key={survey.survey_id}>
                <td>{survey.survey_name}</td>
                <td>{new Date(survey.start_date).toDateString()}</td>
                <td>{new Date(survey.end_date).toDateString()}</td>
                <td>{survey.status}</td>
                <td>
                  <button onClick={() => handleAction(survey.survey_id)}>
                    {survey.status === 'submitted' ? 'View' :
                     survey.status === 'draft' ? 'Continue' : 'Start'}
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

export default MySurvey;
