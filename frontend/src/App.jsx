import { useState, useEffect } from 'react';
import { BrowserRouter, Route, Routes, Link } from 'react-router';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Container from '@mui/material/Container';
import Home from './components/Home';
import NotFound from './components/NotFound';
import SignIn from './components/SignIn';
import SignUp from './components/SignUp';
import SignOut from './components/SignOut';

function Header({ isLoggedIn, userEmail }) {
  return (
    <AppBar position="static">
      <Toolbar>
        <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
          DirectShifts
        </Typography>
        {isLoggedIn ? (
          <>
            <Typography
              variant="body1"
              component="div"
              sx={{ marginRight: 2 }}
            >
              {userEmail}
            </Typography>
            <Button color="inherit" component={Link} to="/">
              Home
            </Button>
            <Button color="inherit" component={Link} to="/signout">
              Sign Out
            </Button>
          </>
        ) : (
          <>
            <Button color="inherit" component={Link} to="/signin">
              Sign In
            </Button>
            <Button color="inherit" component={Link} to="/signup">
              Sign Up
            </Button>
          </>
        )}
      </Toolbar>
    </AppBar>
  );
}

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [userEmail, setUserEmail] = useState('');

  useEffect(() => {
    // Check if the JWT token exists in local storage
    const token = localStorage.getItem('token');
    const email = localStorage.getItem('email');
    if (token) {
      setIsLoggedIn(true);
      setUserEmail(email);
    } else {
      setIsLoggedIn(false);
      setUserEmail('');
    }
  }, []);

  const handleSignOut = () => {
    setIsLoggedIn(false);
    setUserEmail('');
  };

  return (
    <BrowserRouter>
      <Header isLoggedIn={isLoggedIn} userEmail={userEmail} />
      <Container>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route
            path="/signin"
            element={
              <SignIn
                setUserEmail={setUserEmail}
                setIsLoggedIn={setIsLoggedIn}
              />
            }
          />
          <Route
            path="/signup"
            element={
              <SignUp
                setUserEmail={setUserEmail}
                setIsLoggedIn={setIsLoggedIn}
              />
            }
          />
          <Route
            path="/signout"
            element={<SignOut onSignOut={handleSignOut} />}
          />
          <Route path="*" element={<NotFound />} />
        </Routes>
      </Container>
    </BrowserRouter>
  );
}

export default App;
