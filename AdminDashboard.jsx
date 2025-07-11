import React, { useEffect, useState } from 'react';
import axios from 'axios';
import StatsCard from './StatsCard';
import SurveyBarChart from './SurveyBarChart';
import ParticipationPie from './ParticipationPie';
import '../styles/dashboard.css';

const AdminDashboard = () => {
  const [stats, setStats] = useState({
    totalEmployees: 0,
    totalSurveys: 0,
    totalResponses: 0,
    totalQuestions: 0,
  });

  const [responseData, setResponseData] = useState([]);
  const [participationData, setParticipationData] = useState([]);

  useEffect(() => {
    fetchStats();
    fetchSurveyResponseCounts();
    fetchSurveyParticipation();
  }, []);

const fetchStats = async () => {
  try {
    const [empStatsRes, surRes, resRes, quesRes] = await Promise.all([
      axios.get('http://localhost:5000/api/employees/assigned-vs-attended'),
      axios.get('http://localhost:5000/api/surveys'),
      axios.get('http://localhost:5000/api/responses/count'),
      axios.get('http://localhost:5000/api/questions/count'),
    ]);

    const assigned = empStatsRes.data?.data?.assigned || 0;
    const attended = empStatsRes.data?.data?.attended || 0;
    const totalSurveys = surRes.data?.data?.length || 0;
    const totalResponses = resRes.data?.data?.total || 0;
    const totalQuestions = quesRes.data?.count || 0;

    setStats({
      assignedEmployees: assigned,
      attendedEmployees: attended,
      totalSurveys,
      totalResponses,
      totalQuestions,
    });
  } catch (err) {
    console.error('Stat fetch error:', err);
  }
};


  const fetchSurveyResponseCounts = async () => {
    try {
      const res = await axios.get('http://localhost:5000/api/survey/response-counts');
      if (res.data.status === 'success') {
        setResponseData(res.data.data);
      }
    } catch (err) {
      console.error('Survey response count error:', err);
    }
  };

  const fetchSurveyParticipation = async () => {
  try {
    const res = await axios.get('http://localhost:5000/api/participation/combined');
    if (res.data && res.data.data) {
      setParticipationData({
        submitted: res.data.data.submitted,
        notSubmitted: res.data.data.notSubmitted,
      });
    } else {
      setParticipationData(null);
    }
  } catch (err) {
    console.error('Survey participation error:', err);
    setParticipationData(null);
  }
};


  return (
    <div className="admin-dashboard">
      <h2>📊 Admin Dashboard</h2>

      <div className="card-grid">
        <StatsCard title="Assigned Employees" value={stats.assignedEmployees} type="employees" gradient="linear-gradient(135deg, #7b61ff, #b892ff)" />
        <StatsCard title="Attended Employees" value={stats.attendedEmployees} type="attended" gradient="linear-gradient(135deg, #4caf50, #81c784)" />
        <StatsCard title="Total Surveys" value={stats.totalSurveys} type="surveys" gradient="linear-gradient(135deg, #ffa726, #ffcc80)" />
        <StatsCard title="Total Responses" value={stats.totalResponses} type="responses" gradient="linear-gradient(135deg, #26c6da, #80deea)" />
        <StatsCard title="Total Questions" value={stats.totalQuestions} type="questions" gradient="linear-gradient(135deg, #f06292, #f8bbd0)" />
      </div>

      <div className="dashboard-charts">
        <div className="chart-box">
        <h4>Responses Per Survey</h4>
        <SurveyBarChart data={responseData} />
        </div>
        <div className="chart-box">
        <h4>Overall Participation</h4>
        <ParticipationPie data={participationData} />
        </div>
      </div>
    </div>
  );
};

export default AdminDashboard;
