import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/global.css';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleLogin = async (e) => {
    e.preventDefault();
    setError('');

    try {
      const response = await fetch('http://127.0.0.1:5000/login', {
        method: 'POST',
        credentials: 'include',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, password }),
      });

      if (response.ok) {
        const user = await response.json();

        if (user.RoleId === 1) {
         
          localStorage.setItem('user', JSON.stringify(user));
          navigate('/admin-dashboard');
        } else if (user.RoleId === 2) {
          
          localStorage.setItem('employeeId', user.EmployeeId); 
          localStorage.setItem('user', JSON.stringify(user));
          navigate('/user-dashboard');
        } else {
          setError('Invalid role. Contact administrator.');
        }

      } else {
        setError('Invalid email or password');
      }
    } catch (err) {
      setError('Server error. Please try again.');
    }
  };

  return (
    <div className="login-wrapper">
      <div className="login-box">
        <h2>Welcome to Survey App</h2>
        <form onSubmit={handleLogin}>
          <input
            type="email"
            className="input-field"
            placeholder="Enter your email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            autoComplete="username"
          />
          <input
            type="password"
            className="input-field"
            placeholder="Enter your password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            autoComplete="current-password"
          />
          <button type="submit" className="login-btn">Login</button>
          {error && <p className="error-msg">{error}</p>}
        </form>
      </div>
    </div>
  );
};

export default Login;
