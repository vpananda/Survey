import React, { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import {
  FaBars, FaSignOutAlt, FaTachometerAlt, FaWpforms,
  FaPoll, FaUsersCog
} from 'react-icons/fa';
import './sidebar.css';

const SidebarItem = ({ to, icon, label, collapsed, active }) => (
  <Link to={to} className={`nav-item ${active === to ? 'active' : ''}`}>
    <div className="icon">{icon}</div>
    {!collapsed && <span className="label">{label}</span>}
    {collapsed && <span className="tooltip">{label}</span>}
  </Link>
);

const Layout = ({ children }) => {
  const [collapsed, setCollapsed] = useState(false);
  const navigate = useNavigate();
  const location = useLocation();
  const user = JSON.parse(localStorage.getItem('user'));
  const isAdmin = user?.RoleId === 1;

  const handleLogout = () => {
    localStorage.clear();
    navigate('/login');
  };

  return (
    <div className={`layout ${collapsed ? 'collapsed' : ''}`}>
      {/* Sidebar */}
      <aside className="sidebar">
        <div className={`sidebar-header ${collapsed ? 'collapsed-header' : ''}`}>
          {!collapsed && (
            <h2 className="logo-text">SurveyApp</h2>
          )}
          <button
            className={`toggle-btn ${collapsed ? 'center-toggle' : ''}`}
            onClick={() => setCollapsed(!collapsed)}
            title="Toggle sidebar"
          >
            <FaBars />
          </button>
        </div>

        <div className="nav">
          <SidebarItem to="/admin-dashboard" icon={<FaTachometerAlt />} label="Dashboard" collapsed={collapsed} active={location.pathname} />
          {isAdmin && (
            <>
              <SidebarItem to="/roles-dashboard" icon={<FaUsersCog />} label="Manage Roles" collapsed={collapsed} active={location.pathname} />
              <SidebarItem to="/manage-surveys" icon={<FaWpforms />} label="Manage Surveys" collapsed={collapsed} active={location.pathname} />
              <SidebarItem to="/manage-responses" icon={<FaPoll />} label="Manage Responses" collapsed={collapsed} active={location.pathname} />
            </>
          )}
        </div>

        <button className="logout-btn" onClick={handleLogout}>
          <FaSignOutAlt />
          <span>Logout</span>
        </button>
      </aside>

      {/* Content Area */}
      <div className="main-content">
        <header className="topbar">Hello, {user?.EmployeeName}</header>
        <main className="content">{children}</main>
      </div>
    </div>
  );
};

export default Layout;
