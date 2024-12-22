import React, { useState } from 'react';
import {
  Container,
  Button,
  Typography,
  Box,
  TextField,
} from '@mui/material';

function ReferralForm() {
  const [referralEmail, setReferralEmail] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    setError('');
    setMessage('');

    try {
      const response = await fetch(
        'http://localhost:3000/referrals',
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${localStorage.getItem('token')}`,
          },
          body: JSON.stringify({ referral_email: referralEmail }),
        }
      );

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.errors.join(', '));
      }

      setMessage('Referral email sent successfully');
      setReferralEmail('');
    } catch (error) {
      setError(error.message);
    }
  };

  return (
    <Container maxWidth="sm">
      <Box
        sx={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          justifyContent: 'center',
          height: '100vh',
        }}
      >
        <Typography variant="h4" component="h1" gutterBottom>
          Send Referral
        </Typography>
        {message && (
          <Typography variant="body1" color="success" gutterBottom>
            {message}
          </Typography>
        )}
        {error && (
          <Typography variant="body1" color="error" gutterBottom>
            {error}
          </Typography>
        )}
        <form onSubmit={handleSubmit}>
          <TextField
            label="Referral Email"
            variant="outlined"
            margin="normal"
            fullWidth
            value={referralEmail}
            onChange={(e) => setReferralEmail(e.target.value)}
          />
          <Button
            type="submit"
            variant="contained"
            color="primary"
            fullWidth
          >
            Send Referral
          </Button>
        </form>
      </Box>
    </Container>
  );
}

export default ReferralForm;
