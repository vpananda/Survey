import React from 'react';
import { useNavigate } from 'react-router-dom';

const Homepage = () => {
  const navigate = useNavigate();

  return (
    <div style={styles.container}>
      <h1>Welcome to the Survey Application</h1>
      <p>Login to get started with your dashboard</p>
      <button onClick={() => navigate('/login')} style={styles.button}>
        Go to Login
      </button>
    </div>
  );
};

const styles = {
  container: {
    textAlign: 'center',
    marginTop: '100px',
  },
  button: {
    padding: '10px 20px',
    fontSize: '16px',
    cursor: 'pointer',
    marginTop: '20px'
  }
};

export default Homepage;
