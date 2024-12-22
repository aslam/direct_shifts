import React from 'react';
import { Container, Typography, Box } from '@mui/material';

function Home() {
  return (
    <Container
      maxWidth="sm"
      sx={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        height: '100vh',
        backgroundColor: '#f0f0f0',
      }}
    >
      <Box>
        <Typography
          variant="h1"
          component="h1"
          color="textPrimary"
          gutterBottom
        >
          Welcome to DirectShifts
        </Typography>
      </Box>
    </Container>
  );
}

export default Home;
