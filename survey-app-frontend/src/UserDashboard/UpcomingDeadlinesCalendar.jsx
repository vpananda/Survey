import React, { useEffect, useState } from 'react';
import './UserDashboard.css';

const UpcomingDeadlinesCalendar = ({ employeeId }) => {
  const [deadlines, setDeadlines] = useState([]);

  useEffect(() => {
    if (employeeId) {
      fetch(`http://localhost:5000/api/user/upcoming-deadlines/${employeeId}`)
        .then(response => response.json())
        .then(result => {
          if (result.status === 'success') {
            setDeadlines(result.data); 
          } else {
            console.error('Failed to fetch deadlines:', result.message);
            setDeadlines([]);
          }
        })
        .catch(error => {
          console.error('Error fetching deadlines:', error);
        });
    }
  }, [employeeId]);

  return (
    <div className="calendar-widget">
      {/* <h3>📅 Upcoming Deadlines</h3> */}
      {deadlines.length === 0 ? (
        <p>No upcoming deadlines.</p>
      ) : (
        <ul className="deadline-list">
          {deadlines.map((item) => (
            <li key={item.surveyId} className="deadline-item">
              <strong>{item.surveyName}</strong>
              <span className="deadline-date">{item.endDate}</span>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default UpcomingDeadlinesCalendar;
