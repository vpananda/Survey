import React, { useEffect, useState } from 'react';

const RolesDashboard = () => {
  const [roles, setRoles] = useState([]);
  const [newRole, setNewRole] = useState('');

  const fetchRoles = () => {
    fetch('http://localhost:5000/api/roles/getroles')
      .then(res => res.json())
      .then(data => {
        if (data.status === 'success') {
          setRoles(data.data);
        }
      });
  };

  useEffect(() => {
    fetchRoles();
  }, []);

  const addRole = (e) => {
    e.preventDefault();
    fetch('http://localhost:5000/api/roles/insert', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        RoleName: newRole,
        CreatedBy: 'Admin',
        CreatedDate: new Date().toISOString().split('T')[0],
        ModifiedBy: 'Admin',
        ModifiedDate: new Date().toISOString().split('T')[0]
      })
    }).then(() => {
      setNewRole('');
      fetchRoles();
    });
  };

  const updateRole = (roleId, currentName) => {
    const updatedName = prompt('Enter new role name:', currentName);
    if (updatedName && updatedName !== currentName) {
      fetch('http://localhost:5000/api/roles/update', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          RoleId: roleId,
          RoleName: updatedName,
          IsActive: 1,
          ModifiedBy: 'Admin',
          ModifiedDate: new Date().toISOString().split('T')[0]
        })
      }).then(() => fetchRoles());
    }
  };

  const deleteRole = (roleId) => {
    if (window.confirm('Are you sure to delete this role?')) {
      fetch('http://localhost:5000/api/roles/delete', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          RoleId: roleId,
          ModifiedBy: 'Admin',
          ModifiedDate: new Date().toISOString().split('T')[0]
        })
      }).then(() => fetchRoles());
    }
  };

  return (
    <>
      <h2 style={{ marginBottom: '20px' }}>Manage Roles</h2>

      <form onSubmit={addRole} style={{ marginBottom: '20px', display: 'flex', gap: '10px', flexWrap: 'wrap' }}>
        <input
          type="text"
          value={newRole}
          onChange={(e) => setNewRole(e.target.value)}
          placeholder="Enter Role Name"
          required
        />
        <button type="submit" className="add-btn"> Add Role</button>
      </form>

      <table className='dark-table'>
        <thead>
          <tr>
            <th>Role Name</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {roles.map((role) => (
            <tr key={role.RoleId}>
              <td>{role.RoleName}</td>
              <td>
                <button className="action-btn update-btn" onClick={() => updateRole( role.RoleName)}>✏️ Update</button>
                <button className="action-btn delete-btn" onClick={() => deleteRole(role.RoleId)}>🗑 Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </>
  );
};

export default RolesDashboard;
