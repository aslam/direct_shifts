import * as React from 'react';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';
import { BrowserRouter, Route, Routes } from 'react-router';
import Home from './components/Home';
import NotFound from './components/NotFound';
import AuthForm from './components/AuthForm';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<AuthForm isLogin />} />
        <Route
          path="/signup"
          element={<AuthForm isLogin={false} />}
        />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
