import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import Homepage from './components/Homepage';
import Login from './components/login';
import AdminDashboard from './components/AdminDashboard';
import UserDashboard from './components/UserDashboard';
import RolesDashboard from './components/RolesDashboard';
import CreateSurvey from './components/CreateSurvey';
import ManageSurveys from './components/ManageSurveys'; 
import ViewSurvey from './components/ViewSurvey';
import ManageResponses from './components/ManageResponses';
import SurveyForm from './components/SurveyForm';
import Layout from './layouts/Layout';

function App() {
  return (
    <Routes>
     
      <Route path="/" element={<Homepage />} />
      <Route path="/login" element={<Login />} />

      <Route path="/admin-dashboard" element={<Layout><AdminDashboard /></Layout>} />
      <Route path="/user-dashboard" element={<Layout><UserDashboard /></Layout>} />
      <Route path="/roles-dashboard" element={<Layout><RolesDashboard /></Layout>} />
      <Route path="/create-survey" element={<Layout><CreateSurvey /></Layout>} /> 
      <Route path="/manage-surveys" element={<Layout><ManageSurveys /></Layout>} />
      <Route path="/survey/:id" element={<Layout><ViewSurvey /></Layout>} />
      <Route path="/manage-responses" element={<Layout><ManageResponses /></Layout>} />
      <Route path="/user-dashboard" element={<UserDashboard />} />
      <Route path="/survey-form/:surveyId" element={<SurveyForm />} />

      <Route path="*" element={<Navigate to="/login" />} />
    </Routes>
  );
}

export default App;
