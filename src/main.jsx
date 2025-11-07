import React from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import VeoUpApp from './VeoUpApp.jsx'

createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <VeoUpApp />
  </React.StrictMode>
)
