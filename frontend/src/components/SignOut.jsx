import React, { useEffect } from 'react';
import { useNavigate } from 'react-router';

function SignOut({ onSignOut }) {
  const navigate = useNavigate();

  useEffect(() => {
    const handleSignOut = async () => {
      try {
        const token = localStorage.getItem('token');
        if (!token) {
          throw new Error('No token found');
        }

        const response = await fetch(
          'http://localhost:3000/users/sign_out',
          {
            method: 'DELETE',
            headers: {
              'Content-Type': 'application/json',
              Accept: 'application/json',
              Authorization: `Bearer ${token}`,
            },
          }
        );

        if (!response.ok) {
          throw new Error('Failed to sign out');
        }

        localStorage.removeItem('token');
        onSignOut();
        navigate('/signin');
      } catch (error) {
        console.error('Sign out error:', error);
      }
    };

    handleSignOut();
  }, [navigate]);

  return <div>Signing out...</div>;
}

export default SignOut;
