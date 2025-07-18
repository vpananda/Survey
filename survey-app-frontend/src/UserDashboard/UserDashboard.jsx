import React, { useEffect, useState } from 'react';
import StatusCard2 from './StatusCard2';
import CompletionTrend from './CompletionTrend';
import RecentCompletedSurveys from './RecentCompletedSurveys';
import UpcomingDeadlinesCalendar from './UpcomingDeadlinesCalendar';
import './userdashboard.css';

const UserDashboard = () => {
  const employeeId = localStorage.getItem('employeeId');
  const [assigned, setAssigned] = useState(0);
  const [completed, setCompleted] = useState(0);
  const [questions, setQuestions] = useState(0);
  const [trendData, setTrendData] = useState([]);
  const [recentSurveys, setRecentSurveys] = useState([]);
  const [deadlines, setDeadlines] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => {
    if (!employeeId) {
      setError('Employee ID missing');
      return;
    }

    const fetchAll = async () => {
      try {
   
        const statsRes = await fetch(`http://localhost:5000/api/user/dashboard/${employeeId}`);
        if (!statsRes.ok) throw new Error('Dashboard stats failed');
        const statsData = await statsRes.json();
        setAssigned(statsData.data?.assigned || 0);
        setCompleted(statsData.data?.submitted || 0);
        setQuestions(statsData.data?.questions || 0);

        const [trendRes, recentRes, deadlineRes] = await Promise.all([
          fetch(`http://localhost:5000/api/user/trend/${employeeId}`),
          fetch(`http://localhost:5000/api/user/recent-completed/${employeeId}`),
          fetch(`http://localhost:5000/api/user/upcoming-deadlines/${employeeId}`)
        ]);

        if (!trendRes.ok || !recentRes.ok || !deadlineRes.ok)
          throw new Error('Trend/Recent/Deadline fetch failed');

        const trendJson = await trendRes.json();
        const recentJson = await recentRes.json();
        const deadlineJson = await deadlineRes.json();

        setTrendData(trendJson);
        setRecentSurveys(recentJson);
        setDeadlines(deadlineJson);
      } catch (e) {
        console.error(e);
        setError('Failed to load all dashboard data.');
      }
    };

    fetchAll();
  }, [employeeId]);

  const pending = Math.max(assigned - completed, 0);

  return (
    <div className="user-dashboard-container">
      <h2 className="dashboard-heading">📊 My Dashboard</h2>
      {error && <div className="error-message">{error}</div>}

      <div className="user-card-grid">
        <StatusCard2 title="Assigned Surveys" value={assigned} gradient="linear-gradient(135deg, #7b61ff, #b892ff)" />
        <StatusCard2 title="Completed Surveys" value={completed} gradient="linear-gradient(135deg, #4caf50, #81c784)" />
        <StatusCard2 title="Pending Surveys" value={pending} gradient="linear-gradient(135deg, #ffa726, #ffcc80)" />
        <StatusCard2 title="Total Questions" value={questions} gradient="linear-gradient(135deg, #f06292, #f8bbd0)" />
      </div>

      <div className="data-section-row" style={{ display: 'flex', gap: '50px', marginTop: '40px' }}>
        <div className="card" style={{ flex: 1 }}>
          <h3>Completion Trend</h3>
          <CompletionTrend data={trendData} />
        </div>

        <div className="card" style={{ flex: 1 }}>
          <h3>Recently Completed Surveys</h3>
          <RecentCompletedSurveys surveys={recentSurveys} />
        </div>
      </div>

      <div className="card" style={{ marginTop: '40px' }}>
        <h3>Upcoming Deadlines</h3>
        <UpcomingDeadlinesCalendar deadlines={deadlines} />
      </div>
    </div>
  );
};

export default UserDashboard;
