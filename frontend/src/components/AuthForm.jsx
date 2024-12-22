import { useState } from 'react';
import {
  TextField,
  Button,
  Container,
  Typography,
} from '@mui/material';
import axios from 'axios';

const AuthForm = ({ isLogin }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const endpoint = isLogin ? '/users/sign_in' : '/users';
      await axios.post(`http://localhost:3000${endpoint}`, {
        user: { email, password },
      });
      alert('Success!');
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <Container>
      <Typography variant="h4">
        {isLogin ? 'Login' : 'Sign Up'}
      </Typography>
      <form onSubmit={handleSubmit}>
        <TextField
          label="Email"
          fullWidth
          margin="normal"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <TextField
          label="Password"
          type="password"
          fullWidth
          margin="normal"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <Button type="submit" variant="contained" color="primary">
          {isLogin ? 'Login' : 'Sign Up'}
        </Button>
      </form>
    </Container>
  );
};

export default AuthForm;
