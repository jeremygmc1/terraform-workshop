import React from 'react';
import SpringBootPage from './pages/SpringBootPage'
import NestJsPage from './pages/NestJsPage'
import { BrowserRouter as Router, Routes, Route, NavLink, Navigate } from 'react-router-dom';

function App() {
  return (
    <Router>
      <div>
        {/* Topbar */}
        <div className="navbar">
          <div className="nav-links">
          <NavLink 
              to="/springboot" 
              className={({ isActive }) => (isActive ? 'active-link' : '')}
            >
              Spring Boot
            </NavLink>
            <NavLink 
              to="/nestjs" 
              className={({ isActive }) => (isActive ? 'active-link' : '')}
            >
              NestJS
            </NavLink>
          </div>
        </div>

        {/* Routes */}
        <Routes>
          <Route path="/" element={<Navigate to="/springboot" replace />} />
          <Route path="/springboot" element={<SpringBootPage />} />
          <Route path="/nestjs" element={<NestJsPage />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;